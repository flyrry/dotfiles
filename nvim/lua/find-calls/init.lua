-- local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local make_entry = require("telescope.make_entry")
-- local builtin = require("telescope.builtin")

local M = {}

-- Convert a delimited string into camelCase (or PascalCase)
local function split_and_camel_case(str, delim, start_with_lower)
    local parts = vim.split(str, delim, { trimempty = true })
    local result = {}
    for i, part in ipairs(parts) do
        if i == 1 and start_with_lower then
            table.insert(result, part)
        else
            local word = part:gsub("^%l", string.upper)
            table.insert(result, word)
        end
    end
    return table.concat(result)
end

-- Determine the API endpoint from the word under cursor based on known prefixes.
local function get_api_call_under_cursor(word)
    local prefixes = { { "/adminPanel", true }, { "/internal", false }, { "/testOnly", true } }
    for _, prefix in ipairs(prefixes) do
        local needle = prefix[1]
        if word:sub(1, #needle) == needle then
            local keep = prefix[2]
            if not keep then
                word = word:sub(#needle + 1)
            end
            return split_and_camel_case(word, '/', true), needle
        end
    end
    return nil, nil
end

-- Utility to find an existing buffer by path, or open one if requested.
local function find_buffer(path, open)
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_name(bufnr) == path then
            return bufnr
        end
    end
    if open then
        vim.notify("Opening " .. path, vim.log.levels.DEBUG)
        local bufnr = vim.api.nvim_create_buf(false, false)
        vim.api.nvim_buf_set_name(bufnr, path)
        vim.api.nvim_buf_call(bufnr, function() vim.cmd("edit") end)
        return bufnr
    end
    return nil
end

-- Load all files that import the generated file.
-- We now compute the module import string (e.g. "@server-api-async/x_y_z/XYZInternalAsyncApi")
local function load_importer_files(service_name, gen_file_prefix, root)
    local module_import = "@server-api-async/" .. service_name .. "/" .. gen_file_prefix .. "InternalAsyncApi"
    local rg_cmd = string.format("rg --files-with-matches %q %s -t ts --glob '!*-{spec,comp}.ts'", module_import, root)
    local output = vim.fn.systemlist(rg_cmd)
    if vim.v.shell_error ~= 0 or #output == 0 then
        return nil, "No importer files found for module " .. module_import
    end

    local filtered = {}
    for _, file in ipairs(output) do
        if file:match("Bootstrap%.ts$") then
            table.insert(filtered, file)
        end
    end

    if #filtered == 0 then
        return nil, "No importer Bootstrap files found for module " .. module_import
    end

    vim.notify("Found " .. #filtered .. " files importing " .. module_import, vim.log.levels.DEBUG)
    -- for _, file in ipairs(filtered) do
    --     local full_path = vim.fn.fnamemodify(file, ":p")
    --     vim.notify("File: " .. full_path, vim.log.levels.DEBUG)
    -- end
    -- return nil, "Stopped for debug"
    --

    for _, file in ipairs(filtered) do
        local full_path = vim.fn.fnamemodify(file, ":p")
        find_buffer(full_path, true)
    end

    return filtered, nil
end

-- Main function: Find API call references.
M.find_api_call_references = function(opts)
    opts = opts or {}
    local cursor_word = vim.F.if_nil(opts.search, vim.fn.expand("<cfile>"))
    local api_call, prefix = get_api_call_under_cursor(cursor_word)
    if not api_call or api_call == "" then
        vim.notify("Not a valid API call", vim.log.levels.WARN)
        return
    end
    if prefix ~= "/internal" then
        vim.notify("Only internal API calls are supported", vim.log.levels.WARN)
        return
    end

    -- Determine project root (by locating the .git directory)
    local git_dir = vim.fs.find(".git", { upward = true })[1]
    if not git_dir then
        vim.notify("Could not locate project root", vim.log.levels.ERROR)
        return
    end
    local root = vim.fs.dirname(git_dir)

    -- Determine service name from current file location
    local current_file = vim.fn.expand("%:p")
    local service_dir = vim.fs.find("main", { upward = true, path = current_file, type = "directory" })[1]
    if not service_dir then
        vim.notify("Could not determine service directory", vim.log.levels.ERROR)
        return
    end
    local service_name = vim.fs.basename(vim.fs.dirname(service_dir))
    if not service_name or service_name == "" then
        vim.notify("Could not determine service name", vim.log.levels.ERROR)
        return
    end

    -- Build the generated file path based on service name and naming convention.
    local gen_file_prefix = split_and_camel_case(service_name, "_", false)
    local gen_file_path = root .. "/gen/asyncApi/" .. service_name .. "/" .. gen_file_prefix .. "InternalAsyncApi.ts"
    local gen_bufnr = find_buffer(gen_file_path, true)
    if not gen_bufnr then
        vim.notify("Generated file not found: " .. gen_file_path, vim.log.levels.ERROR)
        return
    end

    -- Load importer files using the module import string.
    local importers, err_msg = load_importer_files(service_name, gen_file_prefix, root)
    if not importers then
        vim.notify(err_msg, vim.log.levels.ERROR)
        return
    end

    -- Search the generated file for the API call to get the exact position.
    local lines = vim.api.nvim_buf_get_lines(gen_bufnr, 0, -1, false)
    local found_line, found_col
    for i, line in ipairs(lines) do
        local s, _ = line:find(api_call)
        if s then
            found_line = i - 1 -- LSP expects 0-indexed line number
            found_col = s - 1  -- and 0-indexed column
            break
        end
    end
    if not found_line then
        vim.notify("Could not find API endpoint " .. api_call .. " in generated file", vim.log.levels.ERROR)
        return
    end

    local params = {
        context = { includeDeclaration = true },
        position = { line = found_line, character = found_col },
        textDocument = { uri = vim.uri_from_fname(gen_file_path) }
    }

    -- Issue the LSP request to find references for the endpoint.
    vim.lsp.buf_request(gen_bufnr, "textDocument/references", params, function(err, result, ctx, _)
        if err then
            vim.api.nvim_err_writeln("Error when finding references: " .. err.message)
            return
        end

        local locations = {}
        if result then
            locations = vim.lsp.util.locations_to_items(result, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
        end
        if vim.tbl_isempty(locations) then
            vim.notify("No references found for API endpoint " .. api_call, vim.log.levels.INFO)
            return
        end

        -- Present the references using a Telescope picker.
        pickers.new(opts, {
            prompt_title = "LSP References for " .. api_call,
            finder = finders.new_table {
                results = locations,
                entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
            },
            previewer = conf.qflist_previewer(opts),
            sorter = conf.generic_sorter(opts),
            push_cursor_on_edit = true,
            push_tagstack_on_edit = true,
        }):find()
    end)
end

-- Simple setup function to bind the new function to a key.
M.setup = function()
    vim.keymap.set("n", "<leader><leader>r", M.find_api_call_references, { desc = "[NEW] Find API Call References" })
end

return M

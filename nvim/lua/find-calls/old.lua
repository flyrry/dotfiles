local builtin = require("telescope.builtin")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local make_entry = require "telescope.make_entry"

local M = {}

local split_and_camel_case = function(str, delim, start_with_lower)
    local parts = vim.split(str, delim, { trimempty = true })
    local result = {}
    for i, part in ipairs(parts) do
        if i == 1 and start_with_lower then
            table.insert(result, part)
        else
            local word = string.gsub(part, "^%l", string.upper)
            table.insert(result, word)
        end
    end
    return table.concat(result)
end

local get_api_call_under_cursor = function(cursor_word)
    local result = nil
    local prefixes = { { "/adminPanel", true }, { "/internal", false }, { "/testOnly", true } }
    for _, prefix in ipairs(prefixes) do
        local needle = prefix[1]
        if string.sub(cursor_word, 1, #needle) == needle then
            local keep = prefix[2]
            cursor_word = keep and cursor_word or string.sub(cursor_word, #needle + 1)
            result = split_and_camel_case(cursor_word, '/', true)
            return result, prefix[1]
        end
    end

    return result
end

local function find_buffer(path, open)
    local buffers = vim.api.nvim_list_bufs()

    for _, bufnr in ipairs(buffers) do
        local buf_name = vim.api.nvim_buf_get_name(bufnr)

        if buf_name == path then
            return bufnr
        end
    end

    if open then
        vim.notify("Opening " .. path, vim.log.levels.DEBUG)

        local bufnr = vim.api.nvim_create_buf(false, false)
        vim.api.nvim_buf_set_name(bufnr, path)
        vim.api.nvim_buf_call(bufnr, vim.cmd.edit)
        return bufnr
    end

    return nil
end

M.find_api_calls = function(opts)
    opts = opts or {}
    local cursor_word = vim.F.if_nil(opts.search, vim.fn.expand("<cfile>"))

    local search = get_api_call_under_cursor(cursor_word)

    if not search or search == '' then
        vim.notify("Not a valid API call", vim.log.levels.WARN)
        return
    end

    local root = vim.fs.dirname(vim.fs.find('.git', { upward = true })[1])

    builtin.grep_string({
        search = '\\b' .. search .. '\\b',
        use_regex = true,
        prompt_title = "Grep API Calls (" .. search .. ")",
        search_dirs = { root },
        additional_args = {
            "-t", "ts",
            "--glob", "!*-{comp,spec}.ts",
            "--glob", "!gen/"
        }
    })
end

local load_internal_candidate_buffers = function()
    -- 2. find gen file for that type
    -- NOTE: maybe use vim.fs.root here?
    local service_name = vim.fs.basename(
        vim.fs.dirname(
            vim.fs.find('main', { upward = true, path = vim.fn.expand('%'), type = 'directory' })[1]
        )
    )
    vim.notify("Service: " .. service_name, vim.log.levels.DEBUG)

    local root = vim.fs.dirname(vim.fs.find('.git', { upward = true })[1])
    local gen_file_prefix = split_and_camel_case(service_name, '_', false)
    local bufname = root .. "/gen/asyncApi/" .. service_name .. "/" .. gen_file_prefix .. "InternalAsyncApi.ts"
    local gen_file_bufnr = find_buffer(bufname, true)
    -- 3. find all files referencing that gen file
    -- 4. open them in some hidden buffer
    -- 5. locate the call in the gen file
    -- 6. construct params with that location
    return {
        context = {
            includeDeclaration = true
        },
        position = {
            character = 20, -- TODO:
            line = 156 -- TODO:
        },
        textDocument = {
            uri = "file://" .. bufname
        }
    }
end

-- TODO: test it out on bundles' /internal/expire
M.lsp_find_api_calls = function(opts)
    opts = opts or {}

    -- 1. get call under cursor, including type (internal, adminPanel, testOnly)
    local cursor_word = vim.F.if_nil(opts.search, vim.fn.expand("<cfile>"))
    local api_call, prefix = get_api_call_under_cursor(cursor_word)
    if api_call then
        vim.notify("Searching for " .. api_call .. " in " .. prefix, vim.log.levels.DEBUG)
    end

    if not api_call or api_call == '' then
        vim.notify("Not a valid API call", vim.log.levels.WARN)
        return
    end

    if prefix ~= "/internal" then
        vim.notify("Only internal API calls are supported", vim.log.levels.WARN)
        -- TODO: add support for other types
        return
    end

    -- 2. load internal call's buffers and construct token params
    load_internal_candidate_buffers()

    -- 7. (optional?) wait for LSP to attach and load to all those buffers
    -- 8. do LSP references request with params
    return
end

-- M.quick_test = function()
--     local root = vim.fs.dirname(vim.fs.find('.git', { upward = true })[1])
--     local bufname = root .. "/gen/asyncApi/test_manager/TestManagerInternalAsyncApi.ts"
--     vim.notify("Opening " .. bufname, vim.log.levels.DEBUG)
--
--     local gen_bufnr = vim.api.nvim_create_buf(false, false)
--     vim.api.nvim_buf_set_name(gen_bufnr, bufname)
--     vim.api.nvim_buf_call(gen_bufnr, vim.cmd.edit)
-- end

M.quick_test = function()
    local files = {
        "src/platform/campaign/campaign_bulk_import/main/service/BulkImportService.ts",
        "src/platform/campaign/subscription_benefits/main/internal/service/BirthdayBenefitAutomationService.ts",
        "src/platform/campaign/campaign_archiver/main/server/crons/BulkGroupsArchiverCron.ts",
        "src/platform/campaign/campaign_archiver/test/spec/BulkGroupsArchiverCron-spec.ts",
        "src/platform/campaign/targeting_worker/main/service/TestServiceBase.ts",
    }
    for _, file in ipairs(files) do
        local root = "/Users/sergei/repos/taxify/server/"
        local bufname = root .. file
        find_buffer(bufname, true)
    end
end

M.lookup = function(opts)
    opts = opts or {}
    M.quick_test()
    local root = "/Users/sergei/repos/taxify/server/"
    local bufname = root .. "gen/asyncApi/test_manager/TestManagerInternalAsyncApi.ts"
    local gen_bufnr = find_buffer(bufname, true)
    -- local params = vim.lsp.util.make_position_params(gen_bufnr)
    -- params.context = { includeDeclaration = vim.F.if_nil(opts.include_declaration, true) }
    -- vim.notify(vim.inspect(params))
    local params = {
        context = {
            includeDeclaration = true
        },
        position = {
            character = 20,
            line = 156
        },
        textDocument = {
            uri = "file:///Users/sergei/repos/taxify/server/gen/asyncApi/test_manager/TestManagerInternalAsyncApi.ts"
        }
    }
    vim.lsp.buf_request(gen_bufnr, "textDocument/references", params, function(err, result, ctx, _)
        if err then
            vim.api.nvim_err_writeln("Error when finding references: " .. err.message)
            return
        end

        local locations = {}
        if result then
            local results = vim.lsp.util.locations_to_items(result,
                vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
            locations = vim.F.if_nil(results, {})
        end

        if vim.tbl_isempty(locations) then
            return
        end

        pickers
            .new(opts, {
                prompt_title = "LSP Find API References",
                finder = finders.new_table {
                    results = locations,
                    entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
                },
                previewer = conf.qflist_previewer(opts),
                sorter = conf.generic_sorter(opts),
                push_cursor_on_edit = true,
                push_tagstack_on_edit = true,
            })
            :find()
    end)
end

M.setup = function()
    vim.keymap.set("n", "<leader><leader>c", M.find_api_calls)
    -- vim.keymap.set("n", "<leader><leader>r", M.lsp_find_api_calls)
    vim.keymap.set("n", "<leader><leader>t", M.quick_test)
    vim.keymap.set("n", "<leader><leader>l", M.lookup)
end

return M

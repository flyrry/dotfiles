local M = {}

function M.setup(opts)
  opts = opts or {}
  local keymap = opts.keymap or "<leader>ar"
  vim.api.nvim_set_keymap('n', keymap, '<cmd>FindApiReferences<cr>',
    { noremap = true, silent = true, desc = "Find API References" })
end

function M.find_references()
  -- 1. Get the word under the cursor
  local word = vim.fn.expand('<cword>')
  if not word or word == '' then
    vim.notify("No word under cursor", vim.log.levels.WARN)
    return
  end

  -- 2. Get the current buffer's file path
  local current_file = vim.fn.expand('%:p')
  if not current_file or not current_file:match("Bootstrap.ts") then
    vim.notify("Not in a Bootstrap.ts file.", vim.log.levels.WARN)
    return
  end

  -- 3. Figure out the service name from the file path
  local function find_package_json(start_path)
    local dir = vim.fn.fnamemodify(start_path, ':h')
    while dir ~= '/' and dir ~= '' do
      local pkg_json_path = dir .. '/package.json'
      if vim.fn.filereadable(pkg_json_path) == 1 then
        local content = vim.fn.readfile(pkg_json_path)
        local package_data = vim.fn.json_decode(table.concat(content, '\n'))
        if package_data and package_data.name then
          return package_data.name:match("[^/]+$")
        end
      end
      dir = vim.fn.fnamemodify(dir, ':h')
    end
    return nil
  end

  local service_name = find_package_json(current_file)

  if not service_name then
    vim.notify("Could not determine service name from path: " .. current_file, vim.log.levels.ERROR)
    return
  end
  vim.notify("Found service: " .. service_name, vim.log.levels.INFO)

  -- 4. Find the generated async api file by searching, not by guessing.
  local search_path = "gen/asyncApi/" .. service_name .. "/*InternalAsyncApi.ts"
  local files_str = vim.fn.glob(search_path, true, false)
  local files = vim.fn.split(files_str, "\n")

  if #files == 0 or files[1] == '' then
    vim.notify("No *InternalAsyncApi.ts file found matching " .. search_path, vim.log.levels.ERROR)
    return
  end

  if #files > 1 then
    vim.notify("Multiple *InternalAsyncApi.ts files found. Using the first one: " .. files[1], vim.log.levels.WARN)
  end

  local generated_api_file = files[1]
  vim.notify("Found generated api file: " .. generated_api_file, vim.log.levels.INFO)

  -- 5. Find all services that load this generated file, then filter by API method.
  local import_path = generated_api_file:gsub("%.ts$", ""):gsub("^gen/asyncApi/", "@server-api-async/")
  local file_name_only = vim.fn.fnamemodify(generated_api_file, ':t'):gsub("%.ts$", "")

  local command = "rg --files-with-matches --iglob '*.ts' -e " ..
      vim.fn.shellescape(import_path) .. " -e " .. vim.fn.shellescape(file_name_only) .. " src/"
  local initial_consuming_services_str = vim.fn.system(command)
  local initial_consuming_services_list = vim.fn.split(initial_consuming_services_str, "\n")
  local initial_consuming_services = {}
  for _, file in ipairs(initial_consuming_services_list) do
    if file ~= '' then
      table.insert(initial_consuming_services, file)
    end
  end

  if #initial_consuming_services == 0 then
    vim.notify("No services found that consume " .. generated_api_file, vim.log.levels.WARN)
    return
  end

  vim.notify("Found " .. #initial_consuming_services .. " services importing the client. Filtering by method: " .. word,
    vim.log.levels.INFO)

  -- Filter this list further by grepping for the API method.
  local files_to_search_str = table.concat(initial_consuming_services, " ")
  local filter_command = "rg --files-with-matches -w " .. vim.fn.shellescape(word) .. " " .. files_to_search_str
  local filtered_consuming_services_str = vim.fn.system(filter_command)
  local consuming_services_list = vim.fn.split(filtered_consuming_services_str, "\n")
  local consuming_services = {}
  for _, file in ipairs(consuming_services_list) do
    if file ~= '' then
      table.insert(consuming_services, file)
    end
  end

  if #consuming_services == 0 then
    vim.notify(
      "Found " ..
      #initial_consuming_services .. " services importing the client, but none seem to use the method '" .. word .. "'",
      vim.log.levels.WARN)
    return
  end

  -- 6. Load the generated file and consuming services into hidden buffers.
  local bufnrs = {}
  local generated_api_bufnr = vim.fn.bufadd(generated_api_file)
  table.insert(bufnrs, generated_api_bufnr)
  for _, service_file in ipairs(consuming_services) do
    table.insert(bufnrs, vim.fn.bufadd(service_file))
  end

  for _, bufnr in ipairs(bufnrs) do
    vim.bo[bufnr].buflisted = true
    vim.fn.bufload(bufnr)
  end

  local all_loaded_files = vim.deepcopy(consuming_services)
  table.insert(all_loaded_files, 1, generated_api_file)

  vim.notify("Loaded " .. #bufnrs .. " files into hidden buffers:\n" .. table.concat(all_loaded_files, "\n"),
    vim.log.levels.INFO)

  -- 7. Find the public method definition in the generated_api_file
  local generated_content = vim.fn.readfile(generated_api_file)
  local line_nr = -1
  local col = -1
  for i, line in ipairs(generated_content) do
    local word_start, word_end = line:find(word, 1, true)
    if word_start then
      -- Check if it's a method definition by looking for '(' after it.
      local after_word = line:sub(word_end + 1)
      if after_word:match('^%s*%(') then
        line_nr = i
        col = word_start
        break
      end
    end
  end

  if line_nr == -1 then
    vim.notify("Could not find API call definition for '" .. word .. "' in " .. generated_api_file, vim.log.levels.ERROR)
    return
  end

  vim.notify("Found API call definition at " .. generated_api_file .. ":" .. line_nr .. ":" .. col, vim.log.levels.INFO)

  -- 8. Trigger LSP find references on that line
  local params = {
    textDocument = { uri = vim.uri_from_fname(generated_api_file) },
    position = { line = line_nr - 1, character = col - 1 },
    context = { includeDeclaration = true }
  }

  vim.notify("Searching for references...", vim.log.levels.INFO)

  local function show_references_in_telescope(references, ctx)
    vim.notify("Found " .. #references .. " references for " .. word, vim.log.levels.INFO)
    if not references or vim.tbl_isempty(references) then
      vim.notify("No references found for " .. word, vim.log.levels.WARN)
      return
    end

    local api_call = "TEST"

    local locations = {}
    if references then
      locations = vim.lsp.util.locations_to_items(references, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
    end
    if vim.tbl_isempty(locations) then
      vim.notify("No references found for API endpoint " .. api_call, vim.log.levels.INFO)
      return
    end

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local make_entry = require("telescope.make_entry")
    local opts = {}

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
  end

  vim.lsp.buf_request(generated_api_bufnr, "textDocument/references", params, function(err, result, ctx)
    if err then
      vim.notify("LSP request failed: " .. err.message, vim.log.levels.ERROR)
      return
    end

    show_references_in_telescope(result, ctx)
  end)
end

return M


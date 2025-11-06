local M = {}

local function_node_types = {
    function_definition = true,
    function_declaration = true,
    function_item = true,
    function_statement = true,
    local_function = true,
    method_definition = true,
    method_declaration = true,
    method_item = true,
    method_specification = true,
    constructor_declaration = true,
    constructor_definition = true,
    destructor_definition = true,
    destructor_declaration = true,
}

local identifier_node_types = {
    identifier = true,
    property_identifier = true,
    field_identifier = true,
    method_identifier = true,
    operator_name = true,
    simple_identifier = true,
    name = true,
    word = true,
    symbol = true,
}

local function is_function_node(node)
    if not node then
        return false
    end

    local node_type = node:type()
    if function_node_types[node_type] then
        return true
    end

    if node_type:find("method") then
        return true
    end

    if node_type:find("function") and not node_type:find("call") and not node_type:find("type") then
        return true
    end

    return false
end

local skip_child_types = {
    body = true,
    block = true,
    compound_statement = true,
}

local function find_identifier_node(node)
    if not node then
        return nil
    end

    if identifier_node_types[node:type()] then
        return node
    end

    for _, field_name in ipairs({ "name", "identifier", "declarator" }) do
        local field_nodes = node:field(field_name)
        if field_nodes and field_nodes[1] then
            local field_match = find_identifier_node(field_nodes[1])
            if field_match then
                return field_match
            end
        end
    end

    local named_child_count = node:named_child_count()
    for idx = 0, math.min(named_child_count - 1, 4) do
        local child = node:named_child(idx)
        if child then
            local child_type = child:type()
            if identifier_node_types[child_type] then
                return child
            end
            if not skip_child_types[child_type] then
                local candidate = find_identifier_node(child)
                if candidate then
                    return candidate
                end
            end
        end
    end

    return nil
end

function M.jump_to_current_function_treesitter()
    local ok_ts_utils, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
    if not ok_ts_utils then
        print("nvim-treesitter.ts_utils not available")
        return
    end

    if not vim.treesitter then
        print("Neovim Treesitter API not available")
        return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local parser_ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not parser_ok or not parser then
        print("No Treesitter parser for current buffer")
        return
    end

    parser:parse()

    local node = ts_utils.get_node_at_cursor()
    if not node then
        print("No Treesitter node under cursor")
        return
    end

    local function_node = node
    while function_node and not is_function_node(function_node) do
        function_node = function_node:parent()
    end

    if not function_node then
        print("No enclosing function node found!")
        return
    end

    local outermost_function = function_node
    local ancestor = function_node:parent()
    while ancestor do
        if is_function_node(ancestor) then
            outermost_function = ancestor
        end
        ancestor = ancestor:parent()
    end

    local name_node = find_identifier_node(outermost_function)
    local target_node = name_node or outermost_function
    local start_row, start_col = target_node:start()
    vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
end

--- Jump to the enclosing function/method name using LSP document symbols.
function M.jump_to_current_function_lsp()
    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    local results = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params, 1000)
    if not results or vim.tbl_isempty(results) then
        print("No LSP document symbols available")
        return
    end

    local cursor = vim.api.nvim_win_get_cursor(0)
    local current_line = cursor[1] - 1
    local current_col = cursor[2]

    -- Only allow symbols for methods and functions.
    local allowed_kinds = {
        [6] = true,  -- Method
        [12] = true, -- Function
    }

    local function symbol_encloses(symbol)
        local start, finish
        if symbol.range then
            start = symbol.range.start
            finish = symbol.range["end"]
        elseif symbol.location and symbol.location.range then
            start = symbol.location.range.start
            finish = symbol.location.range["end"]
        else
            return false
        end
        if (current_line > start.line or (current_line == start.line and current_col >= start.character))
            and (current_line < finish.line or (current_line == finish.line and current_col <= finish.character)) then
            return true
        end
        return false
    end

    local best_symbol = nil

    local function range_size(r)
        return (r["end"].line - r.start.line) * 1000 + (r["end"].character - r.start.character)
    end

    local function process_symbol(symbol)
        if symbol_encloses(symbol) then
            if allowed_kinds[symbol.kind] then
                if not best_symbol then
                    best_symbol = symbol
                else
                    local sym_range = symbol.range or (symbol.location and symbol.location.range)
                    local best_range = best_symbol.range or (best_symbol.location and best_symbol.location.range)
                    if sym_range and best_range and range_size(sym_range) < range_size(best_range) then
                        best_symbol = symbol
                    end
                end
            end
            if symbol.children then
                for _, child in ipairs(symbol.children) do
                    process_symbol(child)
                end
            end
        end
    end

    for _, resp in pairs(results) do
        local symbols = resp.result
        if symbols and vim.islist(symbols) then
            for _, symbol in ipairs(symbols) do
                process_symbol(symbol)
            end
        end
    end

    if best_symbol then
        local target_pos
        if best_symbol.selectionRange then
            target_pos = best_symbol.selectionRange.start
        elseif best_symbol.range then
            target_pos = best_symbol.range.start
        elseif best_symbol.location and best_symbol.location.range then
            target_pos = best_symbol.location.range.start
        end
        if target_pos then
            vim.api.nvim_win_set_cursor(0, { target_pos.line + 1, target_pos.character })
        else
            print("Could not determine target position for the symbol.")
        end
    else
        print("No enclosing function symbol found!")
    end
end

function M.setup(opts)
    opts = opts or {}
    local lsp_key = opts.lsp_keymap or opts.keymap or "<leader>j"
    local treesitter_key = opts.treesitter_keymap
        or opts.ts_keymap
        or opts.keymap_treesitter
        or "<leader>J"

    if lsp_key then
        vim.keymap.set(
            "n",
            lsp_key,
            M.jump_to_current_function_lsp,
            { noremap = true, silent = true, desc = "Jump to current function/method name (LSP)" }
        )
    end

    if treesitter_key then
        vim.keymap.set(
            "n",
            treesitter_key,
            M.jump_to_current_function_treesitter,
            { noremap = true, silent = true, desc = "Jump to current function/method name (Treesitter)" }
        )
    end
end

return M

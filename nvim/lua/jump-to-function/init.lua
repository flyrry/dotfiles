local M = {}

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

--- Setup the plugin.
--- @param opts table: A table of options. You can specify:
---   - keymap: the key mapping to use (defaults to "<leader>j").
function M.setup(opts)
    opts = opts or {}
    vim.keymap.set("n", opts.keymap or "<leader>j", M.jump_to_current_function_lsp, { noremap = true, silent = true })
end

return M

-- tree-sitter version
-- -- Recursive helper to find a child node representing the function/method name.
-- local function find_function_name_node(node)
--     local name_node_types = { identifier = true, property_identifier = true }
--     for i = 0, node:child_count() - 1 do
--         local child = node:child(i)
--         if child and name_node_types[child:type()] then
--             return child
--         end
--     end
--     -- Fallback: search deeper recursively in case the name node isn't an immediate child.
--     for i = 0, node:child_count() - 1 do
--         local child = node:child(i)
--         local result = find_function_name_node(child)
--         if result then
--             return result
--         end
--     end
--     return nil
-- end
--
-- local function jump_to_current_function()
--     -- Get current cursor position (Treesitter uses 0-indexed rows)
--     local cursor = vim.api.nvim_win_get_cursor(0)
--     local row = cursor[1] - 1
--     local col = cursor[2]
--
--     local bufnr = vim.api.nvim_get_current_buf()
--     local lang = vim.bo.filetype
--
--     -- Get the parser for the current buffer and parse the tree
--     local parser = vim.treesitter.get_parser(bufnr, lang)
--     local tree = parser:parse()[1]
--     local root = tree:root()
--
--     -- Find the smallest node covering the cursor
--     local node = root:descendant_for_range(row, col, row, col)
--
--     -- Node types that represent functions or methods.
--     local function_types = {
--         function_declaration = true,
--         function_definition  = true,
--         method_declaration   = true,
--         method_definition    = true,
--         ["function"]         = true, -- some grammars use "function"
--         function_item        = true, -- for Rust
--     }
--
--     -- Traverse upward until a function/method node is found.
--     while node do
--         if function_types[node:type()] then
--             -- Try to find the node that contains the function/method name.
--             local name_node = find_function_name_node(node)
--             if name_node then
--                 local name_row, name_col = name_node:range()
--                 vim.api.nvim_win_set_cursor(0, { name_row + 1, name_col })
--             else
--                 -- Fallback: jump to the start of the function node if no name is found.
--                 local start_row, start_col = node:range()
--                 vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
--             end
--             return
--         end
--         node = node:parent()
--     end
--
--     print("No enclosing function or method found!")
-- end
--
-- -- Set keybind using vim.keymap.set (for example, mapping to <leader>j)
-- vim.keymap.set("n", "<leader>j", jump_to_current_function, { noremap = true, silent = true })

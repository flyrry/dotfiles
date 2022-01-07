local saga = require 'lspsaga'

saga.init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    border_style = "round",
    code_action_prompt = {
        enable = false
    },
    code_action_keys = {
        quit = '<ESC>'
    },
    rename_action_keys = {
        quit = '<ESC>'
    }
}

local wk = require("which-key")
wk.register({
    ["<leader>"] = {
        ["do"] = {':Lspsaga code_action<CR>', "Do Code Action"},
        ["rn"] = {':Lspsaga rename<CR>', "Rename"},
        --["hd"] = {':Lspsage preview_definition<CR>', "Preview Definition"},
        e = {
            n = {':Lspsaga diagnostic_jump_next<CR>', "Next Diagnostic"},
            p = {':Lspsaga diagnostic_jump_prev<CR>', "Prev Diagnostic"},
            e = {':Lspsaga show_line_diagnostics<CR>', "Show Diagnostic"},
        },
    },
    ["<C-f>"] = {':lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', "Saga Scroll Down"},
    ["<C-b>"] = {':lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', "Saga Scroll Up"},
    K = {':Lspsaga hover_doc<CR>', "Hover Documentation"},
    ["gh"] = {':Lspsaga lsp_finder<CR>', "LSP Finder"},
})

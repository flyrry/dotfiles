if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
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
    }
}
EOF

nnoremap <silent><leader>do <cmd>Lspsaga code_action<CR>
nnoremap <silent>K <cmd>Lspsaga hover_doc<CR>
inoremap <silent><C-k> <cmd>Lspsaga signature_help<CR>
nnoremap <silent><leader>rn <cmd>Lspsaga rename<CR>
nnoremap <silent><leader>en <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent><leader>ep <cmd>Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent><leader>ee <cmd>Lspsaga show_line_diagnostics<CR>
nnoremap <silent><leader>hd <cmd>Lspsage preview_definition<CR>
nnoremap <silent><C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent><C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

nnoremap <silent>gh <cmd>Lspsaga lsp_finder<CR>

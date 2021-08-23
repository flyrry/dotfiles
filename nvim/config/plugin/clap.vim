if !exists('g:loaded_clap') | finish | endif

let g:clap_layout = { 'relative': 'editor' }
let g:clap_current_selection_sign = { 'text': '->', 'texthl': "ClapCurrentSelectionSign", "linehl": "ClapCurrentSelection"}

nnoremap <silent><leader>fb :Clap buffers<CR>
nnoremap <silent><leader>fo :Clap history<CR>
nnoremap <silent><leader>fm :Clap git_diff_files<CR>
nnoremap <silent><leader>ff :Clap files<CR>
nnoremap <silent><leader>fs :Clap grep<CR>

if !exists('g:loaded_clap_lsp') | finish | endif
lua << EOF
vim.lsp.handlers['textDocument/codeAction']     = require'clap-lsp.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/definition']     = require'clap-lsp.locations'.definition_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'clap-lsp.symbols'.document_handler
vim.lsp.handlers['textDocument/references']     = require'clap-lsp.locations'.references_handler
vim.lsp.handlers['workspace/symbol']            = require'clap-lsp.symbols'.workspace_handler
EOF
nnoremap <silent><leader>gr :lua vim.lsp.buf.references()<CR>

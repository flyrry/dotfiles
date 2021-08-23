" Set default width for Nerdtree window
let g:NERDTreeWinSize = 42
" Hide the Nerdtree status line to avoid clutter
let g:NERDTreeStatusline = ''
" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1
" Show hidden files/directories
let g:NERDTreeShowHidden = 1
" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.map$']
" Quit neovim if NERDTree is the only window remaining
autocmd! BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

lua << EOF
require("which-key").register({
    ["<leader>n"] = {
        t = {':NERDTreeToggle<Bar>wincmd p<CR>', "Toggle NERDTree"},
        f = {':NERDTreeFind<Bar>wincmd p<CR>', "Find in NERDTree"},
    }
})
EOF

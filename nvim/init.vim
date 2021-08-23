" always source these
source $HOME/.config/nvim/config/plugins.vim
source $HOME/.config/nvim/config/settings.vim
source $HOME/.config/nvim/config/mappings.vim

" plugin configs
source  $HOME/.config/nvim/config/plugin/airline.vim
"source $HOME/.config/nvim/config/plugin/clap.vim
source  $HOME/.config/nvim/config/plugin/fugitive.vim
"source $HOME/.config/nvim/config/plugin/fzf.vim
luafile $HOME/.config/nvim/config/plugin/gitsigns.lua
source  $HOME/.config/nvim/config/plugin/goyo-limelight.vim
luafile $HOME/.config/nvim/config/plugin/lspconfig.lua
luafile $HOME/.config/nvim/config/plugin/lspsaga.lua
"source $HOME/.config/nvim/config/plugin/lsputils.vim
source  $HOME/.config/nvim/config/plugin/nerdtree.vim
"source $HOME/.config/nvim/config/plugin/nvimtree.vim
source  $HOME/.config/nvim/config/plugin/startify.vim
luafile $HOME/.config/nvim/config/plugin/telescope.lua
source  $HOME/.config/nvim/config/plugin/tmuxline.vim
luafile $HOME/.config/nvim/config/plugin/treesitter.lua
luafile $HOME/.config/nvim/config/plugin/whichkey.lua

"{{{
" === CHEAT SHEET ===
" --- splits ---
" {N}c-w _ # max out the height of the current split (or set to N)
" {N}c-w | # max out the width of the current split (or set to N)
" c-w = # normalize all split sizes
" c-w r # swap left/right or top/bottom splits
" {N}c-w + # increase window height by one (or by N)
" {N}c-w - # decrease window height by one (or by N)
" {N}c-w > # increase window width by one (or by N)
" {N}c-w < # decrease window width by one (or by N)
" --- mappings ---
"  S # replace
" --- plugins ---
" :.Gbrowse # open browser with current line highlighted
" :.Gbrowse! # copy URL
" :go # focus mode toggle
" ,tl # list TODOs in location window (:lcl closes it)
"
"}}}

" vim: foldmethod=marker:foldenable:

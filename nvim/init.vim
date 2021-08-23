" always source these
"source $HOME/.config/nvim/config/plugins.vim
luafile $HOME/.config/nvim/lua/plugins.lua
source $HOME/.config/nvim/config/settings.vim
source $HOME/.config/nvim/config/mappings.vim

" plugin configs
" source $HOME/.config/nvim/config/plugin/airline.vim
" source $HOME/.config/nvim/config/plugin/tmuxline.vim
" source $HOME/.config/nvim/config/plugin/goyo-limelight.vim
" source $HOME/.config/nvim/config/plugin/fugitive.vim
" "source $HOME/.config/nvim/config/plugin/fzf.vim
" luafile $HOME/.config/nvim/config/plugin/treesitter.lua
" luafile $HOME/.config/nvim/config/plugin/gitsigns.lua
" luafile $HOME/.config/nvim/config/plugin/whichkey.lua

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

" ctrl-p like fuzzy search (should be faster)
set rtp+=/usr/local/opt/fzf

" vim: foldmethod=marker:foldenable:

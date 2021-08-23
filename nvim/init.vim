" always source these
luafile $HOME/.config/nvim/lua/plugins.lua
source $HOME/.config/nvim/config/settings.vim
source $HOME/.config/nvim/config/mappings.vim

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
"set rtp+=/usr/local/opt/fzf

" vim: foldmethod=marker:foldenable:

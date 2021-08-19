" Edit neovim configuration
nnoremap <Leader>fed :e ~/.config/nvim/init.vim<CR>
" Reload neovim configuration
nnoremap <Leader>fer :so ~/.config/nvim/init.vim<CR>
" clear highlighted search terms while preserving history
nmap <silent> <leader>/ :nohlsearch<CR>
" ignore line wrapping when navigating in normal mode
" (just in case if wrap will be enabled)
nmap <silent>j gj
nmap <silent>k gk

" S is now replace
nnoremap S "_diwP

" split shortcuts
nnoremap <silent><leader>v :vsplit<CR>
nnoremap <silent><leader>s :split<CR>

" easier split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" map F5 to insert date and time
:nnoremap <F7> "=strftime("%d.%m.%Y %H:%M:%S")<CR>P
:inoremap <F7> <C-R>=strftime("%d.%m.%Y %H:%M:%S")<CR>
" map F6 to insert date
:nnoremap <F6> "=strftime("%d.%m.%Y")<CR>P
:inoremap <F6> <C-R>=strftime("%d.%m.%Y")<CR>
" map F7 to insert time
:nnoremap <F5> "=strftime("%H:%M:%S")<CR>P
:inoremap <F5> <C-R>=strftime("%H:%M:%S")<CR>

" ===== TODO ====={{{
:nnoremap <leader>tl :lvim /\CTODO/ % \| lw<CR>
:nnoremap <leader>tt :lvim /\CTHEN/ % \| lw<CR>
:nnoremap <leader>tf :exec ":lvim /".input("Search string: ")."/ % \| lw"<CR>
:nnoremap <leader>tc :s /- \[TODO\]/\+/<CR>
:nnoremap <leader>tC :s /- \[TODO\]/\+/<CR>dd/DONE<CR>p
"}}}

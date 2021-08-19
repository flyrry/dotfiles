"if !exists('g:loaded_fzf_vim')
"    echom 'Not loaded fzf'
"    finish
"endif
"
"command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
" Browse currently open buffers
" nnoremap <silent><leader>fb :Buffers<CR>
" Browse list of files in current directory under git control (ctrl-P for all files)
"nnoremap <silent><leader>fg :GFiles!<CR>
" Search in modified files under git control (deprecated, see ',ghm')
"nnoremap <silent><leader>fm :GFiles?<CR>
" Search current directory for occurences of given term and close window if no results
"nnoremap <silent><leader>fs :Rg<CR>
" Search current directory for occurences of word under cursor
"nnoremap <silent><leader>fw :Rg <C-R><C-W><CR>
"nnoremap <silent><C-p> :Files<CR>

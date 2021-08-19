if !exists("coccocococ") | finish | endif

" ===== CoC (language server support) ====={{{
function! _disable_coc_for_now()
"set tagfunc=CocTagFunc

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent><leader>en <Plug>(coc-diagnostic-next)
nmap <silent><leader>ep <Plug>(coc-diagnostic-prev)

" remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>do <Plug>(coc-codeaction)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
"nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <tab> to trigger completion and navigate to the next complete item
"function! s:check_back_space() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"
"inoremap <silent><expr> <TAB>
"    \ pumvisible() ? "\<C-n>" :
"    \ <SID>check_back_space() ? "\<TAB>" :
"    \ coc#refresh()
"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

"nnoremap <nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
"nnoremap <nowait><expr> <C-r> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-r>"

endfunction
"}}}

" disable git branch info
let g:airline_section_b = ""

" don't care about filetype
let g:airline_section_x = ""

" don't care about file encoding
let g:airline_section_y = ""

let g:airline_section_z = "%p%% %{g:airline_symbols.linenr} %#__accent_bold#%l/%L%#__restore__# : %v/%{strlen(getline('.'))}"

scriptencoding utf-8
" syntax highlighting
syntax on
" enable detection, plugins and indenting in one step
filetype plugin indent on

" set leader to ,
let g:mapleader=','
" (beta feature?)
let g:markdown_folding = 1

" turn off old regexp engine
set re=0
" enable mouse
set mouse=a
" show line numbers
set number
" show search matches as you type
set incsearch
" highlight search terms
set hlsearch
" ignore case when searching
set ignorecase
" ignore case if search pattern is lowercase, case sensitive otherwise
set smartcase
" open new split panes to right and bottom, which feels more natural than Vim’s default
set splitright
set splitbelow
" expand tabs by default (overloadable per file type later if needed)
set expandtab
" indentation amount for < and > commands.
set shiftwidth=4
" change number of spaces that a <Tab> counts for during editing ops
set softtabstop=4
" a tab is this many spaces
"set tabstop=4
" DO wrap long lines
set wrap
" highlight cursor line
set cursorline
" Toggle cursorline when entering and leaving insert mode
au InsertEnter * set nocursorline
au InsertLeave * set cursorline
" highlight cursor column
"set cursorcolumn
" hides buffers instead of closing them
"set hidden
" automatically reads file if change is detected outside of vim
set autoread
" automatically save when switching between buffers
"set autowrite
" folds expanded on file load
set nofoldenable
" yank and paste with the system clipboard
"set clipboard^=unnamed,unnamedplus
" Why would terminals want line numbers???
"au TermOpen * setlocal nonumber norelativenumber
" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile
" better history
set history=10000
" Enable true color support
set termguicolors

"colors solarized
"colors gruvbox
"colors gruvbox-material
colors sonokai
let g:sonokai_style='default'
let g:sonokai_enable_italic = 1
"colorscheme oceanicnext

set background=dark
" change terminal's title
set title
" use fancy brackets to fold regions
"set foldmethod=manual
set foldmethod=syntax
"set foldmethod=indent
" show distance from current line to other lines
set relativenumber
" always show what mode we are currently editing in
set showmode
" reset mouse setting; this enables OS to scan selection and CMD+C works
set mouse=
" keep 4 lines off the edges of the screen when scrolling
set scrolloff=4
" always set autoindenting on
set autoindent
" do smart autoindenting when starting a new line
set smartindent
" always show status line
set laststatus=2
" self explanatory, right?
set encoding=utf-8
" no more backup files
"set nobackup
set wildignore+=*.o,*.swp
" seriously, stop beeping
set noerrorbells

set completeopt=menu,menuone,noselect,noinsert

set showmatch

set backspace=indent,eol,start
set cinoptions=l1,g0

set grepprg=rg\ --vimgrep

set spellfile=~/.vim/spell/overrides.utf-8.add
autocmd FileType gitcommit setlocal spell
"autocmd FileType markdown setlocal spell
"autocmd FileType org setlocal spell

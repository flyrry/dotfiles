-- set leader key
vim.g.mapleader=','
-- (beta feature?)
vim.g.markdown_folding=1

-- turn off old regexp engine
vim.o.re=0
-- enable mouse
vim.o.mouse=a
-- show line numbers
vim.o.number=true
-- show search matches as you type
vim.o.incsearch=true
-- highlight search terms
vim.o.hlsearch=true
-- ignore case when searching
vim.o.ignorecase=true
-- ignore case if search pattern is lowercase, case sensitive otherwise
vim.o.smartcase=true
-- open new split panes to right and bottom, which feels more natural than Vim’s default
vim.o.splitright=true
vim.o.splitbelow=true
-- expand tabs by default (overloadable per file type later if needed)
vim.o.expandtab=true
-- indentation amount for < and > commands.
vim.o.shiftwidth=4
-- change number of spaces that a <Tab> counts for during editing ops
vim.o.softtabstop=4
-- a tab is this many spaces
--vim.o.tabstop=4
-- DO wrap long lines
vim.o.wrap=true
-- highlight cursor line
vim.o.cursorline=true
-- Toggle cursorline when entering and leaving insert mode
vim.cmd('au InsertEnter * set nocursorline')
vim.cmd('au InsertLeave * set cursorline')
-- highlight cursor column
--set cursorcolumn
-- hides buffers instead of closing them
--set hidden
-- automatically reads file if change is detected outside of vim
vim.o.autoread=true
-- automatically save when switching between buffers
--set autowrite
-- folds expanded on file load
vim.o.nofoldenable=true
-- enable true color support
vim.o.termguicolors=true
-- better history
vim.o.history=10000
-- disable swapfiles
vim.o.swapfile=false
-- backup
vim.o.backupdir='~/.local/share/nvim/backup' -- don't put backups in current dir
vim.o.backup=true
-- change terminal's title
--vim.o.title
vim.o.foldmethod='syntax'
-- show distance from current line to other lines
vim.o.relativenumber=true
-- always show what mode we are currently editing in
vim.o.showmode=true
-- reset mouse setting; this enables OS to scan selection and CMD+C works
vim.o.mouse=''
-- keep 4 lines off the edges of the screen when scrolling
vim.o.scrolloff=4
-- always set autoindenting on
vim.o.autoindent=true
-- do smart autoindenting when starting a new line
vim.o.smartindent=true
-- always show status line
vim.o.laststatus=2
vim.o.encoding='utf-8'
--set wildignore+=*.o,*.swp
-- seriously, stop beeping
vim.o.noerrorbells=true
vim.o.completeopt='menu,menuone,noselect,noinsert'
vim.o.showmatch=true
vim.o.backspace='indent,eol,start'
vim.o.cinoptions='l1,g0'
vim.o.undofile=true
vim.o.undolevels=3000
vim.o.undoreload=10000
vim.o.grepprg='rg --vimgrep'
vim.o.spellfile='~/.vim/spell/overrides.utf-8.add'

vim.cmd([[autocmd FileType gitcommit setlocal spell]])
--vim.cmd([[autocmd FileType markdown setlocal spell]])
--vim.cmd([[autocmd FileType org setlocal spell]])

-- set leader key
vim.g.mapleader = ','

vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 2 -- N lines at the screen edges when scrolling
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true
--vim.o.splitright = true
vim.o.splitbelow = true
vim.o.expandtab = true
vim.o.cursorline = true
vim.o.cursorlineopt = 'number'
vim.o.signcolumn = 'yes'
vim.o.autoread = true -- automatically read file when changed outside vim

--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.o.clipboard = 'unnamedplus' -- use system clipboard
end)

vim.o.undofile = true
vim.o.completeopt = 'menu,menuone,noselect,noinsert'
vim.o.swapfile = false

vim.o.re = 0 -- turn off old regexp engine
vim.o.mouse = ''

-- indentation amount for < and > commands.
vim.o.shiftwidth = 4
-- change number of spaces that a <Tab> counts for during editing ops
vim.o.softtabstop = 4
-- folds expanded on file load
vim.o.foldenable = false
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- don't show the mode, since it's already in the status line
vim.o.showmode = false
-- do smart autoindenting when starting a new line
vim.o.smartindent = true
-- always show status line
vim.o.laststatus = 3
vim.o.encoding = 'utf-8'
-- seriously, stop beeping
vim.o.errorbells = false
vim.o.showmatch = true
vim.o.backspace = 'indent,eol,start'
vim.o.grepprg = 'rg --vimgrep'
vim.o.breakindent = true
vim.o.inccommand = 'split'
vim.o.updatetime = 300

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.g.markdown_folding = 1

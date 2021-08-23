call plug#begin()

" themes
Plug 'sainnhe/gruvbox-material'
Plug 'mhartington/oceanic-next'
Plug 'overcache/NeoSolarized'
Plug 'sainnhe/sonokai'

" utility
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-airline/vim-airline'
Plug 'folke/which-key.nvim'

" tools
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
"Plug 'junegunn/fzf.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/goyo.vim' " focus mode (use :Goyo to toggle)
Plug 'junegunn/limelight.vim' " highlights active paragraph (use together with 'goyo')

Plug 'nvim-lua/popup.nvim' " dependency
Plug 'nvim-lua/plenary.nvim' " dependency
Plug 'nvim-telescope/telescope.nvim'
Plug 'lewis6991/gitsigns.nvim'

" new
"Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
"Plug 'goolord/nvim-clap-lsp'
"
"Plug 'RishabhRD/popfix'
"Plug 'RishabhRD/nvim-lsputils'
"
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
"
Plug 'mhinz/vim-startify'

" to try
" Plug 'tpope/vim-dispatch'


call plug#end()

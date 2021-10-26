local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'ntpeters/vim-better-whitespace'
    use 'tpope/vim-surround'
    use 'editorconfig/editorconfig-vim'
    use 'christoomey/vim-tmux-navigator'
    use 'AndrewRadev/splitjoin.vim'
    use {
        'vim-airline/vim-airline',
        config = function() vim.cmd([[source $HOME/.config/nvim/config/plugin/airline.vim]]) end
    }
    use {
        'folke/which-key.nvim',
        config = function() require('which-key').setup() end
    }
    use {
        'neovim/nvim-lspconfig',
        config = function() require('plugin.lspconfig') end
    }
    use {
        'tami5/lspsaga.nvim',
        config = function() require('plugin.lspsaga') end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugin.treesitter') end
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('plugin.nvimtree') end
    }
    use {
        'tpope/vim-fugitive',
        config = function() require('plugin.fugitive') end
    }
    use 'tpope/vim-rhubarb'
    use {
        'edkolev/tmuxline.vim',
        config = function() vim.cmd([[source $HOME/.config/nvim/config/plugin/tmuxline.vim]]) end
    }
    use {
        'junegunn/limelight.vim',
        requires = {'junegunn/goyo.vim'},
        config = function() require('plugin.goyo-limelight') end
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        config = function() require('plugin.telescope') end
    }
    use {
        'mhinz/vim-startify',
        config = function() require('plugin.startify') end
    }
    use 'plasticboy/vim-markdown'
    use {
        'kristijanhusak/orgmode.nvim',
        config = function() require('plugin.orgmode') end
    }
    use {
        'phaazon/hop.nvim',
        config = function() require('plugin.hop') end
    }

-- themes
    use 'sainnhe/sonokai'
    -- use 'sainnhe/gruvbox-material'
    -- use 'mhartington/oceanic-next'
    -- use 'overcache/NeoSolarized'

-- to try
    --use 'tpope/vim-dispatch'
    --use 'sindrets/diffview.nvim'
    --use 'folke/trouble.nvim'
    --use 'pwntester/octo.nvim'

-- retired
    ---- pop-up gets stuck sometimes
    --use 'ray-x/lsp_signature.nvim'

    ---- multiple issues:
    ---- 1. snippets error when trying to complete; I don't even have snippets
    ---- 2. complete erases text or replaces with '0'
    --use {
    --    'hrsh7th/nvim-cmp',
    --    requires = {
    --        'hrsh7th/cmp-nvim-lsp',
    --        'hrsh7th/cmp-path'
    --        --'hrsh7th/cmp-buffer',
    --        --'hrsh7th/cmp-nvim-lua',
    --    },
    --    config = function() require('plugin.nvim-cmp') end
    --}

    ---- errors in non-git controlled directories
    --use {
    --    'lewis6991/gitsigns.nvim',
    --    requires = {'nvim-lua/plenary.nvim'},
    --    config = function() require('gitsigns').setup({current_line_blame = true}) end
    --}

    ---- feels incomplete for now, external binaries
    --use {'liuchengxu/vim-clap', run = ':Clap install-binary'}
    --use 'goolord/nvim-clap-lsp'

    ---- no issues with these
    --use 'RishabhRD/popfix'
    --use 'RishabhRD/nvim-lsputils'
    --use {
    --    'junegunn/fzf.vim',
    --    config = function() require('plugin.fzf') end
    --}
    --use {
    --    'scrooloose/nerdtree',
    --    cmd = {'NERDTreeToggle', 'NERDTreeFind'},
    --    config = function() require('plugin.nerdtree') end
    --}
    --require('which-key').register({
    --    ["<leader>n"] = {
    --        t = {':NERDTreeToggle<Bar>wincmd p<CR>', 'Toggle Tree'},
    --        f = {':NERDTreeFind<Bar>wincmd p<CR>', 'Find In Tree'}
    --    }
    --})
end)

--vim.cmd([[autocmd BufWritePost plugins.lua | PackerCompile]])
vim.cmd(
    [[
    augroup Packer
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
    ]]
)

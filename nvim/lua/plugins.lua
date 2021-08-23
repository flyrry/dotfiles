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
        config = function()
            vim.g.airline_section_z = "%p%% %{g:airline_symbols.linenr} %#__accent_bold#%l/%L%#__restore__# : %v/%{strlen(getline('.'))}"
        end
    }
    use {
        'folke/which-key.nvim',
        config = function() require('which-key').setup() end
    }
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'nvim-lua/completion-nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugin.treesitter') end
    }
    use {
        'scrooloose/nerdtree',
        cmd = {'NERDTreeToggle', 'NERDTreeFind'},
        config = function() require('plugin.nerdtree') end
    }
    require('which-key').register({
        ["<leader>n"] = {
            t = {':NERDTreeToggle<Bar>wincmd p<CR>', 'Toggle Tree'},
            f = {':NERDTreeFind<Bar>wincmd p<CR>', 'Find In Tree'}
        }
    })

    use {
        'tpope/vim-fugitive',
        config = function() require('plugin.fugitive') end
    }
    use 'tpope/vim-rhubarb'
    use {
        'junegunn/fzf.vim',
        config = function() require('plugin.fzf') end
    }
    use {
        'edkolev/tmuxline.vim',
        config = function()
            vim.cmd([[source $HOME/.config/nvim/lua/plugin/tmuxline.vim]])
        end
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
--  use {'liuchengxu/vim-clap', run = ':Clap install-binary'}
    use 'goolord/nvim-clap-lsp'
    use 'RishabhRD/popfix'
    use 'RishabhRD/nvim-lsputils'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup() end
    }
    use {
        'mhinz/vim-startify',
        config = function() require('plugin.startify') end
    }

    -- themes
    use 'sainnhe/sonokai'
--    use 'sainnhe/gruvbox-material'
--    use 'mhartington/oceanic-next'
--    use 'overcache/NeoSolarized'

    -- to try
--  use 'tpope/vim-dispatch'
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

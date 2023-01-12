return {
    'ntpeters/vim-better-whitespace',
    'christoomey/vim-tmux-navigator',
    'machakann/vim-highlightedyank',
    {
        'vim-airline/vim-airline',
        enabled = false,
        config = function()
            vim.cmd([[source $HOME/.config/nvim/config/plugin/airline.vim]])
        end
    },
    {
    -- pop-up gets stuck sometimes
        'ray-x/lsp_signature.nvim',
        config = function()
            require('lsp_signature').setup({
                hint_prefix = '❯❯❯ ',
                toggle_key = '<C-k>',
            })
        end
    },
    {
        'mhinz/vim-startify',
        config = function()
            vim.g.startify_change_to_dir = false
            vim.g.startify_enable_special = false
            vim.g.startify_fortune_use_unicode = true
            vim.g.startify_custom_indices = {'f', 'h', 'n', 'm', 'd', 'a', 'y'}
            vim.g.startify_custom_header = [[startify#fortune#quote()]]
            vim.g.startify_lists = {
                {['type'] = 'dir', ['header'] = {"   MRU " .. vim.fn.getcwd()}},
                {['type'] = 'files', ['header'] = {"   MRU"}},
                {['type'] = 'sessions', ['header'] = {"   Sessions"}, ['indices'] = {'l'}},
            }
        end
    },
    {
        'j-hui/fidget.nvim', -- lsp loading progress indicators
        config = function() require('fidget').setup() end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
            parser_config.org = {
                install_info = {
                    url = 'https://github.com/milisims/tree-sitter-org',
                    revision = 'main',
                    files = {'src/parser.c', 'src/scanner.cc'},
                },
                filetype = 'org',
            }

            require('orgmode').setup_ts_grammar()

            require'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = true,
                    disable = {'org'},
                    --additional_vim_regex_highlighting = {'org'},
                },
                indent = {
                    enable = false,
                    disable = {},
                },
                ensure_installed = {
                    'cpp',
                    'fish',
                    'lua',
                    'vim',
                    'org',
                    'php',
                    'python',
                    'rust',
                    'tsx',
                    'typescript',
                },
            }
        end
    },

    {
        'junegunn/limelight.vim',
        lazy = true,
        dependencies = {'junegunn/goyo.vim'},
        keys = {
            {'go', ':Goyo<CR>', desc = 'Toggle Focus Mode'},
        },
        config = function()
            vim.cmd([[autocmd! User GoyoEnter Limelight]])
            vim.cmd([[autocmd! User GoyoLeave Limelight!]])
        end
    },
    {
        'scrooloose/nerdtree',
        lazy = true,
        keys = {
            {'<leader>nt', ':NERDTreeToggle<Bar>wincmd p<CR>', desc = 'Toggle Tree', silent = true},
            {'<leader>nf', ':NERDTreeFind<Bar>wincmd p<CR>', desc = 'Find In Tree', silent = true}
        },
        config = function()
            vim.g['NERDTreeWinSize'] = 42
            vim.g['NERDTreeStatusline'] = ''
            vim.g['NERDTreeMinimalUI'] = 1
            vim.g['NERDTreeShowHidden'] = 1
            vim.g['NERDTreeIgnore'] = {'.DS_Store', '.*.js', '.*.d.ts'}
            -- Quit neovim if NERDTree is the only window remaining
            vim.cmd([[
                autocmd! BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
            ]])

        end
    },
    {"folke/which-key.nvim", lazy = true},
    {
        -- lags when loading nvim and saving files
        'kyazdani42/nvim-tree.lua',
        enabled = false,
        dependencies = {'kyazdani42/nvim-web-devicons'},
    },
    {
        -- errors in non-git controlled directories
        'lewis6991/gitsigns.nvim',
        enabled = false,
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup({current_line_blame = true}) end
    },
    {
        -- hangs nvim on loading for 3-5 seconds!
        'edkolev/tmuxline.vim',
        enabled = false,
        setup = function() vim.cmd([[source $HOME/.config/nvim/config/plugin/tmuxline.vim]]) end
    },
    --'plasticboy/vim-markdown',
    --'RishabhRD/popfix',
    --'RishabhRD/nvim-lsputils'
}

return {
    'ntpeters/vim-better-whitespace',
    'christoomey/vim-tmux-navigator',
    'folke/lsp-colors.nvim', -- remove if it doesn't improve colorschemes
    'machakann/vim-highlightedyank',
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

            vim.o.foldmethod='expr'
            vim.o.foldexpr='nvim_treesitter#foldexpr()'
        end
    },
    {
        'chentoast/marks.nvim',
        config = function()
            require('marks').setup()
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup({current_line_blame = true}) end
    },

    {
        'folke/zen-mode.nvim',
        lazy = true,
        keys = {
            {'<leader>go', ':ZenMode<CR>', desc = 'Toggle Zen Mode', silent = true},
        },
        config = function()
            require('zen-mode').setup({
                plugins = {
                    twilight = {enabled = false},
                },
            })
        end
    },
    {
        'folke/twilight.nvim',
        lazy = true,
        keys = {
            {'<leader>gf', ':Twilight<CR>', desc = 'Toggle Focus Mode', silent = true},
        },
    },
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        keys = {
            {'<leader>nt', ':NvimTreeToggle<CR>', desc = 'Toggle Tree', silent = true},
            {'<leader>nf', ':NvimTreeFindFile<CR>', desc = 'Find In Tree', silent = true}
        },
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function()
            require('nvim-tree').setup({
                filters = {
                    custom = {'.DS_Store', '.*.js', '.*.d.ts'}
                }
            })
        end
    },
    {'folke/which-key.nvim', lazy = true},
    {
        'plasticboy/vim-markdown',
        ft = 'markdown',
    },

    {
        'scrooloose/nerdtree',
        enabled = false,
        lazy = true,
        keys = {
            {'<leader>vt', ':NERDTreeToggle<Bar>wincmd p<CR>', desc = 'Toggle Tree', silent = true},
            {'<leader>vf', ':NERDTreeFind<Bar>wincmd p<CR>', desc = 'Find In Tree', silent = true}
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
    {
        'edkolev/tmuxline.vim',
        lazy = true,
        config = function()
            vim.cmd([[
            let g:tmuxline_powerline_separators = 0
            let g:tmuxline_preset = {
                \ 'c': '#S', 'cwin': ['#I', '#W'], 'win': ['#I', '#W'],
                \ 'x': '%R %d-%m-%Y',
                \ 'options': {'status-justify': 'left'}
                \}
            ]])
        end
    },
    { -- really fast to load
        'itchyny/lightline.vim',
        enabled = false,
        config = function()
            vim.cmd([[
                let g:lightline = {
                    \ 'colorscheme': 'sonokai',
                    \ }
            ]])
        end
    },

    {
        'vim-airline/vim-airline',
        config = function()
            vim.cmd([[
                let g:airline_section_b = "" " disable git branch info
                let g:airline_section_x = "" " don't care about filetype
                let g:airline_section_y = "" " don't care about file encoding
                let g:airline_section_z = "%p%% %{g:airline_symbols.linenr} %#__accent_bold#%l/%L%#__restore__# : %v/%{strlen(getline('.'))}"
            ]])
        end
    },
}

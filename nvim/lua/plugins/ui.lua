return {
    'ntpeters/vim-better-whitespace',
    'christoomey/vim-tmux-navigator',
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
    {"folke/which-key.nvim", lazy = true},
    {
        'plasticboy/vim-markdown',
        ft = 'markdown',
    },
    {
        -- errors in non-git controlled directories
        'lewis6991/gitsigns.nvim',
        --enabled = false,
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup({current_line_blame = true}) end
    },

    {
        -- does not seem to work anymore
        'edkolev/tmuxline.vim',
        enabled = false,
        setup = function() vim.cmd([[source $HOME/.config/nvim/config/plugin/tmuxline.vim]]) end
    },
    {
        'vim-airline/vim-airline',
        enabled = false,
        config = function()
            vim.cmd([[source $HOME/.config/nvim/config/plugin/airline.vim]])
        end
    },
    {
        enabled = false,
        'stevearc/dressing.nvim',
    },
    {
        'tami5/lspsaga.nvim',
        name = "altsaga",
        branch = 'nvim6.0',
        enabled = false,
        keys = {
            --{'<leader>do', ':Lspsaga code_action<CR>', desc = 'Do Code Action', silent = true},
            --{'<leader>rn', ':Lspsaga rename<CR>', desc = 'Rename', silent = true},
            --{'<leader>en', ':Lspsaga diagnostic_jump_next<CR>', desc = 'Next Diagnostic', silent = true},
            --{'<leader>ep', ':Lspsaga diagnostic_jump_prev<CR>', desc = 'Prev Diagnostic', silent = true},
            --{'<leader>ee', ':Lspsaga show_line_diagnostics<CR>', desc = 'Show Diagnostic', silent = true},
            {'<C-f>', ':lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', desc = 'Saga Scroll Down', silent = true},
            {'<C-b>', ':lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', desc = 'Saga Scroll Up', silent = true},
            --{'K', ':Lspsaga hover_doc<CR>', desc = 'Hover Documentation', silent = true},
            {'gh', ':Lspsaga lsp_finder<CR>', desc = 'LSP Finder', silent = true},
        },
        config = function()
            require('lspsaga').init_lsp_saga({
                error_sign = '',
                warn_sign = '',
                hint_sign = '',
                infor_sign = '',
                border_style = "round",
                code_action_prompt = {
                    enable = false
                },
                code_action_keys = {
                    quit = '<ESC>'
                },
                rename_action_keys = {
                    quit = '<ESC>'
                }
            })

            --require("which-key").register({
            --    ["<leader>"] = {
            --        ["do"] = {':Lspsaga code_action<CR>', "Do Code Action"},
            --        ["rn"] = {':Lspsaga rename<CR>', "Rename"},
            --        --["hd"] = {':Lspsage preview_definition<CR>', "Preview Definition"},
            --        e = {
            --            n = {':Lspsaga diagnostic_jump_next<CR>', "Next Diagnostic"},
            --            p = {':Lspsaga diagnostic_jump_prev<CR>', "Prev Diagnostic"},
            --            e = {':Lspsaga show_line_diagnostics<CR>', "Show Diagnostic"},
            --        },
            --    },
            --    ["<C-f>"] = {':lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', "Saga Scroll Down"},
            --    ["<C-b>"] = {':lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', "Saga Scroll Up"},
            --    K = {':Lspsaga hover_doc<CR>', "Hover Documentation"},
            --    ["gh"] = {':Lspsaga lsp_finder<CR>', "LSP Finder"},
            --})
        end
    },
    --'RishabhRD/popfix',
    --'RishabhRD/nvim-lsputils'
}

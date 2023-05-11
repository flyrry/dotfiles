return {
    'tpope/vim-surround',
    'AndrewRadev/splitjoin.vim',
    'editorconfig/editorconfig-vim',
    'github/copilot.vim',
    {
        'neovim/nvim-lspconfig',
        config = function()
            local nvim_lsp = require('lspconfig')
            local protocol = require'vim.lsp.protocol'

            local on_attach = function(client, bufnr)
                require('which-key').register({
                    g = {
                        d = {':lua vim.lsp.buf.definition()<CR>', 'Definition'},
                        D = {':lua vim.lsp.buf.declaration()<CR>', 'Declaration'},
                        t = {':lua vim.lsp.buf.type_definition()<CR>', 'Type definition'},
                        i = {':lua vim.lsp.buf.implementation()<CR>', 'Implementation'},
                        r = {':lua vim.lsp.buf.references()<CR>', 'References'},
                        c = {':lua vim.lsp.buf.incoming_calls()<CR>', 'Incoming calls'},
                        s = {':lua vim.lsp.buf.signature_help()<CR>', 'Signature help'},
                    },
                    f = {
                        f = {':lua vim.lsp.buf.format{async=true}<CR>', 'Format document'},
                    },
                    ['<leader>'] = {
                        ['do'] = {':lua vim.lsp.buf.code_action()<CR>', 'Code action'},
                        ['rn'] = {':lua vim.lsp.buf.rename()<CR>', 'Rename symbol'},
                        e = {
                            n = {':lua vim.diagnostic.goto_next()<CR>', 'Next diagnostic'},
                            p = {':lua vim.diagnostic.goto_prev()<CR>', 'Prev diagnostic'},
                            e = {':lua vim.diagnostic.open_float()<CR>', 'Show diagnostic'},
                        },
                    },
                    K = {':lua vim.lsp.buf.hover()<CR>', 'Hover documentation'},
                }, {
                    buffer = bufnr
                })

                --require('lsp_signature').on_attach({
                --    hint_prefix = '',
                --})

                -- See `:help vim.lsp.*` for documentation on any of the below functions
                --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
                -- using Lspsaga or Telescope for these
                --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()

            nvim_lsp.tsserver.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    on_attach(client, bufnr)
                end
            })

            nvim_lsp.rust_analyzer.setup({
                capabilities = capabilities,
                on_attach=on_attach,
                settings = {
                    ['rust-analyzer'] = {
                        imports = {
                            granularity = {
                                group = 'module',
                            },
                            prefix = 'self',
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true
                        },
                    }
                }
            })

            nvim_lsp.ccls.setup({
                capabilities = capabilities,
                filetypes = {'c', 'cc', 'cxx', 'cpp', 'objc', 'objcpp'},
                on_attach = on_attach
            })

            local filetypes = {
                typescript = 'eslint',
                typescriptreact = 'eslint',
            }
            local linters = {
                eslint = {
                    sourceName = 'eslint',
                    command = 'eslint_d',
                    rootPatterns = {'.eslintrc.js', 'package.json'},
                    debounce = 100,
                    args = {'--stdin', '--stdin-filename', '%filepath', '--format', 'json'},
                    parseJson = {
                        errorsRoot = '[0].messages',
                        line = 'line',
                        column = 'column',
                        endLine = 'endLine',
                        endColumn = 'endColumn',
                        message = '${message} [${ruleId}]',
                        security = 'severity'
                    },
                    securities = {[2] = 'error', [1] = 'warning'}
                }
            }
            local formatters = {
                eslint = {command = 'eslint_d', args = {'--stdin', '--stdin-filename', '%filename', '--fix-to-stdout'}},
                prettier = {command = 'prettier', args = {'--stdin-filepath', '%filepath'}}
            }
            local formatFiletypes = {
                css = 'prettier',
                javascript = {'prettier', 'eslint'},
                javascriptreact = {'prettier', 'eslint'},
                json = 'prettier',
                scss = 'prettier',
                less = 'prettier',
                markdown = 'prettier',
                typescript = {'prettier', 'eslint'},
                typescriptreact = {'prettier', 'eslint'},
            }
            nvim_lsp.diagnosticls.setup {
                on_attach = on_attach,
                filetypes = vim.tbl_keys(filetypes),
                init_options = {
                    filetypes = filetypes,
                    linters = linters,
                    formatters = formatters,
                    formatFiletypes = formatFiletypes
                }
            }

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover, {
                    border = 'single'
                }
            )

            -- Enable diagnostics
            vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                --underline = true,
                --virtual_text = {
                --spacing = 4,
                --prefix = ''
                --},
                virtual_text = true,
                --signs = true,
                update_in_insert = true,
            }
            )
            vim.opt.signcolumn = 'yes'
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'saecki/crates.nvim',
            'onsails/lspkind-nvim',
            --'L3MON4D3/LuaSnip',
            --'saadparwaiz1/cmp_luasnip',
            --'hrsh7th/cmp-buffer',
            --'hrsh7th/cmp-nvim-lua',
            --'hrsh7th/cmp-calc',
            --'hrsh7th/cmp-emoji',
            --'f3fora/cmp-spell',
        },
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            cmp.setup {
                --snippet = {
                --    expand = function(args)
                --        require('luasnip').lsp_expand(args.body)
                --    end,
                --},

                sources = {
                    {name = 'nvim_lsp'},
                    {name = 'path'},
                    {name = 'luasnip'},
                    {name = 'orgmode'},
                    {name = 'crates'},
                    --{name = 'nvim_lua'},
                    --{name = 'buffer'},
                },

                -- only works if source actually triess to preselect anything
                --preselect = cmp.PreselectMode.None,

                mapping = {
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    })
                },

                experimental = {
                    ghost_text = true
                },

                formatting = {
                    format = lspkind.cmp_format({
                        with_text = false,
                        menu = {
                            nvim_lsp = '[lsp]',
                            path = '[pth]',
                            luasnip = '[snp]',
                            orgmode = '[org]'
                        }
                    })
                }
            }
        end
    },
    {
        'kristijanhusak/orgmode.nvim',
        dependencies = {'nvim-treesitter/nvim-treesitter'},
        config = function()
            require('orgmode').setup({
                org_agenda_files = '~/Documents/org/*',
                org_default_notes_file = '~/Documents/org/todo.org',
                --org_hide_leading_stars = true,
            })
        end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'tpope/vim-fugitive',
        lazy = true,
        keys = {
            {'<leader>ghb', ':Git blame<CR>', desc = 'Git Blame', silent = true}
        },
    },
    {
        'ggandor/leap.nvim',
        lazy = true,
        keys = {
            {'s', '<Plug>(leap-forward-to)', desc = 'Leap forward', silent = true},
            {'S', '<Plug>(leap-backward-to)', desc = 'Leap backward', silent = true},
            {'gs', '<Plug>(leap-cross-window)', desc = 'Leap across', silent = true},
        },
        config = function()
            require('leap').add_default_mappings()
        end
    },
    {
        'junegunn/fzf.vim',
        lazy = true,
        keys = {
            {'<leader>fo', ':History<CR>', desc = 'History', silent = true},
            {'<leader>fm', ':GFiles?<CR>', desc = 'Git Changes', silent = true},
            {'<leader>fs', ':Rg<CR>', desc = 'Find String', silent = true},
            {'<leader>fw', ':Rg <C-R><C-W><CR>', desc = 'Find Word', silent = true},
        },
        dependencies = {'junegunn/fzf'},
        config = function()
            vim.cmd([[set rtp+=/usr/local/opt/fzf]])
        end
    },
    {
        'mfussenegger/nvim-fzy',
        lazy = true,
        init = function()
            require('which-key').register({
                ['<leader>f'] = {
                    b = {':lua require("fzy").actions.buffers()<CR>', 'Buffers'},
                    f = {':lua require("fzy").execute("fd", require("fzy").sinks.edit_file)<CR>', 'Find Files'},
                    g = {':lua require("fzy").execute("git ls-files", require("fzy").sinks.edit_file)<CR>', 'Git Files'},
                    q = {':lua require("fzy").actions.quickfix()<CR>', 'Quickfix'},
                },
                ['<C-p>'] = {':lua require("fzy").execute("fd", require("fzy").sinks.edit_file)<CR>', 'Find Files'},
            })
        end
    },
    {'tpope/vim-rhubarb', lazy = true},
    {'godlygeek/tabular', lazy = true},

    -- maybe later...
    {
        'ibhagwan/fzf-lua',
        lazy = true,
        enabled = false,
        dependencies = {'nvim-tree/nvim-web-devicons'},
        init = function()
            require('which-key').register({
                ['<C-p>'] = {':lua require("fzf-lua").files()<CR>', 'FZF Find Files'},
            })
        end
    },
}

return {
    { 'neovim/nvim-lspconfig' },
    {
        'j-hui/fidget.nvim',
        opts = {},
        tag = "legacy"
    },
    { 'williamboman/mason.nvim', config = true },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            local on_attach = function(client, bufnr)
                if client.name == "tsserver" then
                    client.server_capabilities.documentFormattingProvider = false
                end

                require('which-key').register({
                    g = {
                        d = { ':lua vim.lsp.buf.definition()<CR>', 'Definition' },
                        D = { ':lua vim.lsp.buf.declaration()<CR>', 'Declaration' },
                        t = { ':lua vim.lsp.buf.type_definition()<CR>', 'Type definition' },
                        i = { ':lua vim.lsp.buf.implementation()<CR>', 'Implementation' },
                        r = { ':lua vim.lsp.buf.references()<CR>', 'References' },
                        c = { ':lua vim.lsp.buf.incoming_calls()<CR>', 'Incoming calls' },
                        --s = { ':lua vim.lsp.buf.signature_help()<CR>', 'Signature help' },
                    },
                    f = {
                        f = { ':lua vim.lsp.buf.format{async=true}<CR>', 'Format document' },
                    },
                    ['<leader>'] = {
                        ['do'] = { ':lua vim.lsp.buf.code_action()<CR>', 'Code action' },
                        ['rn'] = { ':lua vim.lsp.buf.rename()<CR>', 'Rename symbol' },
                        e = {
                            n = { ':lua vim.diagnostic.goto_next()<CR>', 'Next diagnostic' },
                            p = { ':lua vim.diagnostic.goto_prev()<CR>', 'Prev diagnostic' },
                            e = { ':lua vim.diagnostic.open_float()<CR>', 'Show diagnostic' },
                        },
                    },
                    K = { ':lua vim.lsp.buf.hover()<CR>', 'Hover documentation' },
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

            -- Enable the following language servers
            -- Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. They will be passed to
            --  the `settings` field of the server config. You must look up that documentation yourself.
            local servers = {
                clangd = {},
                tsserver = {},
                rust_analyzer = {
                    -- ['rust-analyzer'] = {
                    --     imports = {
                    --         granularity = {
                    --             group = 'module',
                    --         },
                    --         prefix = 'self',
                    --     },
                    --     cargo = {
                    --         buildScripts = {
                    --             enable = true,
                    --         },
                    --     },
                    --     procMacro = {
                    --         enable = true
                    --     },
                    -- }
                },
                zk = {},
                diagnosticls = {
                    filetypes = {
                        -- "css",
                        -- "dockerfile",
                        -- "fish",
                        -- "go",
                        "javascript",
                        "javascriptreact",
                        -- "json",
                        -- "lua",
                        "markdown",
                        -- "python",
                        -- "scss",
                        -- "sh",
                        -- "sql",
                        "typescript",
                        "typescriptreact",
                        -- "vim",
                        -- "yaml",
                        -- "yaml.ansible",
                    },
                    init_options = {
                        linters = {
                            eslint = {
                                sourceName = "eslint",
                                command = "eslint_d",
                                rootPatterns = { ".eslintrc.js", "package.json" },
                                debounce = 100,
                                args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
                                parseJson = {
                                    errorsRoot = "[0].messages",
                                    line = "line",
                                    column = "column",
                                    endLine = "endLine",
                                    endColumn = "endColumn",
                                    message = "${message} [${ruleId}]",
                                    security = "severity"
                                },
                                securities = { [2] = "error", [1] = "warning" }
                            }
                        },
                        formatters = {
                            eslint = {
                                command = "eslint_d",
                                args = { "--stdin", "--stdin-filename", "%filename", "--fix-to-stdout" }
                            },
                            prettier = { command = "prettier", args = { "--stdin", "--stdin-filepath", "%filepath" } }
                        },
                        filetypes = {
                            javascript = "eslint",
                            javascriptreact = "eslint",
                            typescript = "eslint",
                            typescriptreact = "eslint",
                        },
                        formatFiletypes = {
                            css = "prettier",
                            javascript = { "prettier", "eslint" },
                            javascriptreact = { "prettier", "eslint" },
                            json = "prettier",
                            scss = "prettier",
                            less = "prettier",
                            markdown = "prettier",
                            typescript = { "prettier", "eslint" },
                            typescriptreact = { "prettier", "eslint" },
                        },
                    },
                },
                lua_ls = {
                    Lua = {
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local mason_lspconfig = require('mason-lspconfig')

            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            mason_lspconfig.setup_handlers {
                function(server_name)
                    if server_name == "diagnosticls" then
                        require('lspconfig')[server_name].setup(servers[server_name])
                    else
                        require('lspconfig')[server_name].setup {
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = servers[server_name],
                        }
                    end
                end,
            }


            -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            --     vim.lsp.handlers.hover, {
            --         border = 'single'
            --     }
            -- )

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
        end,
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
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'luasnip' },
                    { name = 'crates' },
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
                        }
                    })
                }
            }
        end
    },
}

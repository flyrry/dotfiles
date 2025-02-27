return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            {
                'j-hui/fidget.nvim',
                opts = {},
            },
            'saghen/blink.cmp',
            'pmizio/typescript-tools.nvim',
        },
        config = function()
            local on_attach = function(client, bufnr)
                -- if client.name == "ts_ls" then
                --     client.server_capabilities.documentFormattingProvider = false
                -- end

                require('which-key').add({
                    { 'ff',         ':lua vim.lsp.buf.format{async=true}<CR>', desc = 'Format document' },
                    { '<leader>do', ':lua vim.lsp.buf.code_action()<CR>',      desc = 'Code action' },
                    { '<leader>rn', ':lua vim.lsp.buf.rename()<CR>',           desc = 'Rename symbol' },
                    {
                        '<leader>ih',
                        function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
                        end,
                        desc = 'Toggle [i]nlay [h]ints'
                    },
                    { '<leader>en', ':lua vim.diagnostic.goto_next()<CR>',  desc = 'Next diagnostic' },
                    { '<leader>ep', ':lua vim.diagnostic.goto_prev()<CR>',  desc = 'Prev diagnostic' },
                    { '<leader>ee', ':lua vim.diagnostic.open_float()<CR>', desc = 'Show diagnostic' },
                }, {
                    buffer = bufnr
                })

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup('cursor-hold-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = bufnr,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = bufnr,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('cursor-hold-lsp-detach', { clear = true }),
                        callback = function(event)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'cursor-hold-lsp-highlight', buffer = event.buf }
                        end,
                    })
                end

                vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                    vim.lsp.handlers.hover, {
                        border = 'rounded',
                    }
                )
            end

            -- Enable the following language servers
            -- Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. They will be passed to
            --  the `settings` field of the server config. You must look up that documentation yourself.
            local servers = {
                clangd = {},
                -- ts_ls = {
                --     typescript = {
                --         inlayHints = {
                --             includeInlayEnumMemberValueHints = true,
                --             includeInlayFunctionLikeReturnTypeHints = true,
                --             includeInlayFunctionParameterTypeHints = true,
                --             includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                --             includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                --             includeInlayPropertyDeclarationTypeHints = true,
                --             includeInlayVariableTypeHints = false,
                --         },
                --     },
                -- },
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

            local mason_lspconfig = require('mason-lspconfig')

            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local capabilities = vim.lsp.protocol.make_client_capabilities()
                        require('lspconfig')[server_name].setup {
                            capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
                            on_attach = on_attach,
                            settings = servers[server_name],
                        }
                    end,
                    ["diagnosticls"] = function()
                        require('lspconfig').diagnosticls.setup(servers["diagnosticls"])
                    end,
                }
            }

            -- this plugin uses dedicated event loop to talk to tsserver directly
            -- avoiding extra layer of typescript-language-server
            require('typescript-tools').setup {
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    on_attach(client, bufnr)
                end,
                settings = {
                    tsserver_max_memory = 8192,
                }
            }

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

            -- make CursorHold highlights standout even more
            -- vim.api.nvim_set_hl(0, 'LspReferenceRead', { standout = true })
            -- vim.api.nvim_set_hl(0, 'LspReferenceWrite', { standout = true })
            -- vim.api.nvim_set_hl(0, 'LspReferenceText', { standout = true })
        end,
    },
}

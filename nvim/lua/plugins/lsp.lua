return {
    { 'williamboman/mason.nvim', config = true },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'nvim-lua/plenary.nvim',
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

                local km = function(key, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', key, func, { buffer = bufnr, desc = desc })
                end

                km('ff', function() vim.lsp.buf.format({ async = true }) end, 'Format document')
                km('<leader>do', vim.lsp.buf.code_action, 'Code action')
                km('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
                km('<leader>en', vim.diagnostic.goto_next, 'Next diagnostic')
                km('<leader>ep', vim.diagnostic.goto_prev, 'Prev diagnostic')
                km('<leader>ee', vim.diagnostic.open_float, 'Show diagnostic')
                km('<leader>ih',
                    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })) end,
                    'Toggle inlay hints')

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
            end

            local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
            local init_config = function(lsp_name, settings)
                local lsp_config = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = settings or {},
                }
                vim.lsp.config(lsp_name, lsp_config)
            end
            init_config('marksman')
            init_config('clangd')
            init_config('rust_analyzer')
            init_config('lua_ls', {
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
            })
            vim.lsp.config('diagnosticls', {
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
            })
            require('typescript-tools').setup {
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    on_attach(client, bufnr)
                end,
                capabilities = capabilities,
                settings = {
                    tsserver_max_memory = 8192,
                    separate_diagnostic_server = false,
                    tsserver_file_preferences = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayVariableTypeHints = true,
                    },
                    -- code_lens = "all",
                }
            }

            vim.lsp.enable({ 'clangd', 'rust_analyzer', 'lua_ls', 'diagnosticls', 'marksman' })

            -- configure diagnostics
            vim.diagnostic.config(
                {
                    virtual_text = {
                        severity = { max = vim.diagnostic.severity.WARN },
                        source = "if_many",
                        prefix = ''
                    },
                    virtual_lines = {
                        current_line = true,
                        severity = { min = vim.diagnostic.severity.ERROR },
                        source = "if_many",
                        prefix = ''
                    },
                    severity_sort = true,
                    update_in_insert = true,
                    float = { border = 'rounded' }
                }
            )

            -- make CursorHold highlights standout even more
            -- vim.api.nvim_set_hl(0, 'LspReferenceRead', { standout = true })
            -- vim.api.nvim_set_hl(0, 'LspReferenceWrite', { standout = true })
            -- vim.api.nvim_set_hl(0, 'LspReferenceText', { standout = true })
        end,
    },
}

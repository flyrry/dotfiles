return {
    { 'williamboman/mason.nvim', config = true },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'j-hui/fidget.nvim', opts = {} },
            'saghen/blink.cmp',
        },
        config = function()
            local ts_servers = { 'tsgo', 'ts_ls', 'vtsls' }
            local current_ts_server = 'tsgo'

            local on_attach = function(client, bufnr)
                if vim.tbl_contains(ts_servers, client.name) then
                    client.server_capabilities.documentFormattingProvider = false
                end

                local km = function(key, func, desc)
                    vim.keymap.set('n', key, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
                end

                km('<leader>do', vim.lsp.buf.code_action, 'Code action')
                km('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
                km('<leader>en', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next diagnostic')
                km('<leader>ep', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Prev diagnostic')
                km('<leader>ee', vim.diagnostic.open_float, 'Show diagnostic')
                km('<leader>ih',
                    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })) end,
                    'Toggle inlay hints')
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

            local base_servers = { 'marksman', 'clangd', 'rust_analyzer', 'basedpyright', 'lua_ls' }
            for _, server in ipairs(vim.list_extend(vim.list_extend({}, base_servers), ts_servers)) do
                init_config(server)
            end

            vim.api.nvim_create_user_command('TSSwitch', function(opts)
                local new_server = opts.args
                if not vim.tbl_contains(ts_servers, new_server) then
                    vim.notify('Invalid server. Choose: ' .. table.concat(ts_servers, ', '), vim.log.levels.ERROR)
                    return
                end

                for _, client in ipairs(vim.lsp.get_clients({ name = current_ts_server })) do
                    client:stop()
                end

                current_ts_server = new_server
                vim.lsp.enable(new_server)
                vim.cmd('edit') -- reload buffer to trigger LSP attach
                vim.notify('Switched to ' .. new_server, vim.log.levels.INFO)
            end, {
                nargs = 1,
                complete = function() return ts_servers end,
            })

            vim.api.nvim_create_user_command('TSCurrent', function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                for _, client in ipairs(clients) do
                    if vim.tbl_contains(ts_servers, client.name) then
                        vim.notify('Current TS server: ' .. client.name, vim.log.levels.INFO)
                        return
                    end
                end
                vim.notify('No TS server attached', vim.log.levels.WARN)
            end, {})

            vim.lsp.enable(vim.list_extend({ current_ts_server }, base_servers))

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
            vim.api.nvim_set_hl(0, 'LspReferenceRead', { standout = true })
            vim.api.nvim_set_hl(0, 'LspReferenceWrite', { standout = true })
            vim.api.nvim_set_hl(0, 'LspReferenceText', { standout = true })
        end,
    },
}

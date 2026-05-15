return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            'ff',
            function()
                require('conform').format({ async = true, lsp_fallback = true })
            end,
            mode = 'n',
            desc = 'Format buffer',
        },
    },
    opts = {
        formatters_by_ft = {
            javascript = { 'prettier', 'eslint_d' },
            javascriptreact = { 'prettier', 'eslint_d' },
            typescript = { 'prettier', 'eslint_d' },
            typescriptreact = { 'prettier', 'eslint_d' },
            css = { 'prettier' },
            scss = { 'prettier' },
            less = { 'prettier' },
            json = { 'prettier' },
            markdown = { 'prettier' },
            lua = { 'stylua' },
            python = { 'ruff_format' },
            rust = { 'rustfmt' },
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_fallback = true }
        end,
    },
    init = function()
        vim.api.nvim_create_user_command('FormatDisable', function(args)
            if args.bang then
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = 'Disable autoformat-on-save (use ! for buffer-local)',
            bang = true,
        })
        vim.api.nvim_create_user_command('FormatEnable', function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = 'Re-enable autoformat-on-save',
        })
    end,
}

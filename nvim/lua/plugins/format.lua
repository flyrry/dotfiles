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
        -- Uncomment to format on save:
        -- format_on_save = {
        --     timeout_ms = 500,
        --     lsp_fallback = true,
        -- },
    },
}

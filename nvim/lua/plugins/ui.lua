return {
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                component_separators = '',
                section_separators = '',
                disabled_filetypes = {
                    'startify',
                    statusline = { 'AgenticChat', 'AgenticInput', 'AgenticCode', 'AgenticFiles' },
                    winbar = { 'AgenticChat', 'AgenticInput', 'AgenticCode', 'AgenticFiles' },
                },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { { 'lsp_status', icon = '', symbols = { separator = '  ', done = '' } },
                },
                lualine_y = { 'branch', 'encoding', 'progress', 'location' },
                lualine_z = { { 'datetime', style = '%H:%M' } },
            },
            winbar = {
                lualine_x = { { 'filename' } },
                lualine_y = { 'progress' },
            },
            inactive_winbar = {
                lualine_x = { { 'filename' } },
                lualine_y = { 'progress' },
            },
            extensions = { 'quickfix', 'fugitive' },
        },
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
    {
        'chentoast/marks.nvim',
        config = true,
    },
    {
        'stevearc/quicker.nvim',
        ft = "qf",
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {
            keys = {
                { '>', function() require('quicker').expand({ before = 2, after = 2, add_to_existing = true }) end, desc = 'Expand context' },
                { '<', function() require('quicker').collapse() end,                                                desc = 'Collapse context' },
            },
        },
    }
}

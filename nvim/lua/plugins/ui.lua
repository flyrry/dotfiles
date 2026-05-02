require('vim._core.ui2').enable()

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
                lualine_y = { 'branch', { function()
                    local encoding = vim.opt.fileencoding:get()

                    if encoding == 'utf-8' then
                        return ''
                    end
                    return encoding
                end }, 'progress', 'location' },
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
        'MeanderingProgrammer/render-markdown.nvim',
        config = function()
            require('render-markdown').setup({
                completions = { lsp = { enabled = true } },
            })
        end
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
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        event = { "WinLeave" },
        config = function()
            require("colorful-winsep").setup({
                animate = { enabled = false },
                highlight = function()
                    local search = vim.api.nvim_get_hl(0, { name = "Comment" })
                    vim.api.nvim_set_hl(0, "ColorfulWinSep", {
                        fg = search.bg or search.fg,
                        bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg,
                    })
                end,
            })
        end
    }
}

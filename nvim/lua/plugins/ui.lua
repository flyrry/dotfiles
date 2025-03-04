return {
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                component_separators = '',
                section_separators = '',
                disabled_filetypes = { 'startify' },
                -- theme = 'tokyonight',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { {
                    function()
                        local clients = vim.lsp.get_clients({ bufnr = 0 })
                        local servers = {}
                        for _, client in ipairs(clients) do
                            table.insert(servers, client.name)
                        end
                        table.sort(servers)
                        return table.concat(servers, '  ')
                    end,
                    icon = '',
                } },
                lualine_y = { 'encoding', 'progress', 'location' },
                lualine_z = {},
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
            -- extensions = { 'quickfix', 'fugitive', 'nvim-tree' },
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
        'mhinz/vim-startify',
        config = function()
            vim.g.startify_change_to_dir = false
            vim.g.startify_enable_special = false
            vim.g.startify_fortune_use_unicode = true
            vim.g.startify_custom_indices = { 'f', 'h', 'n', 'm', 'd', 'a', 'y' }
            vim.g.startify_custom_header = [[startify#fortune#quote()]]
            vim.g.startify_lists = {
                { ['type'] = 'dir',      ['header'] = { "   MRU " .. vim.fn.getcwd() } },
                { ['type'] = 'files',    ['header'] = { "   MRU" } },
                { ['type'] = 'sessions', ['header'] = { "   Sessions" },               ['indices'] = { 'l' } },
            }
        end
    },
    {
        'folke/zen-mode.nvim',
        lazy = true,
        keys = {
            { '<leader>go', ':ZenMode<CR>', desc = 'Toggle Zen Mode', silent = true },
        },
        config = function()
            require('zen-mode').setup({
                plugins = {
                    twilight = { enabled = false },
                },
            })
        end
    },
    {
        'folke/twilight.nvim',
        lazy = true,
        keys = {
            { '<leader>gf', ':Twilight<CR>', desc = 'Toggle Focus Mode', silent = true },
        },
    },
    {
        'chentoast/marks.nvim',
        config = true,
    }
}

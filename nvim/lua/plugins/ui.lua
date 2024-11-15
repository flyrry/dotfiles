return {
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                component_separators = '',
                section_separators = '',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { {
                    function()
                        local msg = ''
                        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) == nil then
                            return msg
                        end
                        local lspList = {}
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                lspList[client.name] = true
                            end
                        end
                        if next(lspList) ~= nil then
                            local servers = {}
                            for k, _ in pairs(lspList) do
                                table.insert(servers, k)
                            end
                            table.sort(servers)
                            return table.concat(servers, '  ')
                        else
                            return msg
                        end
                    end,
                    icon = '',
                } },
                lualine_y = { 'encoding', 'progress', 'location' },
                lualine_z = {},
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
        'echasnovski/mini.indentscope',
        config = function()
            require('mini.indentscope').setup({
                draw = {
                    animation = require('mini.indentscope').gen_animation.linear({
                        duration = 5,
                    }),
                }
            })
        end
    },
    {
        'chentoast/marks.nvim',
        config = true,
    }
}

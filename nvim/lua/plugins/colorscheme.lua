return {
    {
        'sainnhe/sonokai',
        lazy = true,
        priority = 1000,
        config = function()
            --vim.cmd[[let g:sonokai_style = 'atlantis']]
            --vim.cmd[[let g:sonokai_style = 'andromeda']]
            --vim.cmd[[let g:sonokai_style = 'shusia']]
            --vim.cmd[[let g:sonokai_style = 'maia']]
            --vim.cmd[[let g:sonokai_style = 'espresso']]
            vim.cmd([[let g:sonokai_enable_italic=1]])
            vim.cmd([[colorscheme sonokai]])
        end
    },
    {
        'sainnhe/gruvbox-material',
        priority = 1000,
        lazy = true,
        config = function()
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_foreground = 'original'
            vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
            vim.cmd.colorscheme('gruvbox-material')
        end
    },
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        lazy = true,
        priority = 1000,
        config = function()
            require('tokyonight').load({
                style = 'storm',
                -- dim_inactive = true,
            })
        end,
    },
    {
        'catppuccin/nvim',
        name = 'catpuccin',
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = 'frappe',
                integrations = {
                    -- flatten = true,
                },
            })
            vim.cmd.colorscheme('catppuccin')
        end,
    },
    -- 'deparr/tairiki.nvim',
}

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
        priority = 1000,
        lazy = true,
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
        lazy = true,
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
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme nordfox") -- duskfox is an option
        end,
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme nordic")
        end
    },
    {
        'rmehri01/onenord.nvim',
        name = 'onenord',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme onenord")
        end,
    },
    {
        'shaunsingh/nord.nvim',
        name = 'nord',
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme nord")
        end,
    },
    {
        'mhartington/oceanic-next',
        name = 'oceanicnext',
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme oceanicnext")
        end,
    },
    {
        'ribru17/bamboo.nvim',
        lazy = true,
        priority = 1000,
        config = function()
            require('bamboo').setup {
                -- optional configuration here
            }
            require('bamboo').load()
        end,
    },
    {
        'sainnhe/edge',
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme edge")
        end,
    },
    -- -- poor contrast
    -- {
    --     "xeind/nightingale.nvim",
    --     lazy = true,
    --     priority = 1000,
    --     config = function()
    --         require("nightingale").setup({
    --             transparent = false, -- set to true for transparent background
    --         })
    --         vim.cmd("colorscheme nightingale")
    --     end,
    -- },
    -- {
    --     'rebelot/kanagawa.nvim',
    --     name = 'kanagawa',
    --     lazy = true,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd.colorscheme('kanagawa-wave')
    --     end,
    -- },
    -- {
    --     "vague-theme/vague.nvim",
    --     lazy = true,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd("colorscheme vague")
    --     end
    -- },
    -- {
    --     'rose-pine/neovim',
    --     name = 'rose-pine',
    --     lazy = true,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd.colorscheme('rose-pine-moon')
    --     end,
    -- },
    -- {
    --     'olimorris/onedarkpro.nvim',
    --     lazy = true,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd("colorscheme onedark")
    --     end,
    -- },
}

return {
    {
        'sainnhe/sonokai',
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
        lazy = true,
    },
    {
        'neanias/everforest-nvim',
        lazy = true,
        priority = 1000,
        config = function()
            require('everforest').setup({ background = 'hard' })
            require('everforest').load()
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        name = "tokyonight",
        priority = 1000,
        -- opts = { style = "moon" },
        config = function()
            require('tokyonight').load({ style = 'moon' })
        end,
    },
}

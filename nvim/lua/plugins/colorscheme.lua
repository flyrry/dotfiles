return {
    {
        'sainnhe/sonokai',
        priority = 1000,
        config = function()
            --vim.cmd[[let g:sonokai_style = 'atlantis']]
            --vim.cmd[[let g:sonokai_style = 'andromeda']]
            --vim.cmd[[let g:sonokai_style = 'shusia']]
            --vim.cmd[[let g:sonokai_style = 'maia']]
            vim.cmd([[colorscheme sonokai]])
            vim.cmd([[let g:sonokai_enable_italic=1]])
        end
    },
    {
        'sainnhe/edge',
        lazy = true,
    },
    {
        'sainnhe/gruvbox-material',
        lazy = true,
    },
    {
        'sainnhe/everforest',
        lazy = true,
    },
    {
        'bluz71/vim-moonfly-colors',
        name = 'moonfly',
        lazy = true,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        opts = { style = "moon" },
        lazy = true,
    },
}

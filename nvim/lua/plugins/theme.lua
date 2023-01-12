return {
    {
        'sainnhe/sonokai',
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme sonokai]])
            vim.cmd([[let g:sonokai_enable_italic=1]])
        end
    },
    {
        'sainnhe/gruvbox-material',
        lazy = true,
    },
    {
        'mhartington/oceanic-next',
        lazy = true,
    },
    {
        'overcache/NeoSolarized',
        lazy = true,
    },
    {
        'folke/tokyonight.nvim',
        lazy = true,
    },
}

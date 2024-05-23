return {
    { 'echasnovski/mini.splitjoin', opts = {} },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
    'sindrets/diffview.nvim',
    { 'tpope/vim-sleuth' }, -- auto-adjust 'shiftwidth' and 'expandtab'
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = true
    },
    {
        "bolteu/goto-api-definition.nvim",
        config = true
    },
    {
        'bolteu/goto-api-endpoint.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = true
    }
}

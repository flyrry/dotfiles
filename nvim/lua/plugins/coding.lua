return {
    { 'echasnovski/mini.comment',   opts = {} },
    { 'echasnovski/mini.splitjoin', opts = {} },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
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

return {
    { 'echasnovski/mini.splitjoin', opts = {} },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
    { 'tpope/vim-sleuth' }, -- auto-adjust 'shiftwidth' and 'expandtab'
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false }
    },
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
            { 'nvim-telescope/telescope.nvim', branch = '0.1.x' }
        },
        config = true
    },
    {
        'bolteu/bolt.nvim',
        opts = {
            bootstrap = '<Leader>gs',
            db = '<Leader>gd',
            comp = '<Leader>gc',
            find_files_service = '<Leader>p',
            grep_service = '<Leader>fis'
        },
        dependencies = { 'nvim-telescope/telescope.nvim' }
    }
}

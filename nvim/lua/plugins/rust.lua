return {
    'saecki/crates.nvim',
    version = 'v0.3.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = 'toml',
    config = function()
        require('crates').setup()
    end,
}

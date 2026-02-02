return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        config = function()
            -- unrelated to `lazydev` but useful for Lua development
            vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<cr>')
            vim.keymap.set('n', '<leader>x', ':lua<cr>')
            vim.keymap.set('v', '<leader>x', ':lua<cr>')

            require("lazydev").setup({
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                },
            })
        end
    },
}

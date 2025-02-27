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
        'bolteu/bolt-server.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim',
        },
        cond = function()
            local cwd = vim.fn.getcwd()
            return cwd == "/Users/sergei/repos/taxify/server"
        end,
        config = function()
            local bolt = require("bolt-server")
            vim.keymap.set("n", "<leader>gs", bolt.find_service)
            vim.keymap.set("n", "<Leader>gc", bolt.find_service_comp_tests)
            vim.keymap.set("n", "<Leader>gd", bolt.find_service_db_schema)
            vim.keymap.set("n", "<Leader>p", bolt.find_service_files)
            vim.keymap.set("n", "<Leader>fis", bolt.grep_service_files)
            vim.keymap.set("n", "<Leader>cs", bolt.compile_service)
            vim.keymap.set("n", "<Leader>csf", bolt.compile_service_force)
            vim.keymap.set("n", "<Leader>cst", bolt.compile_service_with_tests)
            vim.keymap.set("n", "<Leader>ags", bolt.api_gen_service)
            vim.keymap.set("n", "<Leader>cts", bolt.select_comp_test_to_run)
            vim.keymap.set("n", "<Leader>cta", bolt.run_service_comp_tests)
            vim.keymap.set("n", "<Leader>ctb", bolt.run_buffer_comp_tests)
            vim.keymap.set("n", "<Leader>ctc", bolt.run_comp_test_under_cursor)
            vim.keymap.set("n", "<Leader>gad", bolt.goto_api_definition)
            vim.keymap.set("n", "<Leader>gae", bolt.goto_api_endpoint)
        end,
    },
    {
        "bolteu/bolt-admin.nvim",
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim',
        },
        cond = function()
            local cwd = vim.fn.getcwd()
            return cwd == "/Users/sergei/repos/taxify/admin-panel"
        end,
        config = function()
            local bolt = require("bolt-admin")
            local map = function(key, fn)
                vim.keymap.set("n", "<Leader>" .. key, fn)
            end
            map("gs", bolt.find_module)
            map("cs", bolt.compile_module)
            map("p", bolt.find_module_files)
        end
    }
}

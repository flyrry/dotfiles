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
            'folke/which-key.nvim',
        },
        cond = function()
            local cwd = vim.fn.getcwd()
            return cwd == "/Users/sergei/repos/taxify/server"
        end,
        config = function()
            local bolt = require("bolt-server")
            require("which-key").add({
                { "<leader>gs",  bolt.find_service,               desc = "" },
                { "<Leader>gc",  bolt.find_service_comp_tests,    desc = "" },
                { "<Leader>gd",  bolt.find_service_db_schema,     desc = "" },
                { "<Leader>p",   bolt.find_service_files,         desc = "" },
                { "<Leader>fis", bolt.grep_service_files,         desc = "" },
                { "<Leader>cs",  bolt.compile_service,            desc = "[C]ompile [S]ervice" },
                { "<Leader>csf", bolt.compile_service_force,      desc = "[C]ompile [S]ervice ([F]orce)" },
                { "<Leader>cst", bolt.compile_service_with_tests, desc = "[C]ompile [S]ervice with [T]ests" },
                { "<Leader>ags", bolt.api_gen_service,            desc = "[A]PI-[G]en [S]ervice" },
                { "<Leader>cts", bolt.select_comp_test_to_run,    desc = "" },
                { "<Leader>cta", bolt.run_service_comp_tests,     desc = "" },
                { "<Leader>ctb", bolt.run_buffer_comp_tests,      desc = "" },
                { "<Leader>ctc", bolt.run_comp_test_under_cursor, desc = "" },
                { "<Leader>gad", bolt.goto_api_definition,        desc = "" },
                { "<Leader>gae", bolt.goto_api_endpoint,          desc = "" },
            })
        end,
    },
    {
        "bolteu/bolt-admin.nvim",
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim',
            'folke/which-key.nvim',
        },
        cond = function()
            local cwd = vim.fn.getcwd()
            return cwd == "/Users/sergei/repos/taxify/admin-panel"
        end,
        config = function()
            local bolt = require("bolt-admin")
            require("which-key").add({
                { "<leader>gs", bolt.find_module,       desc = "" },
                { "<leader>cs", bolt.compile_module,    desc = "" },
                { "<leader>p",  bolt.find_module_files, desc = "" },
            })
        end
    }
}

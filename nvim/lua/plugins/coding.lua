return {
    { 'echasnovski/mini.splitjoin', opts = {} },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
    { 'tpope/vim-unimpaired' },
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
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            'github/copilot.vim',
            'nvim-lua/plenary.nvim'
        },
        build = "make tiktoken",
        opts = {
        }
    },
    {
        'bolteu/bolt-server.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim',
        },
        -- commit = '3d9848f',
        -- cond = function()
        --     local cwd = vim.fn.getcwd()
        --     return cwd == "/Users/sergei/repos/taxify/server"
        -- end,
        config = function()
            local bolt = require("bolt-server")
            vim.keymap.set('n', "<leader>gs", bolt.find_service, { desc = "" })
            vim.keymap.set('n', "<Leader>gc", bolt.find_service_comp_tests, { desc = "" })
            vim.keymap.set('n', "<Leader>gd", bolt.find_service_db_schema, { desc = "" })
            vim.keymap.set('n', "<Leader>p", bolt.find_service_files, { desc = "" })
            vim.keymap.set('n', "<Leader>fis", bolt.grep_service_files, { desc = "" })
            vim.keymap.set('n', "<Leader>cs", bolt.compile_service, { desc = "[C]ompile [S]ervice" })
            vim.keymap.set('n', "<Leader>csf", bolt.compile_service_force, { desc = "[C]ompile [S]ervice ([F]orce)" })
            vim.keymap.set('n', "<Leader>cst", bolt.compile_service_with_tests,
                { desc = "[C]ompile [S]ervice with [T]ests" })
            vim.keymap.set('n', "<Leader>ags", bolt.api_gen_service, { desc = "[A]PI-[G]en [S]ervice" })
            vim.keymap.set('n', "<Leader>xs", bolt.select_comp_test_to_run, { desc = "E[x]ecute [S]elected test" })
            vim.keymap.set('n', "<Leader>xa", bolt.run_service_comp_tests, { desc = "E[x]ecute all service tests" })
            vim.keymap.set('n', "<Leader>xf", bolt.run_buffer_comp_tests, { desc = "E[x]ecute tests in the file" })
            vim.keymap.set('n', "<Leader>xx", bolt.run_comp_test_under_cursor, { desc = "E[x]ecute current test" })
            vim.keymap.set('n', "<Leader>gad", bolt.goto_api_definition, { desc = "" })
            vim.keymap.set('n', "<Leader>gae", bolt.goto_api_endpoint, { desc = "" })
            local bottomsplit = {
                config = function()
                    return {
                        style = 'minimal',
                        split = 'below',
                        height = 20,
                    }
                end,
                should_enter = false,
            }
            local rightsplit = {
                config = function()
                    return {
                        style = 'minimal',
                        split = 'right',
                    }
                end,
                should_enter = false,
            }
            require("bolt-server").setup({
                term_configs = {
                    compile = bottomsplit,
                    genapi = bottomsplit,
                    test = rightsplit,
                }
            })
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
            vim.keymap.set('n', "<leader>gs", bolt.find_module, { desc = "" })
            vim.keymap.set('n', "<leader>cs", bolt.compile_module, { desc = "" })
            vim.keymap.set('n', "<leader>p", bolt.find_module_files, { desc = "" })
        end
    },
    {
        dir = "~/.config/nvim/lua/jump-to-function",
        config = function()
            require("jump-to-function").setup({})
        end
    },
    {
        dir = "~/.config/nvim/lua/find-calls",
        config = function()
            require("find-calls").setup()
        end
    },
    {
        dir = "~/.config/nvim/lua/api-lens.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("api-lens").setup()
        end,
    },
}

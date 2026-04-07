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
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end)

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end)

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk)
                    map('n', '<leader>hr', gitsigns.reset_hunk)

                    map('v', '<leader>hs', function()
                        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end)

                    map('v', '<leader>hr', function()
                        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end)

                    map('n', '<leader>hS', gitsigns.stage_buffer)
                    map('n', '<leader>hR', gitsigns.reset_buffer)
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

                    map('n', '<leader>hb', function()
                        gitsigns.blame_line({ full = true })
                    end)

                    map('n', '<leader>hd', gitsigns.diffthis)

                    map('n', '<leader>hD', function()
                        gitsigns.diffthis('~')
                    end)

                    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
                    map('n', '<leader>hq', gitsigns.setqflist)

                    -- Toggles
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                    map('n', '<leader>tw', gitsigns.toggle_word_diff)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
                end
            }
        end
    },
    {
        'bolteu/bolt-server.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            -- 'nvim-telescope/telescope.nvim',
            'folke/snacks.nvim'
        },
        -- commit = '3d9848f',
        -- cond = function()
        --     local cwd = vim.fn.getcwd()
        --     return cwd == "/Users/sergei/repos/taxify/server"
        -- end,
        config = function()
            local bolt = require("bolt-server")
            vim.keymap.set('n', "<leader>gs", bolt.find_service, { desc = "[G]o to [S]ervice" })
            vim.keymap.set('n', "<Leader>gc", bolt.find_service_comp_tests, { desc = "[G]o to [c]omp tests" })
            vim.keymap.set('n', "<Leader>gd", bolt.find_service_db_schema, { desc = "[G] to [d]b schema" })
            vim.keymap.set('n', "<Leader>p", bolt.find_service_files, { desc = "find files within current service" })
            vim.keymap.set('n', "<Leader>fis", bolt.grep_service_files, { desc = "grep files within current service" })
            vim.keymap.set('n', "<Leader>cs", bolt.compile_service, { desc = "[C]ompile [S]ervice" })
            vim.keymap.set('n', "<Leader>csf", bolt.compile_service_force, { desc = "[C]ompile [S]ervice ([F]orce)" })
            vim.keymap.set('n', "<Leader>cst", bolt.compile_service_with_tests,
                { desc = "[C]ompile [S]ervice with [T]ests" })
            vim.keymap.set('n', "<Leader>ags", bolt.api_gen_service, { desc = "[A]PI-[G]en [S]ervice" })
            vim.keymap.set('n', "<Leader>xs", bolt.select_comp_test_to_run, { desc = "E[x]ecute [S]elected test" })
            vim.keymap.set('n', "<Leader>xa", bolt.run_service_comp_tests, { desc = "E[x]ecute all service tests" })
            vim.keymap.set('n', "<Leader>xf", bolt.run_buffer_comp_tests, { desc = "E[x]ecute tests in the file" })
            vim.keymap.set('n', "<Leader>xx", bolt.run_comp_test_under_cursor, { desc = "E[x]ecute current test" })
            vim.keymap.set('n', "<Leader>gad", bolt.goto_api_definition, { desc = "[G]o to [A]PI [D]efinition" })
            vim.keymap.set('n', "<Leader>gae", bolt.goto_api_endpoint, { desc = "[G]o to [A]PI [E]ndpoint" })
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
            -- 'nvim-telescope/telescope.nvim',
            'folke/snacks.nvim'
        },
        cond = function()
            local cwd = vim.fn.getcwd()
            return cwd == "/Users/sergei/repos/taxify/admin-panel"
        end,
        config = function()
            local bolt = require("bolt-admin")
            vim.keymap.set('n', "<leader>gs", bolt.find_module, { desc = "Go to module" })
            vim.keymap.set('n', "<leader>cs", bolt.compile_module, { desc = "Compile module" })
            vim.keymap.set('n', "<leader>p", bolt.find_module_files, { desc = "find module files" })
        end
    },
    {
        "flyrry/jump-to-function.nvim",
        dev = true,
        config = function()
            require("jump-to-function").setup({})
        end
    },
    {
        "flyrry/bolt-api-lens.nvim",
        dependencies = { "folke/snacks.nvim" },
        dev = true,
        config = function()
            require("api-lens").setup({
                -- keymap_lsp = "<leader>ar",  -- LSP-based references (default)
                -- keymap_grep = "<leader>ac", -- Grep-based search (default)
                -- exclude_patterns = { "common/**" }, -- Exclude patterns (default)
                -- debug = false,              -- Debug logging (default: false)
            })
        end,
    },
}

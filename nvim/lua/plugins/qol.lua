return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            -- autokeys = "fhnmday1234567890",
            width = 120,
            sections = {
                { icon = "", title = "Recent Files ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
                { section = "recent_files", cwd = true, limit = 8, padding = 1, indent = 2 },
                -- { icon = "", title = "MRU", padding = 1 },
                -- { section = "recent_files", limit = 8, padding = 1, indent = 2 },
                { icon = "", title = "Projects", section = "projects", indent = 2, padding = 1 },
                -- { icon = "󰒲", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                -- { icon = "", key = "q", desc = "Quit", action = ":qa", padding = 1 },
                { section = "keys" },
                { section = "startup" },
                {
                    text = {
                        { "C-S\t\t\tsignature help\n" },
                        { "C-]\t\t\tgo to definition\n" },
                        { "gq\t\t\tformat using formatexpr (typically LSP)\n" },
                        { "<leader>ctn\t\ttoggle no-compile\n" },
                    }
                }
            },
        },
        -- explorer = { enabled = true }, -- ,ff
        indent = {
            animate = {
                duration = { total = 100 }
            },
            scope = { char = '╎', }
        },
        picker = {
            -- layout = {
            --     -- layout = {
            --     --     width = 0.9
            --     -- },
            --     fullscreen = true,
            -- },
            -- formatters = {
            --     file = {
            --         filename_first = true,
            --         -- truncate = 1000,
            --     },
            -- },
        },
        zen = { win = { width = 0.7 }, toggles = { dim = false } },
        toggle = { notify = false },
        quickfile = { enabled = true },
        -- scope = { enabled = true },
    },
    init = function()
        local snacks = require('snacks')
        snacks.toggle.zen():map("<leader>go")
        snacks.toggle.dim():map("<leader>gf")
        vim.keymap.set("n", "<C-p>", function() snacks.picker.files() end, { desc = "Find files" })
        vim.keymap.set('n', 'gD', function() snacks.picker.diagnostics() end, { desc = 'Show all diagnostics' })

        vim.keymap.set('n', '<leader>fh', function() snacks.picker.help() end, { desc = 'Help' })
        vim.keymap.set('n', '<leader>fq', function() snacks.picker.qflist() end, { desc = 'Quickfix' })
        vim.keymap.set('n', '<leader>fo', function() snacks.picker.recent() end, { desc = 'Recent' })
        vim.keymap.set('n', '<leader>fb', function() snacks.picker.buffers() end, { desc = 'Buffers' })
        vim.keymap.set('n', '<leader>fj', function() snacks.picker.jumps() end, { desc = 'Jumps' })
        vim.keymap.set('n', '<leader>fl', function() snacks.picker.lines() end, { desc = 'Lines' })

        vim.keymap.set('n', '<leader>fw', function() snacks.picker.grep_word() end, { desc = 'Word Grep' })

        vim.keymap.set('n', '<leader>fg', function() snacks.picker.git_files() end, { desc = 'Find git files' })
        vim.keymap.set('n', '<leader>bc', function() snacks.picker.git_log_file() end, { desc = 'Git commits' })

        vim.keymap.set('n', 'gd', function() snacks.picker.lsp_definitions() end, { desc = 'LSP: definitions' })
        vim.keymap.set('n', 'gt', function() snacks.picker.lsp_type_definitions() end, { desc = 'LSP: type definitions' })
        vim.keymap.set('n', 'gi', function() snacks.picker.lsp_implementations() end, { desc = 'LSP: implementations' })
        vim.keymap.set('n', 'gr', function() snacks.picker.lsp_references() end, { desc = 'LSP: references' })
        vim.keymap.set('n', 'gs', function() snacks.picker.lsp_symbols() end, { desc = 'LSP: symbols' })
        vim.keymap.set('n', 'gic', function() snacks.picker.lsp_incoming_calls() end, { desc = 'LSP: incoming calls' })
        vim.keymap.set('n', 'goc', function() snacks.picker.lsp_outgoing_calls() end, { desc = 'LSP: outgoing calls' })
    end
}

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
            layout = {
                -- layout = {
                --     width = 0.9
                -- },
                fullscreen = true,
            },
            formatters = {
                file = {
                    filename_first = true,
                    truncate = 1000,
                },
            },
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
        vim.keymap.set("n", "<C-p>", function() snacks.picker.files() end, { desc = "[F]ind files" })
    end
}

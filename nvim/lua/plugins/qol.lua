return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            -- autokeys = "fhnmday1234567890",
            sections = {
                { icon = "", title = "MRU", padding = 1 },
                { section = "recent_files", limit = 8, padding = 1, indent = 2 },
                { icon = "", title = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
                { section = "recent_files", cwd = true, limit = 8, padding = 1, indent = 2 },
                { icon = "", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { icon = "󰒲", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                { icon = "", key = "q", desc = "Quit", action = ":qa", padding = 1 },
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
        -- picker = { enabled = true }, -- telescope
        zen = { toggles = { dim = false } },
        toggle = { notify = false },
        quickfile = { enabled = true },
        -- scope = { enabled = true },
    },
    init = function()
        require('snacks').toggle.zoom():map("<leader>go")
        require('snacks').toggle.dim():map("<leader>gf")
    end
}

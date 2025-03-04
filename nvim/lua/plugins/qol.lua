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
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { icon = " ", key = "q", desc = "Quit", action = ":qa", padding = 1 },
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

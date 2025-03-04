return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        -- dashboard = { enabled = true }, -- startify
        -- explorer = { enabled = true }, -- ,ff
        indent = {
            animate = {
                duration = { total = 100 }
            },
            scope = { char = '╎', }
        },
        -- picker = { enabled = true }, -- telescope
        zen = { toggles = { dim = false } },
        dim = {},
        toggle = { notify = false },
        quickfile = { enabled = true },
        -- scope = { enabled = true },
    },
    init = function()
        require('snacks').toggle.zoom():map("<leader>go")
        require('snacks').toggle.dim():map("<leader>gf")
    end
}

return {
    {
        'saghen/blink.cmp',

        -- use a release tag to download pre-built binaries
        version = '*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',

        -- dependencies = { 'rafamadriz/friendly-snippets' },
        event = { "InsertEnter", "CmdlineEnter" },
        -- opts_extend = { "sources.default" },

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- snippets = { preset = "default" },
            -- appearance = {
            --     -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            --     -- Useful for when your theme doesn't support blink.cmp
            --     -- Will be removed in a future release
            --     use_nvim_cmp_as_default = false,
            --     -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            --     -- Adjusts spacing to ensure icons are aligned
            --     nerd_font_variant = 'mono'
            -- },
            -- completion = {
            --     -- accept = {
            --     --     auto_brackets = {
            --     --         enabled = false,
            --     --     }
            --     -- },
            --     -- menu = {
            --     --     draw = {
            --     --         treesitter = { "lsp" },
            --     --     },
            --     -- },
            --     -- documentation = {
            --     --     auto_show = true,
            --     --     auto_show_delay_ms = 200,
            --     -- },
            --     -- ghost_text = {
            --     --     enabled = vim.g.ai_cmp,
            --     -- },
            -- },
            -- sources = {
            --     default = { 'lsp', 'path', 'snippets', 'buffer' },
            -- },
            -- cmdline = {
            --     enabled = true,
            --     keymap = {
            --         preset = "cmdline",
            --         ["<Right>"] = false,
            --         ["<Left>"] = false,
            --     },
            --     completion = {
            --         list = { selection = { preselect = false } },
            --         menu = {
            --             auto_show = function(ctx)
            --                 return vim.fn.getcmdtype() == ":"
            --             end,
            --         },
            --         ghost_text = { enabled = true },
            --     },
            -- },
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            -- keymap = {
            --     preset = 'enter',
            --     ["<C-y>"] = { "select_and_accept" },
            -- },
            --
            -- signature = {
            --     -- Enable signature help
            --     enabled = true,
            --     window = {
            --         border = 'rounded',
            --         treesitter_highlighting = true
            --     }
            -- },
        },
    }
}

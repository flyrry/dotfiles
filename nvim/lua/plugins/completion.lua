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
            keymap = {
                preset = 'default',
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            completion = {
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
            },
            signature = {
                enabled = true,
            },
            cmdline = {
                enabled = true,
                keymap = {
                    preset = 'cmdline',
                    ['<Tab>'] = { 'select_and_accept' },
                    ['<C-j>'] = { 'select_next', 'fallback' },
                    ['<C-k>'] = { 'select_prev', 'fallback' },
                },
                completion = {
                    menu = { auto_show = true },
                    list = {
                        selection = {
                            preselect = true,
                            auto_insert = true,
                        },
                    },
                },
            },
        },
    }
}

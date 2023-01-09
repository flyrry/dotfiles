local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    sources = {
        {name = 'nvim_lsp'},
        {name = 'path'},
        {name = 'luasnip'},
        {name = 'orgmode'},
        {name = 'crates'},
        --{name = 'buffer'},
        --{name = 'nvim_lua'},
    },

    -- only works if source actually triess to preselect anything
    --preselect = cmp.PreselectMode.None,

    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        })
    },

    experimental = {
        ghost_text = true
    },

    formatting = {
        format = lspkind.cmp_format({
            with_text = false,
            menu = {
                nvim_lsp = '[lsp]',
                path = '[pth]',
                luasnip = '[snp]',
                orgmode = '[org]'
            }
        })
    }
}

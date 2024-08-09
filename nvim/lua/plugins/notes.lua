return {
    {
        {
            'mickael-menu/zk-nvim',
            config = function()
                require('zk').setup({
                    picker = "telescope"
                })
                require('which-key').add({
                    { '<leader>zn', '<Cmd>ZkNew { title = vim.fn.input("Title: ") }<CR>',                              desc = '[n]ew note' },
                    { '<leader>zo', '<Cmd>ZkNotes { sort = { "modified" } }<CR>',                                      desc = '[o]pen notes' },
                    { '<leader>zt', '<Cmd>ZkTags<CR>',                                                                 desc = 'list [t]ags' },
                    { '<leader>zf', '<Cmd>ZkNotes { sort = { "modified" }, match = { vim.fn.input("Match: ") } }<CR>', desc = '[f]ind matching' },
                })
                require('which-key').add({
                    {
                        { '<leader>zn', ":'<,'>ZkNewFromTitleSelection<CR>",   desc = '[n]ew note from selected title' },
                        { '<leader>zm', ":'<,'>ZkNewFromContentSelection<CR>", desc = '[n]ew note from selection' },
                        { '<leader>zf', ":'<,'>ZkMatch<CR>",                   desc = '[f]ind matching' },
                        { '<leader>zl', ":'<,'>ZkInsertLinkAtSelection<CR>",   desc = 'insert [l]ink' },
                    },
                    mode = { 'v' }
                })
            end
        }
    },
    {
        enabled = false,
        'nvim-neorg/neorg',
        build = ':Neorg sync-parsers',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            load = {
                ['core.defaults'] = {},
                ['core.concealer'] = {},
                ['core.dirman'] = {
                    config = {
                        workspaces = {
                            notes = '~/Documents/notes',
                            default_workspace = 'notes',
                        }
                    }
                }
            }
        },
    }
}

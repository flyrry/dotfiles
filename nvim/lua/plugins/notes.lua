return {
    {
        {
            'mickael-menu/zk-nvim',
            config = function()
                require('zk').setup({
                    picker = "telescope"
                })
                require('which-key').register({
                    ['<leader>z'] = {
                        name = '[z]k',
                        ['n'] = { '<Cmd>ZkNew { title = vim.fn.input("Title: ") }<CR>', '[n]ew note' },
                        ['o'] = { '<Cmd>ZkNotes { sort = { "modified" } }<CR>', '[o]pen notes' },
                        ['t'] = { '<Cmd>ZkTags<CR>', 'list [t]ags' },
                        ['f'] = { '<Cmd>ZkNotes { sort = { "modified" }, match = { vim.fn.input("Match: ") } }<CR>', '[f]ind matching' },
                    }
                })
                require('which-key').register({
                    ['<leader>z'] = {
                        ['n'] = { ":'<,'>ZkNewFromTitleSelection<CR>", '[n]ew note from selected title' },
                        ['m'] = { ":'<,'>ZkNewFromContentSelection<CR>", '[n]ew note from selection' },
                        ['f'] = { ":'<,'>ZkMatch<CR>", '[f]ind matching' },
                        ['l'] = { ":'<,'>ZkInsertLinkAtSelection<CR>", 'insert [l]ink' },
                    }
                }, { mode = 'v' })
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

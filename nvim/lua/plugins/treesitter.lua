return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs'.setup({
                highlight = { enable = true },
                indent = { enable = true },
                textobjects = { enable = true },
                ensure_installed = {
                    'bash',
                    'cpp',
                    'fish',
                    'javascript',
                    'json',
                    'lua',
                    'luadoc',
                    'markdown',
                    'python',
                    'regex',
                    'rust',
                    'tsx',
                    'typescript',
                    'vim',
                    'vimdoc',
                },
            })

            vim.o.foldmethod = 'expr'
            vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require 'nvim-treesitter.configs'.setup({
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                            [']a'] = '@parameter.inner',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                            ['[a'] = '@parameter.outer',
                        },
                    }
                }
            })
        end
    },
}

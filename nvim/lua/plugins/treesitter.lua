return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = {
                'bash',
                'cpp',
                'diff',
                'fish',
                'html',
                'javascript',
                'json',
                'lua',
                'luadoc',
                'markdown',
                'regex',
                'rust',
                'tsx',
                'typescript',
                'query',
                'vim',
                'vimdoc',
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        }
    },
}

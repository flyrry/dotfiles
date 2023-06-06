return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        config = function()
            local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
            --parser_config.org = {
            --    install_info = {
            --        url = 'https://github.com/milisims/tree-sitter-org',
            --        revision = 'main',
            --        files = {'src/parser.c', 'src/scanner.cc'},
            --    },
            --    filetype = 'org',
            --}

            --require('orgmode').setup_ts_grammar()

            require 'nvim-treesitter.configs'.setup({
                highlight = {
                    enable = true,
                    disable = { 'org' },
                    ----additional_vim_regex_highlighting = {'org'},
                },
                indent = { enable = true },
                ensure_installed = {
                    'bash',
                    'cpp',
                    'fish',
                    'javascript',
                    'json',
                    'lua',
                    'luadoc',
                    'markdown',
                    --'org',
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
}

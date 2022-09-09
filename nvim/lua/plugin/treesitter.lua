local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.used_by = { 'javascript', 'typescript.tsx' }
parser_config.org = {
    install_info = {
        url = 'https://github.com/milisims/tree-sitter-org',
        revision = 'main',
        files = {'src/parser.c', 'src/scanner.cc'},
    },
    filetype = 'org',
}

require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {'org'},
        --additional_vim_regex_highlighting = {'org'},
    },
    indent = {
        enable = false,
        disable = {},
    },
    ensure_installed = {
        'cpp',
        'fish',
        'org',
        'php',
        'python',
        'rust',
        'tsx',
        'typescript',
    },
}

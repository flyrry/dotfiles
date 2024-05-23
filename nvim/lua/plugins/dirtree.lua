return {
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        keys = {
            { '<leader>tt', ':NvimTreeToggle<CR>',   desc = '[T]oggle [T]ree',  silent = true },
            { '<leader>tf', ':NvimTreeFindFile<CR>', desc = '[F]ind In [T]ree', silent = true }
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            view = {
                width = 42
            },
            git = {
                enable = false
            },
            filters = {
                custom = { '\\.DS_Store$', '\\.js$', '\\.d\\.ts$', '\\.d\\.ts\\.map$' }
            }
        }
    },
    {
        'scrooloose/nerdtree',
        enabled = false,
        lazy = true,
        keys = {
            { '<leader>tt', ':NERDTreeToggle<Bar>wincmd p<CR>', desc = '[T]oggle [T]ree',  silent = true },
            { '<leader>tf', ':NERDTreeFind<Bar>wincmd p<CR>',   desc = '[F]ind In [T]ree', silent = true }
        },
        config = function()
            vim.g['NERDTreeWinSize'] = 42
            vim.g['NERDTreeStatusline'] = ''
            vim.g['NERDTreeMinimalUI'] = 1
            vim.g['NERDTreeShowHidden'] = 1
            vim.g['NERDTreeIgnore'] = { '.DS_Store', '.*.js', '.*.d.ts' }
            -- Quit neovim if NERDTree is the only window remaining
            vim.cmd([[
            autocmd! BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
            ]])
        end
    },
}

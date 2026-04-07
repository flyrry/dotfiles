return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').install({
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
                'swift',
                'tsx',
                'typescript',
                'query',
                'vim',
                'vimdoc',
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function()
                    local filetype = vim.bo.filetype
                    if filetype and filetype ~= "" then
                        pcall(vim.treesitter.start)
                    end
                end,
            })
        end,
    },
}

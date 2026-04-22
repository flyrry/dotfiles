return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local ts = require('nvim-treesitter')
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('treesitter-extra', { clear = true }),
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    local available_langs = ts.get_available()
                    if vim.tbl_contains(available_langs, lang) then
                        local installed_langs = ts.get_installed()
                        if not vim.tbl_contains(installed_langs, lang) then
                            ts.install(lang):wait(10000)
                        end
                        vim.treesitter.start()
                        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        vim.wo.foldmethod = 'expr'
                        vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
                    end
                end,
            })
        end,
    },
}

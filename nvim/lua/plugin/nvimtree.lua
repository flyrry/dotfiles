require("which-key").register({
    ["<leader>n"] = {
        t = {':NvimTreeToggle<CR>', "Toggle NvimTree"},
        r = {':NvimTreeRefresh<CR>', "Refresh NvimTree"},
        f = {':NvimTreeFindFile<CR>', "Find in NvimTree"},
    }
})

vim.g.nvim_tree_gitignore = 1
require'nvim-tree'.setup {
    auto_close = true,
    view = {
        side = 'left',
        width = 42
    },
    disable_netrw = false,
    hijack_netrw = false,
    filters = {
        dotfiles = true,
        ignored = {'.git', 'node_modules', '.cache'}
    }
}
--vim.g.nvim_tree_show_icons = {
--    ["git"] = false,
--    ["folders"] = true,
--    ["files"] = true,
--    ["folder_arrows"] = true,
--}

-- local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- vim.g.nvim_tree_bindings = {
--     {key = 'cd', cb = tree_cb('dir_up')},
-- }

require("which-key").register({
    ["<leader>n"] = {
        t = {':NvimTreeToggle<CR>', "Toggle NvimTree"},
        r = {':NvimTreeRefresh<CR>', "Refresh NvimTree"},
        f = {':NvimTreeFindFile<CR>', "Find in NvimTree"},
    }
})

vim.g.nvim_tree_width = 42
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_gitignore = 1
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

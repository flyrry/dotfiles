vim.g.startify_change_to_dir = false
vim.g.startify_enable_special = false
vim.g.startify_fortune_use_unicode = true
vim.g.startify_custom_indices = {'f', 'h', 'l', 'n', 'm', 'd', 'a', 'y'}
vim.g.startify_custom_header = [[startify#fortune#quote()]]
vim.g.startify_lists = {
    {['type'] = 'dir', ['header'] = {"   MRU " .. vim.fn.getcwd()}},
    {['type'] = 'files', ['header'] = {"   MRU"}},
    {['type'] = 'sessions', ['header'] = {"   Sessions"}, ['indices'] = {'l'}},
}


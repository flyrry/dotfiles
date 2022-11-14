local wk = require('which-key')
wk.register({
    ["<leader>f"] = {
        b = {":lua require('fzy').actions.buffers()<CR>", "Buffers"},
        f = {":lua require('fzy').execute('fd', require('fzy').sinks.edit_file)<CR>", "Find Files"},
        g = {":lua require('fzy').execute('git ls-files', require('fzy').sinks.edit_file)<CR>", "Git Files"},
        q = {":lua require('fzy').actions.quickfix()<CR>", "Quickfix"},
    },
    ["<C-p>"] = {":lua require('fzy').execute('fd', require('fzy').sinks.edit_file)<CR>", "Find Files"},
})

require('which-key').register({
    ["<leader>"] = {
        fed = {':e ~/.config/nvim/init.vim<CR>', "Edit nvim config"},
        fer = {':so ~/.config/nvim/init.vim<CR>', "Reload nvim config"},

        ['/'] = {':nohlsearch<CR>', "Clear highlighted search terms"},

        v = {':vsplit<CR>'},
        s = {':split<CR>'},

        t = {
            l = {':lvim /\\CTODO/ % | lw<CR>', "List TODOs"},
            t = {':lvim /\\CTHEN/ % | lw<CR>', "List THENs"},
            f = {':exec ":lvim /".input("Search string: ")."/ % | lw"<CR>', "Find in buffer"},
            c = {':s /- [TODO]/+/<CR>', "Mark TODO complete"},
            C = {':s /- [TODO]/+/<CR>dd/DONE<CR>p', "Mark TODO complete and archive"},
        },

        i = {
            n = {'"=strftime("%d.%m.%Y %H:%M:%S")<CR>P', "Insert date and time"},
            d = {'"=strftime("%d.%m.%Y")<CR>P', "Insert date"},
            t = {'"=strftime("%H:%M:%S")<CR>P', "Insert time"},
        },
    },
    j = {'gj'},
    k = {'gk'},
    ['<C-j>'] = {'<C-w>j'},
    ['<C-k>'] = {'<C-w>k'},
    ['<C-h>'] = {'<C-w>h'},
    ['<C-l>'] = {'<C-w>l'},
    S = {'"_diwP', "Replace"},
})

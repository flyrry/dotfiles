require('which-key').register({
    ['<C-j>'] = {'<C-w>j'},
    ['<C-k>'] = {'<C-w>k'},
    ['<C-h>'] = {'<C-w>h'},
    ['<C-l>'] = {'<C-w>l'},
    j = {'gj'},
    k = {'gk'},
    --S = {'"_diwP', "Replace"},
    ["<leader>"] = {
        fed = {':e ~/.config/nvim/init.lua<CR>', "Edit nvim config"},

        ['/'] = {':nohlsearch<CR>', "Clear highlighted search terms"},

        t = {
            l = {':lvim /\\CTODO/ % | lw<CR>', "List TODOs"},
            t = {':lvim /\\CTHEN/ % | lw<CR>', "List THENs"},
            f = {':exec ":lvim /".input("Search string: ")."/ % | lw"<CR>', "Find in buffer"},
            c = {':s /- \\[TODO\\]/+/<CR>', "Mark TODO complete"},
            C = {':s /- \\[TODO\\]/+/<CR>dd/DONE<CR>p', "Mark TODO complete and archive"},
        },

        i = {
            n = {'"=strftime("%d.%m.%Y %H:%M:%S")<CR>P', "Insert date and time"},
            d = {'"=strftime("%d.%m.%Y")<CR>P', "Insert date"},
            t = {'"=strftime("%H:%M:%S")<CR>P', "Insert time"},
        },

        s = {':split<CR>', "horizontal split"},
        v = {':vsplit<CR>', "vertical split"},
    },
}, {silent=true})

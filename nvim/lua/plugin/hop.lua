require('which-key').register({
    ['<leader>h'] = {
        w = {':HopWord<CR>', 'Hop to word'},
        h = {':HopChar2<CR>', 'Hop to bigram'},
        l = {':HopLineStart<CR>', 'Hop to line'},
        ['/'] = {':HopPattern<CR>', 'Hop to pattern'},
    }
})
require('hop').setup()

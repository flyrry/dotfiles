require('which-key').register({
    ['<leader>h'] = {
        h = {':HopWord<CR>', 'Hop to word'},
        w = {':HopChar2<CR>', 'Hop to bigram'},
        l = {':HopLineStart<CR>', 'Hop to line'},
        ['/'] = {':HopPattern<CR>', 'Hop to pattern'},
    }
})
require('hop').setup()

return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        tag = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'princejoogie/dir-telescope.nvim',
        },
        init = function()
            require('which-key').register({
                ['<C-p>'] = { ':lua require("telescope.builtin").find_files()<CR>', 'Find Files' },
                ['<leader>f'] = {
                    g = { ':lua require("telescope.builtin").git_files()<CR>', 'Find [G]it Files' },
                    q = { ':lua require("telescope.builtin").quickfix()<CR>', '[Q]uickfix' },
                    o = { ':lua require("telescope.builtin").oldfiles()<CR>', '[O]ld files' },
                    b = { ':lua require("telescope.builtin").buffers()<CR>', '[B]uffers' },
                    s = { ':lua require("telescope.builtin").live_grep()<CR>', '[S]earch Grep' },
                    S = { ':lua require("telescope").extensions.dir.live_grep()<CR>', '[S]earch Grep in <DIR>' },
                    w = { ':lua require("telescope.builtin").grep_string()<CR>', '[W]ord Grep' },
                },
            })
        end,
        config = function()
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('dir')
        end,
    },
}

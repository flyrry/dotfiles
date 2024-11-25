return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        lazy = true,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'princejoogie/dir-telescope.nvim',
            'bolteu/bolt.nvim',
        },
        init = function()
            local current_bolt_scope = function()
                return { search_dirs = { require("bolt.util").find_parent_subdir("main") } }
            end
            require('which-key').add({
                { '<leader>p',  ':lua require("telescope.builtin").find_files()<CR>',                                 desc = 'Find Files' },
                { '<leader>fg', ':lua require("telescope.builtin").git_files()<CR>',                                  desc = 'Find [G]it Files' },
                { '<leader>fq', ':lua require("telescope.builtin").quickfix()<CR>',                                   desc = '[Q]uickfix' },
                { '<leader>fo', ':lua require("telescope.builtin").oldfiles()<CR>',                                   desc = '[O]ld files' },
                { '<leader>fb', ':lua require("telescope.builtin").buffers()<CR>',                                    desc = '[B]uffers' },
                { '<leader>fs', ':lua require("telescope.builtin").live_grep()<CR>',                                  desc = '[S]earch Grep' },
                { '<leader>Fs', function() require("telescope.builtin").live_grep(current_bolt_scope()) end,          desc = '[S]earch Grep in scope' },
                { '<leader>fS', ':lua require("telescope").extensions.dir.live_grep()<CR>',                           desc = '[S]earch Grep in <DIR>' },
                { '<leader>Fw', function() require("telescope.builtin").grep_string(current_bolt_scope()) end,        desc = '[W]ord Grep in scope' },
                { '<leader>fw', ':lua require("telescope.builtin").grep_string()<CR>',                                desc = '[W]ord Grep' },
                { '<leader>ff', ':lua require("telescope").extensions.file_browser.file_browser({path="%:p:h"})<CR>', desc = 'File [F]inder' },
                { '<leader>bc', ':lua require("telescope.builtin").git_bcommits()<CR>',                               desc = 'Git [C]ommits' },
                { 'gd',         ':lua require("telescope.builtin").lsp_definitions()<CR>',                            desc = '[D]efinitions' },
                { 'gt',         ':lua require("telescope.builtin").lsp_type_definitions()<CR>',                       desc = '[T]ype definitions' },
                { 'gi',         ':lua require("telescope.builtin").lsp_implementations()<CR>',                        desc = '[I]mplementations' },
                { 'gr',         ':lua require("telescope.builtin").lsp_references({include_current_line=true})<CR>',  desc = '[R]eferences' },
                { 'gs',         ':lua require("telescope.builtin").lsp_document_symbols()<CR>',                       desc = 'Show document [s]ymbols' },
                { 'gic',        ':lua require("telescope.builtin").lsp_incoming_calls()<CR>',                         desc = '[I]ncoming [c]alls' },
                { 'goc',        ':lua require("telescope.builtin").lsp_outgoing_calls()<CR>',                         desc = '[O]utgoing [c]alls' },
                { 'gD',         ':lua require("telescope.builtin").diagnostics()<CR>',                                desc = 'Dia[g]nostics' },
            })
        end,
        config = function()
            require('telescope').setup({
                defaults = {
                    layout_strategy = 'flex',
                    layout_config = {
                        width = 0.9,
                        height = 0.9,
                        prompt_position = 'top',
                        flex = { flip_columns = 160 },
                    },
                    dynamic_preview_title = true,
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--trim" -- add this value
                    },
                    mappings = {
                        i = {
                            ['<Down>'] = require('telescope.actions').move_selection_next,
                            ['<C-j>'] = require('telescope.actions').move_selection_next,
                            ['<C-n>'] = require('telescope.actions').move_selection_next,

                            ['<Up>'] = require('telescope.actions').move_selection_previous,
                            ['<C-k>'] = require('telescope.actions').move_selection_previous,
                            ['<C-p>'] = require('telescope.actions').move_selection_previous,

                            ['<C-f>'] = require('telescope.actions').smart_send_to_qflist +
                                require('telescope.actions').open_qflist,
                            ['<C-l>'] = require('telescope.actions').smart_send_to_loclist +
                                require('telescope.actions').open_loclist,
                            ['<C-h>'] = "which_key",
                        },
                        n = {
                            ['<Down>'] = require('telescope.actions').move_selection_next,
                            ['j'] = require('telescope.actions').move_selection_next,
                            ['n'] = require('telescope.actions').move_selection_next,

                            ['<Up>'] = require('telescope.actions').move_selection_previous,
                            ['k'] = require('telescope.actions').move_selection_previous,
                            ['p'] = require('telescope.actions').move_selection_previous,

                            ['<C-f>'] = require('telescope.actions').smart_send_to_qflist +
                                require('telescope.actions').open_qflist,
                            ['<C-l>'] = require('telescope.actions').smart_send_to_loclist +
                                require('telescope.actions').open_loclist,
                        },
                    },
                },
                extensions = {
                    -- fzf = {
                    --     override_generic_sorter = false,
                    --     override_file_sorter = true,
                    -- },
                },
            })

            require('telescope').load_extension('fzf')
            require('telescope').load_extension('dir')
            require('telescope').load_extension('file_browser')
        end,
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope.nvim', branch = '0.1.x' }
        },
    }
}

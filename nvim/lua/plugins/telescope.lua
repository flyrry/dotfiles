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
                { '<leader>P',  ':lua require("telescope.builtin").find_files()<CR>', desc = 'Find Files' },
                {
                    '<leader>mp',
                    function()
                        require("telescope.builtin").find_files({
                            ---@diagnostic disable-next-line: param-type-mismatch
                            cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
                        })
                    end,
                    desc = 'Find [M]odule files'
                },
                { '<leader>fh', ':Telescope help_tags<CR>',                           desc = '[F]ind [H]elp' },
                { '<leader>fg', ':lua require("telescope.builtin").git_files()<CR>',  desc = 'Find [G]it Files' },
                { '<leader>fq', ':lua require("telescope.builtin").quickfix()<CR>',   desc = '[Q]uickfix' },
                { '<leader>fo', ':lua require("telescope.builtin").oldfiles()<CR>',   desc = '[O]ld files' },
                { '<leader>fb', ':lua require("telescope.builtin").buffers()<CR>',    desc = '[B]uffers' },
                {
                    '<leader>fs',
                    function()
                        require("telescope.builtin").live_grep({
                            attach_mappings = function(_, map)
                                map("i", "<space><space>", require("telescope.actions").to_fuzzy_refine)
                                map("i", "<leader>c", function(prompt_bufnr)
                                    require("telescope.actions").to_fuzzy_refine(prompt_bufnr)
                                    vim.api.nvim_put({ "!gen !comp" }, "c", true, true)
                                end)
                                map("i", "<leader>e", function(prompt_bufnr)
                                    local sorter = require("telescope.config").values.generic_sorter {}
                                    local action_state = require("telescope.actions.state")
                                    local current_picker = action_state.get_current_picker(prompt_bufnr)
                                    if current_picker.prompt_border then
                                        current_picker.prompt_border:change_title(string.format("Find Word!: (%s)",
                                            action_state.get_current_line()))
                                    end
                                    current_picker.sorter:_destroy()
                                    current_picker.sorter = sorter
                                    current_picker.sorter:_init()
                                    vim.api.nvim_put({ "!gen !comp" }, "c", true, true)
                                end)
                                -- needs to return true if you want to map default_mappings and
                                -- false if not
                                return true
                            end,
                        })
                    end,
                    desc = '[S]earch Grep'
                },
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
                        prompt_position = 'bottom',
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
                    -- --     override_generic_sorter = false,
                    -- --     override_file_sorter = true,
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

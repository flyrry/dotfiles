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
            'nvim-telescope/telescope-file-browser.nvim',
            'bolteu/bolt-server.nvim',
            'nvim-telescope/telescope-ui-select.nvim'
        },
        init = function()
            local fuzzy_refine_mappings = {
                attach_mappings = function(_, map)
                    map("i", "<space><space>", require("telescope.actions").to_fuzzy_refine)
                    map("i", "<leader>c", function(prompt_bufnr)
                        require("telescope.actions").to_fuzzy_refine(prompt_bufnr)
                        vim.api.nvim_put({ "!gen/ !mcomp/ !-comp.ts !-spec.ts" }, "c", true, true)
                    end)
                    -- needs to return true if you want to map default_mappings and
                    -- false if not
                    return true
                end,
            }
            local set_bolt_scope = function()
                return { search_dirs = { require("bolt-server.util").find_parent_subdir("main") } }
            end
            local set_scope_and_refine_mappings = function()
                return vim.tbl_extend('keep', set_bolt_scope(), fuzzy_refine_mappings)
            end
            vim.keymap.set('n', '<leader>P', ':lua require("telescope.builtin").find_files()<CR>', { desc = 'Find Files' })
            vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { desc = '[F]ind [H]elp' })
            vim.keymap.set('n', '<leader>fg', ':lua require("telescope.builtin").git_files()<CR>', { desc = 'Find [G]it Files' })
            vim.keymap.set('n', '<leader>fq', ':lua require("telescope.builtin").quickfix()<CR>', { desc = '[Q]uickfix' })
            vim.keymap.set('n', '<leader>fo', ':lua require("telescope.builtin").oldfiles()<CR>', { desc = '[O]ld files' })
            vim.keymap.set('n', '<leader>fb', ':lua require("telescope.builtin").buffers()<CR>', { desc = '[B]uffers' })
            vim.keymap.set('n', '<leader>fs', function() require("telescope.builtin").live_grep(fuzzy_refine_mappings) end, { desc = '[S]earch Grep' })
            vim.keymap.set('n', '<leader>fc', function() require("telescope.builtin").find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
            vim.keymap.set('n', '<leader>Fs', function() require("telescope.builtin").live_grep(set_scope_and_refine_mappings()) end, { desc = '[S]earch Grep in Bolt scope' })
            vim.keymap.set('n', '<leader>fS', function() require("telescope").extensions.dir.live_grep(fuzzy_refine_mappings) end, { desc = '[S]earch Grep in <DIR>' })
            vim.keymap.set('n', '<leader>Fw', function() require("telescope.builtin").grep_string(set_scope_and_refine_mappings()) end, { desc = '[W]ord Grep in Bolt scope' })
            vim.keymap.set('n', '<leader>fw', ':lua require("telescope.builtin").grep_string()<CR>', { desc = '[W]ord Grep' })
            vim.keymap.set('n', '<leader>ff', ':lua require("telescope").extensions.file_browser.file_browser({path="%:p:h"})<CR>', { desc = 'File [F]inder' })
            vim.keymap.set('n', '<leader>bc', ':lua require("telescope.builtin").git_bcommits()<CR>', { desc = 'Git [C]ommits' })
            vim.keymap.set('n', 'gd', ':lua require("telescope.builtin").lsp_definitions()<CR>', { desc = '[D]efinitions' })
            vim.keymap.set('n', 'gt', ':lua require("telescope.builtin").lsp_type_definitions()<CR>', { desc = '[T]ype definitions' })
            vim.keymap.set('n', 'gi', ':lua require("telescope.builtin").lsp_implementations()<CR>', { desc = '[I]mplementations' })
            vim.keymap.set('n', 'gr', function() require('snacks').picker.lsp_references() end, { desc = '[R]eferences' })
            vim.keymap.set('n', 'gs', ':lua require("telescope.builtin").lsp_document_symbols()<CR>', { desc = 'Show document [s]ymbols' })
            vim.keymap.set('n', 'gic', ':lua require("telescope.builtin").lsp_incoming_calls()<CR>', { desc = '[I]ncoming [c]alls' })
            vim.keymap.set('n', 'goc', ':lua require("telescope.builtin").lsp_outgoing_calls()<CR>', { desc = '[O]utgoing [c]alls' })
            vim.keymap.set('n', 'gD', ':lua require("telescope.builtin").diagnostics()<CR>', { desc = 'Dia[g]nostics' })
            vim.keymap.set('n', '<leader>mp', function()
                require("telescope.builtin").find_files({
                    ---@diagnostic disable-next-line: param-type-mismatch
                    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
                })
            end, { desc = 'Find [M]odule files' })
        end,
        config = function()
            require('telescope').setup({
                defaults = {
                    layout_strategy = 'flex',
                    layout_config = {
                        width = 0.9,
                        height = 0.9,
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
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({})
                    },
                },
            })

            require('telescope').load_extension('fzf')
            require('telescope').load_extension('dir')
            require('telescope').load_extension('file_browser')
            require('telescope').load_extension('ui-select')
        end,
    },
}

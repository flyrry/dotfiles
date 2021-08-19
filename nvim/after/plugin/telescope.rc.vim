if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent><leader>fb :Telescope buffers<CR>
nnoremap <silent><leader>fo :Telescope oldfiles<CR>
nnoremap <silent><leader>fm :Telescope git_status<CR>
nnoremap <silent><C-p> :Telescope find_files<CR>

nnoremap <silent>gr :Telescope lsp_references<CR>
nnoremap <silent><leader>fs :Telescope live_grep<CR>
nnoremap <silent><leader>fw :Telescope grep_string<CR>

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "->",
    entry_prefix = "  ",
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      }
    }
  },
  pickers = {
    find_files = {
      theme = "ivy"
    },
    git_status = {
      theme = "dropdown",
      previewer = false
    },
    lsp_references = {
      theme = "cursor",
      layout_config = {
        width = 0.9
      }
    }
  }
}
EOF

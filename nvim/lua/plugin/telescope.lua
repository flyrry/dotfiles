require("which-key").register({
    ["<leader>f"] = {
        b = {':Telescope buffers<CR>', "Buffers"},
        o = {':Telescope oldfiles<CR>', "History"},
        m = {':Telescope git_status<CR>', "Git Changes"},
        s = {':Telescope live_grep<CR>', "Find String"},
        w = {':Telescope grep_string<CR>', "Find Word"},
    },
    ["<C-p>"] = {':Telescope find_files<CR>', "Find Files"},
    ["gr"] = {':Telescope lsp_references<CR>', "Find References"},
})

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

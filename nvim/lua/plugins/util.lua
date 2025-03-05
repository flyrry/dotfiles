return {
  'github/copilot.vim',
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').add({
        { "<leader>/", ':nohlsearch<CR>', desc = "Clear highlighted search terms" },
        { '<leader>s', ':split<CR>',      desc = "horizontal [s]plit" },
        { '<leader>v', ':vsplit<CR>',     desc = "[v]ertical split" },
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = { enabled = false }
      }
    },
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<C-g>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  'christoomey/vim-tmux-navigator',
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf', build = './install --all' },
    keys = {
      { '<C-p>', ':Files<CR>', desc = 'Find Files' },
      -- {'<leader>f', ':Rg<CR>', desc = 'Search Grep'},
      -- {'<leader>g', ':GFiles<CR>', desc = 'Find [G]it Files'},
      -- {'<leader>q', ':Quickfix<CR>', desc = '[Q]uickfix'},
      -- {'<leader>o', ':History<CR>', desc = '[O]ld files'},
      -- {'<leader>b', ':Buffers<CR>', desc = '[B]uffers'},
      -- {'<leader>s', ':Rg<CR>', desc = '[S]earch Grep'},
      -- {'<leader>S', ':Files<CR>', desc = '[S]earch Grep in <DIR>'},
      -- {'<leader>w', ':Rg<CR>', desc = '[W]ord Grep'},
      -- {'<leader>c', ':Files<CR>', desc = 'Find [C]urrent File'},
    },
    config = function()
      vim.g.fzf_layout = { window = { width = 0.9, height = 0.75 } }
      vim.g.fzf_preview_window = { 'right,50%,<70(up,50%)', 'ctrl-/' }
    end
  },
}

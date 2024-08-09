return {
  'github/copilot.vim',
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').add({
        { "<C-j>",     "<C-w>j" },
        { "<C-k>",     "<C-w>k" },
        { "<C-h>",     "<C-w>h" },
        { "<C-l>",     "<C-w>l" },

        { "<leader>/", ':nohlsearch<CR>', desc = "Clear highlighted search terms" },
        { '<leader>s', ':split<CR>',      desc = "horizontal split" },
        { '<leader>v', ':vsplit<CR>',     desc = "vertical split" },
      })
    end,
  },
  {
    'ggandor/leap.nvim',
    config = true,
    keys = {
      { 's',  '<Plug>(leap-forward-to)',   desc = 'Leap forward',  silent = true },
      { 'S',  '<Plug>(leap-backward-to)',  desc = 'Leap backward', silent = true },
      { 'gs', '<Plug>(leap-cross-window)', desc = 'Leap across',   silent = true },
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

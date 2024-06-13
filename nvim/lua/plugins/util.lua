return {
  'github/copilot.vim',
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').register({
        ["<C-j>"] = { "<C-w>j" },
        ["<C-k>"] = { "<C-w>k" },
        ["<C-h>"] = { "<C-w>h" },
        ["<C-l>"] = { "<C-w>l" },

        --j = {'gj'},
        --k = {'gk'},
        --S = {'"_diwP', "Replace"},
        ["<leader>"] = {
          --fed = {':e ~/.config/nvim/init.lua<CR>', "Edit nvim config"},

          ['/'] = { ':nohlsearch<CR>', "Clear highlighted search terms" },

          --t = {
          --l = {':lvim /\\CTODO/ % | lw<CR>', "List TODOs"},
          --t = {':lvim /\\CTHEN/ % | lw<CR>', "List THENs"},
          --f = {':exec ":lvim /".input("Search string: ")."/ % | lw"<CR>', "Find in buffer"},
          --c = {':s /- \\[TODO\\]/+/<CR>', "Mark TODO complete"},
          --C = {':s /- \\[TODO\\]/+/<CR>dd/DONE<CR>p', "Mark TODO complete and archive"},
          --},

          --i = {
          --n = {'"=strftime("%d.%m.%Y %H:%M:%S")<CR>P', "Insert date and time"},
          --d = {'"=strftime("%d.%m.%Y")<CR>P', "Insert date"},
          --t = {'"=strftime("%H:%M:%S")<CR>P', "Insert time"},
          --},

          s = { ':split<CR>', "horizontal split" },
          v = { ':vsplit<CR>', "vertical split" },
        },
      }, { silent = true })
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
    dependencies = { 'junegunn/fzf', build = './install --all'},
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
  {
    'camspiers/snap',
    config = function()
      local snap = require('snap')
      snap.maps({
        { "<leader>o", snap.config.file { producer = "ripgrep.file", consumer = "fzf" } },
        -- {"<leader>f", snap.config.vimgrep {}},
        -- {"<leader>g", snap.config.vimgrep { input = vim.fn.expand("<cword>") }},
        -- {"<leader>q", snap.config.qf {}},
        -- {"<leader>o", snap.config.oldfile {}},
        -- {"<leader>b", snap.config.file { producer = "vim.buffer" }},
        -- {"<leader>s", snap.config.vimgrep { input = vim.fn.expand("<cword>") }},
        -- {"<leader>S", snap.config.file { producer = "vim.buffer" }},
        -- {"<leader>w", snap.config.vimgrep { input = vim.fn.expand("<cword>") }},
        -- {"<leader>c", snap.config.file { producer = "vim.buffer" }},
      })
    end,
  }
}

local M = {}

function M.setup(opts)
  opts = opts or {}
  local keymap = opts.keymap or "<leader>ar"
  vim.api.nvim_set_keymap('n', keymap, '<cmd>FindApiReferences<cr>', { noremap = true, silent = true })
end

vim.api.nvim_create_user_command('FindApiReferences', function()
  require('api-lens').find_references()
end, { desc = "Find references for an API call" })

return M 
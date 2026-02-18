local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Highlight references of word under cursor on CursorHold
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_cursor_hold_highlight"),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client or not client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      return
    end

    local bufnr = event.buf
    local buf_augroup = vim.api.nvim_create_augroup("lsp_cursor_hold_highlight_buf_" .. bufnr, { clear = true })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = buf_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      group = buf_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      buffer = bufnr,
      group = buf_augroup,
      callback = function()
        vim.lsp.buf.clear_references()
        pcall(vim.api.nvim_del_augroup_by_id, buf_augroup)
      end,
    })
  end,
})
-- -- make CursorHold highlights standout even more
-- vim.api.nvim_set_hl(0, 'LspReferenceRead', { standout = true })
-- vim.api.nvim_set_hl(0, 'LspReferenceWrite', { standout = true })
-- vim.api.nvim_set_hl(0, 'LspReferenceText', { standout = true })

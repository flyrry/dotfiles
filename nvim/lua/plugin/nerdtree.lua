-- Set default width for Nerdtree window
vim.g['NERDTreeWinSize'] = 42

-- Hide the Nerdtree status line to avoid clutter
vim.g['NERDTreeStatusline'] = ''

-- Remove bookmarks and help text from NERDTree
vim.g['NERDTreeMinimalUI'] = 1

-- Show hidden files/directories
vim.g['NERDTreeShowHidden'] = 1

-- Hide certain files and directories from NERDTree
vim.g['NERDTreeIgnore'] = {'.DS_Store', '.*.js', '.*.d.ts'}
--vim.g['NERDTreeIgnore'] = {'\^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.map$'}

-- Quit neovim if NERDTree is the only window remaining
vim.cmd(
    [[
        autocmd! BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    ]]
)


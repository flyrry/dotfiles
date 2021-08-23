if !exists('g:loaded_tree') | finish | endif

nnoremap <silent><leader>nt :NvimTreeToggle<CR>
nnoremap <silent><leader>nr :NvimTreeRefresh<CR>
nnoremap <silent><leader>nf :NvimTreeFindFile<CR>

let g:nvim_tree_width = 42
"let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
au WinClosed * lua require'nvim-tree'.on_leave()
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 1
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }

lua <<EOF
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback

  vim.g.nvim_tree_bindings = {
--    { key = {"<CR>", "o"}, cb = tree_cb("edit") },
--    { key = {"<C-]>"},     cb = tree_cb("cd") },
--    { key = "<C-v>",       cb = tree_cb("vsplit") },
--    { key = "<C-x>",       cb = tree_cb("split") },
--    { key = "<C-t>",       cb = tree_cb("tabnew") },
--    { key = "<",           cb = tree_cb("prev_sibling") },
--    { key = ">",           cb = tree_cb("next_sibling") },
--    { key = "P",           cb = tree_cb("parent_node") },
--    { key = "<BS>",        cb = tree_cb("close_node") },
--    { key = "<S-CR>",      cb = tree_cb("close_node") },
--    { key = "<Tab>",       cb = tree_cb("preview") },
--    { key = "K",           cb = tree_cb("first_sibling") },
--    { key = "J",           cb = tree_cb("last_sibling") },
--    { key = "I",           cb = tree_cb("toggle_ignored") },
--    { key = "H",           cb = tree_cb("toggle_dotfiles") },
--    { key = "R",           cb = tree_cb("refresh") },
--    { key = "a",           cb = tree_cb("create") },
--    { key = "d",           cb = tree_cb("remove") },
--    { key = "r",           cb = tree_cb("rename") },
--    { key = "<C-r>",       cb = tree_cb("full_rename") },
--    { key = "x",           cb = tree_cb("cut") },
--    { key = "c",           cb = tree_cb("copy") },
--    { key = "p",           cb = tree_cb("paste") },
--    { key = "y",           cb = tree_cb("copy_name") },
--    { key = "Y",           cb = tree_cb("copy_path") },
--    { key = "gy",          cb = tree_cb("copy_absolute_path") },
--    { key = "[c",          cb = tree_cb("prev_git_item") },
--    { key = "]c",          cb = tree_cb("next_git_item") },
--    { key = "-",           cb = tree_cb("dir_up") },
--    { key = "q",           cb = tree_cb("close") },
--    { key = "g?",          cb = tree_cb("toggle_help") },
  }
EOF

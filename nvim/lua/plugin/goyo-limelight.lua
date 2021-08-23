require("which-key").register({
    ["go"] = {':Goyo<CR>', "Toggle Focus Mode"}
})

vim.cmd([[autocmd! User GoyoEnter Limelight]])
vim.cmd([[autocmd! User GoyoLeave Limelight!]])

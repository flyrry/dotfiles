vim.g['fzf_layout'] = {['window'] = {['width'] = 1, ['height'] = 1}}

require("which-key").register({
    ["<leader>"] = {
        --["do"] = {':FzfLua lsp_code_actions<CR>', "Do Code Action"},
        ["hd"] = {':FzfLua lsp_definitions<CR>', "Show Definition"},
        e = {
            f = {':FzfLua lsp_document_diagnostics<CR>', "Show File Diagnostics"},
            a = {':FzfLua lsp_workspace_diagnostics<CR>', "Show All Diagnostics"},
        },
    },
    ["gr"] = {':FzfLua lsp_references<CR>', "Find References"},
})

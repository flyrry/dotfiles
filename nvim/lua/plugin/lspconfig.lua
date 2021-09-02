--vim.lsp.set_log_level("debug")
local nvim_lsp = require('lspconfig')
local protocol = require'vim.lsp.protocol'

local on_attach = function(client, bufnr)

    require("which-key").register({
        g = {
            d = {':lua vim.lsp.buf.definition()<CR>', 'Definition'},
            D = {':lua vim.lsp.buf.declaration()<CR>', 'Declaration'},
            t = {':lua vim.lsp.buf.type_definition()<CR>', 'Type definition'},
            i = {':lua vim.lsp.buf.implementation()<CR>', 'Implementation'},
            f = {':lua vim.lsp.buf.formatting()<CR>', 'Format document'},
            -- using Lspsaga or Telescope for these
            --r = {':lua vim.lsp.buf.references()<CR>', 'References'},
        },
    }, {
        buffer = bufnr
    })

    require("lsp_signature").on_attach({
        hint_prefix = '',
    })

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- using Lspsaga or Telescope for these
    --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    --buf_set_keymap('n', '<leader>ep', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    --buf_set_keymap('n', '<leader>en', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    --buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    --buf_set_keymap('n', '<leader>do', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    --buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

nvim_lsp.tsserver.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end
}

nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

local filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
}
local linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = {".eslintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
    }
}
local formatters = {
    eslint = {command = "eslint_d", args = {"--stdin", "--stdin-filename", "%filename", "--fix-to-stdout"}},
    prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
}
local formatFiletypes = {
    css = "prettier",
    javascript = {"prettier", "eslint"},
    javascriptreact = {"prettier", "eslint"},
    json = "prettier",
    scss = "prettier",
    less = "prettier",
    markdown = "prettier",
    typescript = {"prettier", "eslint"},
    typescriptreact = {"prettier", "eslint"},
}
nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        --underline = true,
        --virtual_text = {
            --spacing = 4,
            --prefix = ''
        --},
        virtual_text = true,
        --signs = true,
        update_in_insert = true,
    }
)
vim.opt.signcolumn = "yes"

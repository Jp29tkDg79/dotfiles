local M = {}

M.on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    local opts = { noremap = true, silent = true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = {
            border = "rounded",
        },
    }, bufnr)

    -- Configure for jdtls
    if client.name == "jdtls" then
        require("jdtls").setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()
        vim.lsp.codelens.refresh()
    end

    -- gopls semantic support
    if client.name == "gopls" then
        if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
            }
        end
    end
end

return M

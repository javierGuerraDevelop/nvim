require('lspconfig').rust_analyzer.setup {
    on_attach = function(client, bufnr)
        -- Enable formatting
        client.server_capabilities.documentFormattingProvider = true
    end,
}

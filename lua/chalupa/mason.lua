return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            {
                'j-hui/fidget.nvim',
                tag = 'legacy',
                opts = {}
            },
            'folke/neodev.nvim'
        },
        config = function()
            -- Configure diagnostics
            local diagnostic = require('vim.diagnostic')
            diagnostic.config({
                virtual_text = {
                    prefix = '■', -- Icon or character before the error
                    spacing = 4, -- Space between code and diagnostic text
                    format = function(diag)
                        return string.format('%s', diag.message) -- Show full error message
                    end,
                },
                virtual_lines = false, -- Disable virtual lines
                signs = {
                    active = true, -- Show signs in the sign column
                    values = {
                        { name = "DiagnosticSignError", text = "" },
                        { name = "DiagnosticSignWarn", text = "" },
                        { name = "DiagnosticSignHint", text = "" },
                        { name = "DiagnosticSignInfo", text = "" },
                    },
                },
                underline = true, -- Underline errors
                update_in_insert = false, -- Don’t update diagnostics while typing
                severity_sort = true, -- Sort by severity (errors first)
            })

            -- Define custom signs for the sign column
            local signs = { Error = "", Warn = "", Hint = "", Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- Set custom highlight groups for diagnostics
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = '#FF0000', bg = '#3A3A3A' })
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = '#FFA500', bg = '#3A3A3A' })
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = '#00FFFF', bg = '#3A3A3A' })
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = '#00FF00', bg = '#3A3A3A' })

            -- On-attach function for keybindings
            local on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end

                nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
                nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
                nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
                nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
            end

            -- Mason setup
            require("mason").setup({
                PATH = "append",
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })

            -- Clangd setup with formatting
            require('lspconfig').clangd.setup({
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    -- Enable formatting
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })

            -- Server configurations
            local servers = {
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false }
                    }
                },
                ts_ls = {}, -- Add ts_ls for TypeScript/JavaScript
            }

            -- LSP capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- Mason-lspconfig setup
            local mason_lspconfig = require 'mason-lspconfig'
            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers)
            }
            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes
                    }
                end
            }
        end
    }
}

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
                    active = true,     -- Show signs in the sign column
                    values = {
                        { name = "DiagnosticSignError", text = "" },
                        { name = "DiagnosticSignWarn", text = "" },
                        { name = "DiagnosticSignHint", text = "" },
                        { name = "DiagnosticSignInfo", text = "" },
                    },
                },
                underline = true,         -- Underline errors
                update_in_insert = false, -- Don’t update diagnostics while typing
                severity_sort = true,     -- Sort by severity (errors first)
            })

            -- Define custom signs for the sign column
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    }
                }
            })

            -- Set custom highlight groups for diagnostics
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = '#FF0000', bg = '#3A3A3A' })
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = '#FFA500', bg = '#3A3A3A' })
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = '#00FFFF', bg = '#3A3A3A' })
            vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = '#00FF00', bg = '#3A3A3A' })

            -- On-attach function for keybindings
            local on_attach = function(client, bufnr)
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

            -- Mason-lspconfig setup
            local mason_lspconfig = require 'mason-lspconfig'
            mason_lspconfig.setup {
                ensure_installed = { 'lua_ls', 'ts_ls', 'clangd' }, -- List servers to install
                automatic_installation = true,                      -- Optional: Automatically install servers
            }

            -- LSP capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- Server configurations
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false }
                        }
                    }
                },
                ts_ls = {}, -- TypeScript/JavaScript
                clangd = {
                    on_attach = function(client, bufnr)
                        on_attach(client, bufnr)
                        -- Enable formatting for clangd
                        if client.supports_method("textDocument/formatting") then
                            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
                            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        end
                    end,
                },
            }

            -- Set up each server explicitly
            for server_name, config in pairs(servers) do
                vim.lsp.config[server_name].setup = {
                    capabilities = capabilities,
                    on_attach = config.on_attach or on_attach,
                    settings = config.settings or {},
                    filetypes = config.filetypes or nil,
                }
            end
        end
    }
}

return {
        {
                'nvim-treesitter/nvim-treesitter',
                dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
                build = ':TSUpdate',
                config = function()
                        vim.filetype.add({
                                extension = {
                                        sh = 'bash',
                                        zsh = 'bash'
                                },
                                pattern = {
                                        ['.*/%.sh'] = 'bash',
                                        ['.*/%.zsh'] = 'bash',
                                        ['.*zshrc.*'] = 'bash',
                                }
                        })
                        require('nvim-treesitter.configs').setup {
                                ensure_installed = { 'lua', 'python', 'rust', 'tsx', 'typescript', 'javascript', 'vimdoc', 'vim', 'bash', 'html',
                                        'css', 'sql', 'cpp' },
                                sync_install = false,
                                ignore_install = {},
                                auto_install = true,
                                highlight = { enable = true },
                                indent = { enable = false },
                                modules = {}
                        }
                end
        }
}

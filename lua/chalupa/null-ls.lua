return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('null-ls').setup({
                sources = {
                    require('null-ls').builtins.formatting.black.with({
                        extra_args = { '--line-length', '140' }
                    }),
                    require('null-ls').builtins.formatting.prettier.with({})
                }
            })
        end
    }
} 
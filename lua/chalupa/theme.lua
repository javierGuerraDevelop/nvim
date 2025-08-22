return {
    {
        'projekt0n/github-nvim-theme',
        lazy = false,    -- Load during startup
        priority = 1000, -- Load before other plugins
        config = function()
            require('github-theme').setup({
                options = {
                    transparent = true,        -- Enable/disable transparent background
                    hide_end_of_buffer = true, -- Hide '~' at end of buffer
                    dim_inactive = false,      -- Dim inactive windows
                    module_default = true,     -- Enable default modules (LSP, TreeSitter, etc.)

                    styles = {
                        comments = "italic",
                        keywords = "bold",
                        types = "bold",
                    },
                },
            })
            vim.cmd('colorscheme github_dark') -- Options: github_dark, github_light, github_dimmed, etc.
            -- vim.cmd('colorscheme github_light') -- Options: github_dark, github_light, github_dimmed, etc.
        end,
    },
}


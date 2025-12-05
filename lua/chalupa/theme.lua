return {
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = false,    -- Load during startup
        priority = 1000, -- Load before other plugins
        config = function()
            require("github-theme").setup({
                options = {
                    transparent = true,         -- Enable transparent background
                    terminal_colors = false,    -- Sets terminal colors
                    dim_inactive = false,       -- Dim inactive windows
                    hide_end_of_buffer = false, -- Show '~' characters after end of buffer
                    hide_nc_statusline = true,
                    styles = {
                        comments = "NONE",
                        conditionals = "NONE",
                        constants = "NONE",
                        functions = "NONE",
                        keywords = "NONE",
                        numbers = "NONE",
                        operators = "NONE",
                        strings = "NONE",
                        types = "bold",
                        variables = "NONE",
                    },
                },
            })
        end,
    },
}

return {
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        lazy = false,    -- Load during startup
        priority = 1000, -- Load before other plugins
        config = function()
            require("gruvbox").setup({
                transparent_mode = true, -- Enable transparent background
                terminal_colors = false, -- Sets terminal colors
                dim_inactive = false,    -- Dim inactive windows
                italic = {
                    strings = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                bold = true,
                overrides = {
                    -- You can add custom overrides here if needed
                },
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },
}

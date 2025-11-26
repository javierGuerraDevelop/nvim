return {
        {
                "catppuccin/nvim",
                name = "catppuccin",
                lazy = false, -- Load during startup
                priority = 1000, -- Load before other plugins
                config = function()
                        require("catppuccin").setup({
                                flavour = "mocha", -- latte, frappe, macchiato, mocha
                                transparent_background = true,
                                show_end_of_buffer = true, -- Show '~' characters after end of buffer
                                term_colors = false, -- Sets terminal colors
                                dim_inactive = {
                                        enabled = false, -- Dim inactive windows
                                        shade = "dark",
                                        percentage = 0.15,
                                },
                                no_italic = false, -- Force no italic
                                no_bold = false, -- Force no bold
                                no_underline = false, -- Force no underline
                                styles = {
                                        comments = {},
                                        conditionals = {},
                                        loops = {},
                                        functions = {},
                                        keywords = {},
                                        strings = {},
                                        variables = {},
                                        numbers = {},
                                        booleans = {},
                                        properties = {},
                                        types = { "bold" },
                                        operators = {},
                                },
                                color_overrides = {},
                                custom_highlights = {},
                                integrations = {
                                        cmp = true,
                                        gitsigns = true,
                                        nvimtree = true,
                                        treesitter = true,
                                        notify = false,
                                        mini = {
                                                enabled = true,
                                                indentscope_color = "",
                                        },
                                },
                                vim.cmd.colorscheme('catppuccin-mocha')
                        })
                end,
        },
}

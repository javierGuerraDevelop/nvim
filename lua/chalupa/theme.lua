return {
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = true,
				},
			})
		end,
	},
	{
		"itsfernn/auto-gnome-theme.nvim",
		lazy = false,
		priority = 999,
		dependencies = { "projekt0n/github-nvim-theme" },
		config = function()
			require("auto-gnome-theme").setup({
				dark_theme = "github_dark_colorblind",
				light_theme = "github_light_colorblind",
			})
		end,
	},
}

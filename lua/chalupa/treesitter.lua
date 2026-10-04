return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			vim.filetype.add({
				extension = {
					sh = "bash",
					zsh = "bash",
				},
				pattern = {
					[".*/%.sh"] = "bash",
					[".*/%.zsh"] = "bash",
					[".*zshrc.*"] = "bash",
				},
			})

			local parsers = {
				"lua",
				"python",
				"rust",
				"tsx",
				"typescript",
				"javascript",
				"vimdoc",
				"vim",
				"bash",
				"html",
				"css",
				"sql",
				"cpp",
			}

			require("nvim-treesitter").setup()
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
	},
}

return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	init = function()
		vim.g.rustaceanvim = {
			server = {
				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						checkOnSave = {
							enable = true,
							command = "clippy",
						},
						procMacro = {
							enable = true,
						},
						inlayHints = {
							typeHints = {
								enable = true,
								hideClosureInitialization = true,
								hideNamedConstructor = true,
							},
							parameterHints = { enable = true },
							chainingHints = { enable = true },
						},
					},
				},
			},
		}
	end,
}

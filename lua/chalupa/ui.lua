print("welcome chalupa") -- Welcome message
local github_orange = "#ec8e2c"
vim.api.nvim_set_hl(0, "LineNr", { fg = github_orange }) -- Regular line numbers
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = github_orange }) -- Current line number
vim.opt.colorcolumn = "120"
vim.api.nvim_set_hl(0, "ColorColumn", { bg = github_orange })
vim.wo.relativenumber = true -- Relative line numbers at the left
vim.opt.termguicolors = true -- Nicer colors
vim.opt.tabstop = 4 -- Tab width is 4 spaces
vim.opt.softtabstop = 4 -- Tab width is 4 spaces
vim.opt.shiftwidth = 4 -- Indent amount width > in visual mode
vim.opt.expandtab = true -- Spaces instead of tabs
vim.g.codeium_enabled = false -- codeium disabled
vim.g.codeium_disable_bindings = 1 -- codeium bindings disabled
vim.o.hlsearch = false -- Set highlight on search
vim.wo.number = true -- Make line numbers default
vim.o.mouse = "a" -- Enable mouse mode
vim.o.clipboard = "unnamedplus" -- Sync System clipboard with Neovim.
vim.cmd("au BufNewFile,BufRead *.handlebars set filetype=html")
vim.o.breakindent = true -- Enable break indent

vim.api.nvim_set_hl(0, "CursorNormal", { bg = "#FF0000", fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#00FF00", fg = "#000000" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#04c963" }) -- Green color for inlay hints
vim.opt.guicursor = "n-v-c:block-CursorNormal,i-ci-ve:block-CursorInsert"

local type_highlight_groups = {
	"Type",
	"@type",
	"@type.builtin",
	"@type.definition",
	"@lsp.type.type",
	"@lsp.type.class",
	"@lsp.type.struct",
	"@lsp.type.interface",
	"@lsp.type.enum",
	"@lsp.type.typeParameter",
}

local function is_type_highlight(group)
	if group == "@type" or (group:match("^@type%.") and not group:match("^@type%.qualifier")) then
		return true
	end

	for _, type_group in ipairs(type_highlight_groups) do
		if group == type_group then
			return true
		end

		if type_group:match("^@lsp%.") and vim.startswith(group, type_group .. ".") then
			return true
		end
	end

	return false
end

local function bold_type_highlights()
	local groups = {}

	for _, group in ipairs(type_highlight_groups) do
		groups[group] = true
	end

	for group in pairs(vim.api.nvim_get_hl(0, {})) do
		if is_type_highlight(group) then
			groups[group] = true
		end
	end

	for group in pairs(groups) do
		local highlight = vim.api.nvim_get_hl(0, { name = group, link = false })
		highlight.bold = true
		vim.api.nvim_set_hl(0, group, highlight)
	end
end

local type_highlight_augroup = vim.api.nvim_create_augroup("ChalupaTypeHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = type_highlight_augroup,
	callback = bold_type_highlights,
})
bold_type_highlights()

vim.opt.cindent = false
vim.opt.smartindent = false
vim.opt.autoindent = true

vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case-insensitive searching
vim.o.smartcase = true -- Case sensitive searching if capital is included only
vim.wo.signcolumn = "yes" -- Keep signcolumn on by default
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- Time out for command sequences
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight on yank
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})

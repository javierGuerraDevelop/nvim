-- Transparency in case it is not supported by my theme
vim.cmd('au ColorScheme * hi Normal guibg=NONE')     -- transparency
vim.cmd('au ColorScheme * hi SignColumn guibg=NONE') -- transparency

require('github-theme').setup({
  terminal_colors = true,
})
vim.cmd('colorscheme github_dark')

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'bash', 'html',
    'css', 'sql' },
  sync_install = false,
  ignore_install = {},
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  modules = {}
}

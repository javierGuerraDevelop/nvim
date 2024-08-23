require("catppuccin").setup({
  flavour = "mocha", -- You can choose 'latte', 'frappe', 'macchiato', 'mocha'
  no_italic = true,
  transparent_background = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = ""
    }
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
  color_overrides = {
    mocha = {
      base = "#0F0F0F", -- Background color
    }
  }
})
vim.cmd("colorscheme catppuccin")

require('chalupa.remaps')
require('chalupa.ui')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim' -- Package Manager
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
    lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('chalupa.theme')
    end,
  },
  { -- LSP
    'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' },
  {
    'neovim/nvim-lspconfig',
    dependencies = { {
      'williamboman/mason.nvim',
      config = true
    }, 'williamboman/mason-lspconfig.nvim', {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      opts = {}
    }, 'folke/neodev.nvim' }
  },
  { -- Treesitter, used for syntax highlighting
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate'
  },
  { -- Formatting
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('null-ls').setup({
        sources = { require('null-ls').builtins.formatting.black.with({
          extra_args = { '--line-length', '140' }
        }),
          require('null-ls').builtins.formatting.prettier.with({}) }
      })
    end
  },
  { -- Autoclose chars like brackets or parentheses
    'm4xshen/autoclose.nvim'
  },
  { -- File Navigation
    'ThePrimeagen/harpoon'
  },
  { -- Tailwind classes sorter
    'laytan/tailwind-sorter.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    build = 'cd formatter && npm ci && npm run build',
    config = true
  },
  { -- Gitsigns
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' }
      },
    }
  },
  { -- Status bar at the bottom made pretty
    'nvim-lualine/lualine.nvim',
    config = function()
      require('chalupa.lualine')
    end
  },
  { -- Comment lines out
    'numToStr/Comment.nvim',
    opts = {}
  },
  { -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end
    } },
    config = function()
      require('chalupa.telescope')
    end
  }, 'mustache/vim-mustache-handlebars',
  {   -- Theme
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('chalupa.theme')
    end
  },
  {   -- LSP
    'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' },
  {
    'neovim/nvim-lspconfig',
    dependencies = { {
      'williamboman/mason.nvim',
      config = true
    }, 'williamboman/mason-lspconfig.nvim', {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      opts = {}
    }, 'folke/neodev.nvim' }
  },
  {   -- Treesitter, used for syntax highlighting
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate'
  },
  {   -- Formatting
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('null-ls').setup({
        sources = { require('null-ls').builtins.formatting.black.with({
          extra_args = { '--line-length', '140' }
        }),
          require('null-ls').builtins.formatting.prettier.with({}) }
      })
    end
  },
  {   -- Autoclose chars like brackets or parentheses
    'm4xshen/autoclose.nvim'
  },
  {   -- File Navigation
    'ThePrimeagen/harpoon'
  },
  {   -- Tailwind classes sorter
    'laytan/tailwind-sorter.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    build = 'cd formatter && npm ci && npm run build',
    config = true
  },
  {   -- Gitsigns
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' }
      },
    }
  },
  {   -- Status bar at the bottom made pretty
    'nvim-lualine/lualine.nvim',
    config = function()
      require("chalupa.lualine")
    end
  },
  {   -- Comment lines out
    'numToStr/Comment.nvim',
    opts = {}
  },
  {   -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end
    } },
    config = function()
      require('chalupa.telescope')
    end
  }, 'mustache/vim-mustache-handlebars',
}, {})

-- Setups
require('neodev').setup()
require('autoclose').setup()
require('chalupa.treesitter')
require('chalupa.mason')
require('chalupa.autocomplete')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    require('chalupa.theme'),
    require('chalupa.telescope'),
    require('chalupa.treesitter'),
    require('chalupa.lualine'),
    require('chalupa.mason'),
    require('chalupa.autocomplete'),
    require('chalupa.gitsigns'),
    require('chalupa.autoclose'),
    require('chalupa.harpoon'),
    require('chalupa.tailwind'),
    require('chalupa.null-ls'),
    require('chalupa.comment'),
}

require('lazy').setup(plugins)

-- Require other configurations
require('chalupa.ui')
require('chalupa.remaps')

-- Additional setups
require('neodev').setup()


local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
        lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Combine all plugin specifications
local plugins = {}
for _, module in ipairs({
    'theme',
    'telescope',
    'treesitter',
    'lualine',
    'mason',
    'autocomplete',
    'gitsigns',
    'autoclose',
    'harpoon',
    'tailwind',
    'null-ls',
    'comment',
}) do
    local success, module_plugins = pcall(require, 'chalupa.' .. module)
    if success then
        for _, plugin in ipairs(module_plugins) do
            table.insert(plugins, plugin)
        end
    end
end

require('lazy').setup(plugins)

-- Setups
require('neodev').setup()
require('autoclose').setup()

require('chalupa.treesitter')
require('chalupa.mason')
require('chalupa.autocomplete')
require('chalupa.ui')
require('chalupa.remaps')

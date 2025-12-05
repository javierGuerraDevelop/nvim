vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Diagnostic keybinds
vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, { desc = 'Open diagnostic location list' })
vim.keymap.set('n', '<leader>eg', vim.diagnostic.setqflist, { desc = 'Open diagnostic quickfix list' })
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)                                -- netrw
vim.keymap.set('n', '<leader>rj', ':term node %:h:h/dist/%:t:r.js<CR>a')    -- run javascript
vim.keymap.set('n', '<leader>rt', ':term tsc <CR>a')                        -- run typescript
vim.keymap.set('n', '<leader>rp', ':!python %<CR>')                         -- run python
vim.keymap.set('n', '<leader>rh', ':!xdg-open %<CR>')                       -- run html
vim.keymap.set('i', '<C-Del>', '<C-O>dw')                                   -- erase it from the back
vim.keymap.set('n', '<C-d>', '<C-d>zz')                                     -- jump down and center
vim.keymap.set('n', '<C-u>', '<C-u>zz')                                     -- jump down and center
vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- code action
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")                                -- move lines in visual up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")                                -- move lines in visual up
vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({
        async = true
    })
end) -- format
vim.keymap.set('n', '<leader>vs', vim.cmd.vsp, {
    silent = true
}) -- split vertically
vim.keymap.set('n', '<leader>hs', vim.cmd.sp, {
    silent = true
})                                                                                          -- split horizontally
vim.keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>") -- open harpoon menu
vim.keymap.set("n", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")         -- file 1
vim.keymap.set("n", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")         -- file 2
vim.keymap.set("n", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")         -- file 3
vim.keymap.set("n", "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")         -- file 4
vim.keymap.set("n", "<leader>h5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>")         -- file 5
vim.keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>")         -- add file to harpoon
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', {
    silent = true
}) -- Keymaps for better default experience
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
    expr = true,
    silent = true
}) -- Remap for dealing with word wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
    expr = true,
    silent = true
}) -- Remap for dealing with word wrap
vim.keymap.set('n', '<leader>9', vim.diagnostic.goto_prev, {
    desc = 'Go to previous diagnostic message'
})
vim.keymap.set('n', '<leader>0', vim.diagnostic.goto_next, {
    desc = 'Go to next diagnostic message'
})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
    desc = 'Open diagnostics list'
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })

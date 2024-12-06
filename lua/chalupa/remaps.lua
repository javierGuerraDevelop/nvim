vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)                             -- netrw
vim.keymap.set('n', '<leader>rj', ':term node %:h:h/dist/%:t:r.js<CR>a') -- run javascript
vim.keymap.set('n', '<leader>rt', ':term tsc <CR>a')                     -- run typescript
vim.keymap.set('n', '<leader>rp', ':!python %<CR>')                      -- run python
vim.keymap.set('n', '<leader>rh', ':!xdg-open %<CR>')                    -- run html
vim.keymap.set('i', '<C-Del>', '<C-O>dw')                                -- erase it from the back
vim.keymap.set('t', '<leader>t', '<C-\\><C-n>:b#<CR>')                   -- get out of terminal mode
vim.keymap.set('n', '<leader>t', ':terminal<CR>a')                       -- enter terminal mode
vim.keymap.set('n', '<leader>ft', ':TailwindSort')                       -- enter terminal mode
vim.keymap.set('n', '<C-d>', '<C-d>zz')                                  -- jump down and center
vim.keymap.set('n', '<C-u>', '<C-u>zz')                                  -- jump down and center
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")                             -- move lines in visual up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")                             -- move lines in visual up
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
vim.keymap.set("n", "<A-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")              -- file 1
vim.keymap.set("n", "<A-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")              -- file 2
vim.keymap.set("n", "<A-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")              -- file 3
vim.keymap.set("n", "<A-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")              -- file 4
vim.keymap.set("n", "<A-5>", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>")              -- file 5
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

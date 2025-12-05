return {
    {
        'ThePrimeagen/harpoon',
        config = function()
            vim.keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
            vim.keymap.set("n", "<A-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")
            vim.keymap.set("n", "<A-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")
            vim.keymap.set("n", "<A-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")
            vim.keymap.set("n", "<A-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")
            vim.keymap.set("n", "<A-5>", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>")
        end
    }
}

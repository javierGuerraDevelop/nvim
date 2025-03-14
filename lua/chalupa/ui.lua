print("welcome chalupa")                      -- Welcome message
vim.opt.guicursor = ''                        -- Block Cursor
vim.wo.relativenumber = true                  -- Relative line numbers at the left
vim.opt.termguicolors = true                  -- Nicer colors
vim.opt.tabstop = 4                           -- Tab width is 4 spaces
vim.opt.softtabstop = 4                       -- Tab width is 4 spaces
vim.opt.shiftwidth = 4                        -- Indent amount width > in visual mode
vim.opt.expandtab = true                      -- Spaces instead of tabs
vim.g.codeium_enabled = false                 -- codeium disabled
vim.g.codeium_disable_bindings = 1            -- codeium bindings disabled
vim.o.hlsearch = false                        -- Set highlight on search
vim.wo.number = true                          -- Make line numbers default
vim.o.mouse = 'a'                             -- Enable mouse mode
vim.o.clipboard = 'unnamedplus'               -- Sync System clipboard with Neovim.
vim.o.breakindent = true                      -- Enable break indent
vim.o.undofile = true                         -- Save undo history
vim.o.ignorecase = true                       -- Case-insensitive searching
vim.o.smartcase = true                        -- Case sensitive searching if capital is included only
vim.wo.signcolumn = 'yes'                     -- Keep signcolumn on by default
vim.o.updatetime = 250                        -- Decrease update time
vim.o.timeoutlen = 300                        -- Time out for command sequences
vim.o.completeopt = 'menuone,noselect'        -- Set completeopt to have a better completion experience
vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight on yank
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 }
    end,
})

local remember_folds = vim.api.nvim_create_augroup("remember_folds", { clear = true })

-- Save folds when leaving a buffer, but only if the buffer has a file name
vim.api.nvim_create_autocmd("BufWinLeave", {
    group = remember_folds,
    pattern = "*",
    callback = function()
        local filepath = vim.fn.expand("%:p")
        if filepath ~= "" then
            -- Create the directory for the view file if it doesn't exist
            local viewdir = vim.fn.stdpath("data") .. "/views"
            vim.fn.mkdir(viewdir, "p")
            vim.cmd("mkview! " .. viewdir .. "/" .. vim.fn.fnamemodify(filepath, ":t:r") .. ".vim")
        end
    end,
})

-- Load folds when entering a buffer, but only if the buffer has a file name
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = remember_folds,
    pattern = "*",
    callback = function()
        local filepath = vim.fn.expand("%:p")
        if filepath ~= "" then
            local viewdir = vim.fn.stdpath("data") .. "/views"
            vim.cmd("silent! loadview " .. viewdir .. "/" .. vim.fn.fnamemodify(filepath, ":t:r") .. ".vim")
        end
    end,
})

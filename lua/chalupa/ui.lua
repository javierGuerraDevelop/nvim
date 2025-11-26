print("welcome chalupa")                                   -- Welcome message
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#FF69B4' })       -- Regular line numbers
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FF69B4' }) -- Current line number
vim.opt.colorcolumn = "120"
vim.wo.relativenumber = true                               -- Relative line numbers at the left
vim.opt.termguicolors = true                               -- Nicer colors
vim.opt.tabstop = 8                                        -- Tab width is 8 spaces
vim.opt.softtabstop = 8                                    -- Tab width is 8 spaces
vim.opt.shiftwidth = 8                                     -- Indent amount width > in visual mode
vim.opt.expandtab = true                                   -- Spaces instead of tabs
vim.g.codeium_enabled = false                              -- codeium disabled
vim.g.codeium_disable_bindings = 1                         -- codeium bindings disabled
vim.o.hlsearch = false                                     -- Set highlight on search
vim.wo.number = true                                       -- Make line numbers default
vim.o.mouse = 'a'                                          -- Enable mouse mode
vim.o.clipboard = 'unnamedplus'                            -- Sync System clipboard with Neovim.
vim.cmd('au BufNewFile,BufRead *.handlebars set filetype=html')
vim.o.breakindent = true                                   -- Enable break indent

vim.opt.cindent = false
vim.opt.smartindent = false
vim.opt.autoindent = true

vim.o.undofile = true                         -- Save undo history
vim.o.ignorecase = true                       -- Case-insensitive searching
vim.o.smartcase = true                        -- Case sensitive searching if capital is included only
vim.wo.signcolumn = 'yes'                     -- Keep signcolumn on by default
vim.o.updatetime = 250                        -- Decrease update time
vim.o.timeoutlen = 300                        -- Time out for command sequences
vim.o.completeopt = 'menuone,noselect'        -- Set completeopt to have a better completion experience
vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight on yank
        callback = function()
                vim.hl.on_yank { higroup = 'IncSearch', timeout = 300 }
        end,
})

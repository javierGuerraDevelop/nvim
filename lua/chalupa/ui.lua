print("welcome chalupa")                      -- Welcome message
vim.wo.relativenumber = true                  -- Relative line numbers at the left
vim.opt.termguicolors = true                  -- Nicer colors
vim.opt.tabstop = 2                           -- Tab width is 4 spaces
vim.opt.softtabstop = 2                       -- Tab width is 4 spaces
vim.opt.shiftwidth = 2                        -- Indent amount width > in visual mode
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

-- I have this off because I control transparency through my theme since it has that opt. Not all themes
-- have an opt for transparency so I keep it here in case I switch themes
-- vim.cmd('au ColorScheme * hi Normal guibg=NONE') -- transparency
-- vim.cmd('au ColorScheme * hi SignColumn guibg=NONE') -- transparency


-- Create an augroup for managing folds
local remember_folds = vim.api.nvim_create_augroup("remember_folds", { clear = true })

-- Save folds when leaving a buffer, but only if the buffer has a file name
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = remember_folds,
  pattern = "*",
  callback = function()
    if vim.fn.expand("%:p") ~= "" then
      vim.cmd("mkview")
    end
  end,
})

-- Load folds when entering a buffer, but only if the buffer has a file name
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = remember_folds,
  pattern = "*",
  callback = function()
    if vim.fn.expand("%:p") ~= "" then
      vim.cmd("silent! loadview")
    end
  end,
})

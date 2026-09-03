-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.number = true             -- Print line number
opt.relativenumber = true     -- Relative line number

opt.tabstop = 4               -- Number of spaces tabs count for
opt.softtabstop = 4
opt.shiftwidth = 4            -- Size of an indent
opt.expandtab = true          -- Use spaces instead of tabs
opt.smartindent = true        -- Insert indents automatically

opt.shiftround = true         -- Round indent
opt.autowrite = true          -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.confirm = false           -- Confirm to save changes before exiting modified buffer
opt.ignorecase = true         -- Ignore case
opt.inccommand = "nosplit"    -- preview incremental substitute
opt.mouse = "a"               -- Enable mouse mode
opt.scrolloff = 4             -- Lines of context
opt.smartcase = true          -- Don't ignore case with capitals
opt.signcolumn = "yes"        -- Always show the signcolumn, otherwise it would shift the text each time
opt.spelllang = { "en" }
opt.splitbelow = true         -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true         -- Put new windows right of current
opt.termguicolors = true      -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wrap = false     -- Disable line wrap
opt.swapfile = false
opt.winborder = 'rounded'
opt.cursorline = true

opt.fillchars = {
    foldopen = "",
    foldclose = "",
    -- fold = "⸱",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

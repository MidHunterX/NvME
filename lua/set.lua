--=========================== [ @GENERAL_OPTIONS ] ===========================--

vim.opt.list = true
vim.opt.listchars = { space = '⋅', tab = '<->' }
-- vim.opt.listchars = { space = '⋅', tab = '> ', eol = '↩', trail = '$' }

vim.opt.nu = true
vim.opt.relativenumber = true

-- Set Title for context
vim.opt.title = true

-- Convert Tabs to Whitespace
vim.opt.expandtab = true
-- Max-Width for Visualizing Tabs
vim.opt.tabstop = 8
-- Max-Width for Space/Tab input while Editing
vim.opt.softtabstop = 2
-- Automatic Indentation Width via >>
vim.opt.shiftwidth = 2

-- Save undo history
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 500

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.smartindent = true

vim.opt.termguicolors = true -- True Color support
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Better completion experience
vim.o.completeopt = 'menuone,noselect'

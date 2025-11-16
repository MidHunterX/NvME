--=========================== [ @GENERAL_OPTIONS ] ===========================--

vim.opt.list = true
-- vim.opt.listchars = { space = '⋅', tab = '> ', tab = '<->', eol = '↩', trail = '$' }
vim.opt.listchars = { space = '⋅', tab = '|⋅' }
-- Replace tildes at the end of the buffer
vim.opt.fillchars = { eob = " " }

-- "bold": Bold line box.
-- "double": Double-line box.
-- "none": No border.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "shadow": Drop shadow effect, by blending with the background.
-- "single": Single-line box.
-- "solid": Adds padding by a single whitespace cell.
vim.opt.winborder = "rounded"

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = true
-- Auto reload when a file is changed
vim.opt.autoread = true

-- Set Title for context
vim.opt.title = true

-- Convert Tabs to Whitespace
vim.opt.expandtab = true
-- Number of spaces that a <Tab> in the file counts for.
-- Also see the |:retab| command, and the 'softtabstop' option.
-- Note: Set 'tabstop' to 8
vim.opt.tabstop = 4
-- Number of spaces that a <Tab> counts for while performing editing operations
-- like inserting a <Tab> or using <BS>.
-- It "feels" like <Tab>s are being inserted.
vim.opt.softtabstop = 4
-- Number of spaces to use for each step of (auto)indent.
-- Used for |'cindent'|, |>>|, |<<|, etc.
vim.opt.shiftwidth = 4
-- Why tabs are 8 by default?
-- https://en.wikipedia.org/wiki/Tab_key#Tab_characters

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
vim.opt.signcolumn = "yes" -- For GitSigns, LSP Errors
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"

-- Better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Spellcheck
vim.opt.spelllang = { 'en_us', 'en_gb' }
vim.opt.spelloptions = { "camel" }

--============================ [ @VIM_FOLDING ] ============================--
-- vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
-- vim.o.foldcolumn = '1' -- WARN: Suspected Interference with Snacks Column causing Crashes
vim.o.foldenable = true
vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'


--===========================[ @AUTO_SHIFT_WIDTH ]===========================--

local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local general = augroup("General Settings", { clear = true })

autocmd("FileType", {
  pattern = { "c", "cpp", "py", "java", "cs" },
  callback = function()
    vim.bo.shiftwidth = 4
  end,
  group = general,
  desc = "Set shiftwidth to 4 in these filetypes",
})

--===========================[ @GENERAL_COMMANDS ]===========================--
-- Use system clipboard
vim.cmd(":set clipboard=unnamedplus")

-- Highlighted Yank
vim.cmd([[
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
]])

-- Scroll past last line
vim.cmd([[nnoremap <expr> j line(".") == line('$') ? '<C-e>':'j']])

-- Automatically change number based on Insert Mode
vim.cmd([[autocmd InsertEnter * :set norelativenumber]])
vim.cmd([[autocmd InsertLeave * :set relativenumber]])

-- Yank into system clipboard "+"
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])



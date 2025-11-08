-- Disable 80 Char column on HTML because HTML tends to get really W-I-D-E
vim.opt_local.colorcolumn = "0"

-- https://developers.google.com/style/html-formatting
-- Don't use tabs to indent text; use spaces only. Different text editors interpret tabs differently, and some Markdown features expect spaces and not tabs.
vim.bo.expandtab = true
-- Indent by two spaces per indentation level.
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

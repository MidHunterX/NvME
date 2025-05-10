-- Nvim doesn't set indentation length for c files as there is no standard
-- Linus Torvalds uses 8 spaces but I think it's a bit too much
-- There is no need for 2 spaces as C code usually doesn't get that wide generally
-- So, I prefer 4 spaces for indentation which is the middle ground

vim.bo.expandtab = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

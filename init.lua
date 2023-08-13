--
--                 ┳┳┓• ┓  ┓┏           ┏┓┏┓  ┏┓    ┏•
--                 ┃┃┃┓┏┫  ┣┫┓┏┏┓╋┏┓┏┓   ┃┃   ┃ ┏┓┏┓╋┓┏┓
--                 ┛ ┗┗┗┻  ┛┗┗┻┛┗┗┗ ┛   ┗┛┗┛  ┗┛┗┛┛┗┛┗┗┫
--                                                     ┛
-------------------------------------------------------------------------------
require("set")
require("remap")
require("custom_functions")
require("auto_commands")


-- Transparent Background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- Set the selection background color
vim.api.nvim_set_hl(0, "Visual", { bg = "#37444f" })
-- Colour Line Number
vim.api.nvim_set_hl(0, "LineNr", { bg = 'none', fg = "#889299" })
-- Replace tildes at the end of the buffer
vim.opt.fillchars = { eob = " " }

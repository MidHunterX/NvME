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

--==========================[ @LAZY.NVIM_BOOTSTRAP]==========================--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local opts = {}

require("lazy").setup("plugins", opts)


--=======================[ @AFTER LAZY LOAD SETTINGS ]=======================--

-- Transparent Background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- Set the selection background color
-- vim.api.nvim_set_hl(0, "Visual", { bg = "#37444f" })
-- Colour Line Number
vim.api.nvim_set_hl(0, "LineNr", { bg = 'none', fg = "#889299" })
-- Replace tildes at the end of the buffer
vim.opt.fillchars = { eob = " " }

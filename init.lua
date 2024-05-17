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
require("hit_font")

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


local opts = {
  ui = {
    size = { width = 0.8, height = 0.8 },
    border = "rounded",
    backdrop = 100,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      ---@type string[]
      paths = {}, -- custom paths to includes in the rtp
      disabled_plugins = {
        "gzip", -- Allows Neovim to read and write gzip compressed files.
        "matchit", -- Enhances the `%` command to jump between {[()]}
        -- "matchparen", -- Highlights matching {[()]}
        "netrwPlugin", -- File explorer (:Sex, :Vex, :Ex).
        "tarPlugin", -- Adds support for handling tar archives.
        "tohtml", -- Converts a buffer or a part of a buffer to HTML format.
        "tutor", -- Interactive tutorial for learning basic Neovim commands.
        "zipPlugin", -- Adds support for handling zip archives.
      },
    },
  },
}

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

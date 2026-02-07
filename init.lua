-- ╭───────────────────────────────────────────────────────────────────────╮ --
-- │                          █▄░█ █░█  █▀▄▀█ █▀▀                          │ --
-- │                          █░▀█ ▀▄▀  █░▀░█ ██▄                          │ --
-- ╰───────────────────────────────────────────────────────────────────────╯ --

require("set")
require("remap")
require("custom_functions")
require("auto_commands")
require("hit_font")
require("cmp_gitcommit")

require("killswitch") -- for conditionally disabling plugins

--==========================[ @LAZY.NVIM_BOOTSTRAP]==========================--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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
        "gzip",   -- Allows Neovim to read and write gzip compressed files.
        -- "matchit", -- Enhances the `%` command to jump between {[()]}
        -- "matchparen", -- Highlights matching {[()]}
        "netrwPlugin", -- File explorer (:Sex, :Vex, :Ex).
        "tarPlugin",   -- Adds support for handling tar archives.
        "tohtml",      -- Converts a buffer or a part of a buffer to HTML format.
        "tutor",       -- Interactive tutorial for learning basic Neovim commands.
        "zipPlugin",   -- Adds support for handling zip archives.
      },
    },
  },
}

require("lazy").setup("plugins", opts)


--=======================[ @AFTER LAZY LOAD SETTINGS ]=======================--

function Load_dynamic_colors()
  -- Clear cache
  package.loaded['lualine.themes.catppuccin'] = nil

  local customcat = require 'lualine.themes.catppuccin'
  -- Problem: Ugly white separators due to lualine transparency handling bug. Source: lua/catppuccin/utils/lualine.lua > catppuccin.inactive.a.bg = 'NONE'
  customcat.inactive.a.bg = '#242428'
  -- Transparent background for center
  customcat.normal.c.bg = 'NONE'

  local ok, colors = pcall(require, 'colors/colors')
  if ok and colors.primary then
    package.loaded['colors/colors'] = nil
    customcat.normal.a.bg = colors.primary
    --
    customcat.normal.b.fg = colors.secondary
    customcat.normal.b.bg = colors.on_secondary
    --
    customcat.inactive.a.fg = colors.secondary

    -- NVIM UI
    -- Colour Line Number
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.primary, bold = true, nocombine = true })
  end

  require 'lualine'.setup { options = { theme = customcat } }
end

Load_dynamic_colors()

-- HOT RELOAD ON SIGUSR1
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    vim.schedule(function()
      Load_dynamic_colors()
    end)
  end
})

-- Transparent Background
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- Set the selection background color
-- vim.api.nvim_set_hl(0, "Visual", { bg = "#37444f" })
-- Colour Line Number
-- vim.api.nvim_set_hl(0, "LineNr", { bg = 'none', fg = "#889299" })

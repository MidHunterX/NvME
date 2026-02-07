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

    -- █░░ █░█ ▄▀█ █░░ █ █▄░█ █▀▀   █░█ █ --
    -- █▄▄ █▄█ █▀█ █▄▄ █ █░▀█ ██▄   █▄█ █ --
    -- ================================== --
    customcat.normal.a.bg = colors.primary
    customcat.normal.b.fg = colors.secondary
    customcat.normal.b.bg = colors.on_secondary
    customcat.inactive.a.fg = colors.secondary


    -- █▄░█ █▀▀ █▀█ █░█ █ █▀▄▀█   █░█ █ --
    -- █░▀█ ██▄ █▄█ ▀▄▀ █ █░▀░█   █▄█ █ --
    -- ================================ --

    -- Colour Line
    vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.on_secondary })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.primary, bold = true })
    vim.api.nvim_set_hl(0, "LineNr", { fg = colors.on_surface_variant })

    -- Floating Window + Sidebar
    local LITE_FLOAT, DARK_FLOAT = colors.secondary, colors.surface_container_high
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = DARK_FLOAT })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = LITE_FLOAT, bg = DARK_FLOAT, nocombine = true })
    vim.api.nvim_set_hl(0, "FloatTitle", { fg = LITE_FLOAT, bg = DARK_FLOAT })

    -- Completion Popup Menu
    local LITE_CMP, DARK_CMP = colors.secondary, colors.surface_container
    vim.api.nvim_set_hl(0, "Pmenu", { fg = LITE_CMP, bg = DARK_CMP })
    vim.api.nvim_set_hl(0, "PmenuBorder", { fg = LITE_CMP, bg = DARK_CMP })
    vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.on_primary, bg = colors.primary, bold = true })

    -- Treesitter
    local DARK_TS = colors.on_secondary
    vim.api.nvim_set_hl(0, "TreesitterContext", { bg = DARK_TS })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = DARK_TS })
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

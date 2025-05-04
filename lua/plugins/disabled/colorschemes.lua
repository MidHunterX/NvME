return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  config = function()
    local presets = require("markview.presets");
    require("markview").setup({
      preview = {
        icon_provider = "devicons", -- "devicons | "internal" | "mini"
        enable_hybrid_mode = true,
        linewise_hybrid_mode = true,
      },
      markdown = {
        headings = presets.headings.glow,
        tables = presets.tables.rounded,
        horizontal_rules = presets.horizontal_rules.arrowed,
      },
    })
  end,

  -- markview loads after colorscheme dependencies
  dependencies = {
    "catppuccin/nvim",
    priority = 1000,

    opts = {
      transparent_background = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        dashboard = true,
        gitsigns = true,
        leap = true,
        mason = true,
        notify = true,
        treesitter = true,
        noice = true,
        nvim_surround = true,
        snacks = {
          enabled = true,
        },
        which_key = false,
      },
    },

    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-frappe")
    end,

  },
};

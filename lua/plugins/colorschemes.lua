return {
  {
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
}

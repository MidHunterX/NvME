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
        render_markdown = true,
        snacks = {
          enabled = true,
        },
        which_key = false,
      },
      custom_highlights = function(colors)
        return {
          -- groups/editor.lua
          CurSearch = { bg = colors.maroon, fg = colors.mantle },
          LineNr = { fg = colors.overlay1 },
          Visual = { bg = colors.surface2, style = { "bold" } },
        }
      end,
      color_overrides = {
        mocha = {
          -- base color of: Current Line, render-markdown Heading etc.
          base = "#3a3c46",
          -- bg of: render-markdown Code Block
          mantle = "#31343f",
        },
      },
    },

    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,

  },

  --[[ {
    -- OneDark with Catppuccin colors
    -- OneDark is so good at color consistency when it comes to syntax highlighting
    -- Catppuccin has nice bright colors
    -- navarasu/onedark.nvim doesn't work well with render-markdown.nvim though
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'dark',
        transparent = false,
        cmp_itemkind_reverse = false,
        colors = {
          fg = "#cdd6f4",
          light_gray = "#bac2de",
          gray = "#a6adc8",
          red = "#f38ba8",
          cyan = "#94e2d5",
          yellow = "#f9e2af",
          orange = "#fab387",
          green = "#a6e3a1",
          blue = "#89b4fa",
          purple = "#cba6f7",
        }
      }
      require('onedark').load()
    end
  }, ]]

}

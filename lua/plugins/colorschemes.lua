-- Catppuccin Colors with OneDark Syntax highlighting
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
        noice = true,
        notify = true,
        treesitter_context = true,
        treesitter = true,
        nvim_surround = true,
        render_markdown = true,
        snacks = {
          enabled = true,
        },
        which_key = false,
      },
      custom_highlights = function(colors)
        -- OneDark to Catppuccin Color Adapter
        local catppuccin_onedark_adapter = {
          -- onedark.palette
          black = colors.crust,
          bg0 = colors.mantle,
          bg1 = colors.base,
          bg2 = colors.surface0,
          bg3 = colors.surface1,
          bg_d = colors.base,
          bg_blue = colors.blue,
          bg_yellow = colors.yellow,
          fg = colors.text,
          purple = colors.mauve,
          green = colors.green,
          orange = colors.peach,
          blue = colors.blue,
          yellow = colors.yellow,
          cyan = colors.sky,
          red = colors.red,
          grey = colors.overlay2,
          light_grey = colors.subtext1,
          diff_add = colors.green,
          diff_delete = colors.red,
          diff_change = colors.yellow,
          diff_text = colors.blue,
        }

        local c = catppuccin_onedark_adapter

        return {
          -- groups/editor.lua
          -- Thoughts: Some tweaks to make Catppuccin more readable
          CurSearch = { bg = colors.maroon, fg = colors.mantle },
          LineNr = { fg = colors.overlay1 },
          Visual = { bg = colors.surface2, style = { "bold" } },
          -- CUSTOM HIGHLIGHTING
          ["@variable"] = { fg = colors.text },          -- variable = 3
          ["@variable.member"] = { fg = colors.red },    -- obj.member
          ["@variable.parameter"] = { fg = colors.red }, -- function(parameter)
          ["@string"] = { fg = colors.green },           -- "string"
          ["@string.regexp"] = { fg = colors.pink },     -- ".*regex"
          ["@string.escape"] = { fg = colors.red },      -- "\n \r"
          ["@string.special.symbol"] = { fg = colors.teal },

          Class = { fg = colors.yellow },
          -- self, this, super
          ["@variable.builtin"] = { fg = colors.yellow },
          -- eg. int, char
          ["@type.builtin"] = { fg = colors.yellow },
          -- from module import package
          Package = { fg = colors.yellow },
          -- import module
          ["@module"] = { fg = colors.yellow },
        }
      end,
      color_overrides = {
        mocha = {
          -- base color of: Current Line, render-markdown Heading etc.
          base = "#37383e",
          -- bg of: render-markdown Code Block
          mantle = "#242428",
          crust = "#181825",
        },
      },
    },

    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,

  },

  --[[ {
    -- OneDark with Catppuccin colors
    -- OneDark is so good at color consistency when it comes to syntax highlighting
    -- Catppuccin has nice bright colors
    -- navarasu/onedark.nvim doesn't work well with render-markdown.nvim
    -- and other plugins but catppuccin does.
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'dark',
        transparent = true,
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

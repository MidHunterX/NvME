return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "helix",
    -- TODO: Workaround till https://github.com/folke/which-key.nvim/issues/967
    show_help = false,

    ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
    delay = function(ctx)
      return ctx.plugin and 0 or 1000
    end,

    icons = {
      rules = {
        { pattern = "wtf", icon = "󰚩", color = "red" },
        { plugin = "treesj", icon = "󰃻 ", color = "blue" },
        { pattern = "fold", icon = "", color = "yellow" },
      }
    },

    plugins = {
      marks = true,           -- shows your marks on ' and `
      registers = true,       -- shows your registers on "
      spelling = {
        enabled = true,       -- pressing z= to select spelling suggestions
        suggestions = 20,
      },
      presets = {
        operators = true,     -- operators like d, y, ...
        motions = true,       -- motions
        text_objects = true,  -- text objects after entering an operator
        windows = true,       -- default bindings on <c-w>
        nav = true,           -- misc bindings to work with windows
        z = true,             -- folds, spelling prefixed with z
        g = true,             -- prefixed with g
      },
    },

  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Which Key: Local Buffer Keymaps",
    },
  },
}

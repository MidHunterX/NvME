return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "helix",

    ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
    delay = function(ctx)
      return ctx.plugin and 0 or 1000
    end,

    plugins = {
      marks = true,           -- shows your marks on ' and `
      registers = true,       -- shows your registers on "
      spelling = {
        enabled = false,      -- pressing z= to select spelling suggestions
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
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

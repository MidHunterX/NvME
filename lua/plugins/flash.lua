-- Wayyyy better than leap.
-- Not restricted to number of letters.
-- Even works with one letter and filter out jumps using many letters
-- Multi directional as it should be.

return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function() require("flash").jump() end,
        desc = "Flash: Jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function() require("flash").treesitter() end,
        desc = "Flash: Treesitter Select",
      },

      -- o (Operator-pending mode): d, y, or c
      -- Example: y { r <jump> } i w
      {
        "r",
        mode = "o",
        function() require("flash").remote() end,
        desc = "Flash: Remote Mode",
      },

      -- x (Visual mode - exclusive selection)
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Flash: Treesitter Search",
      },
    },
  },
}

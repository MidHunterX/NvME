-- Wayyyy better than leap.
-- Not restricted to number of letters.
-- Even works with one letter and filter out jumps using many letters
-- Multi directional as it should be.

return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        -- Negatives: Not repeatable with ; and ,
        -- But do I REALLY need ; ?. It works with macros so, meh.
        char = {
          enabled = true,
        },
      }
    },
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
        desc = "Flash: Select Treesitter",
      },

      -- o (Operator-pending mode): d, y, or c
      -- Example: y { r <jump> } i w
      {
        "r",
        mode = "o",
        function() require("flash").remote() end,
        desc = "Flash: Remote",
      },

      -- x (Visual mode - exclusive selection)
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Flash: Remote Treesitter",
      },
    },
  },
}

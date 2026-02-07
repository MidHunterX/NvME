-- Wayyyy better than leap.
-- Not restricted to number of letters.
-- Even works with one letter and filter out jumps using many letters
-- Multi directional as it should be.

return {
  {
    "folke/flash.nvim",
    event = "BufReadPost",
    opts = {
      modes = {
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        -- Negatives: Not repeatable with ; and ,
        -- But do I REALLY need ; ?. It works with macros so, meh.
        char = {
          enabled = true,
          -- jump_labels makes ; and , repeatable but replaces letters with labels
          jump_labels = false,
          multi_line = true,
        },
      },
      -- `require("flash").prompt()` is always available to get the prompt text
      prompt = {
        enabled = false,
        prefix = { { "⚡", "FlashPromptIcon" } },
      },
    },
    keys = {
      {
        "s",
        -- NOTE: Removed Operator-pending mode "o" since I found no use in
        -- doing ys<search>. It just yanks from cursor to first search term
        -- It should be the entire line.. not just till the character.
        mode = { "n", "x" },
        function() require("flash").jump() end,
        desc = "Flash: Jump",
      },
      {
        "S",
        mode = { "n", "x" },
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

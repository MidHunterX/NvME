return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>st",
      function() Snacks.picker.todo_comments() end,
      desc = "Grep: Todo List",
    },
    {
      "<leader>sT",
      function()
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
      end,
      desc = "Grep: Todo/Fix/Fixme",
    },
  },
  opts = {
    signs = true,
    keywords = {
      FIX = {
        icon = "",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = "", color = "info" },
      HACK = { icon = "", color = "warning" },
      WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = "", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = "", color = "hint", alt = { "INFO" } },
      TEST = { icon = "", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
  }
}

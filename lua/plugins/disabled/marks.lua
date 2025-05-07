-- Don't really use marks this deeply

return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  opts = {
    refresh_interval = 400,
    bookmark_0 = {
      sign = "⚑",
      annotate = false,
    },
  },
}

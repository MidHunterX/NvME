return {
  "piersolenski/wtf.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {},
  keys = {
    {
      "<leader>wd",
      mode = { "n", "x" },
      function()
        require("wtf").diagnose()
      end,
      desc = "WTF: Debug with AI",
    },
    {
      "<leader>wf",
      mode = { "n", "x" },
      function()
        require("wtf").fix()
      end,
      desc = "WTF: Fix automatically with AI",
    },
    {
      mode = { "n" },
      "<leader>ws",
      function()
        require("wtf").search()
      end,
      desc = "WTF: Search with Google",
    },
    {
      mode = { "n" },
      "<leader>wp",
      function()
        require("wtf").pick_provider()
      end,
      desc = "WTF: Pick provider",
    },
  },
}

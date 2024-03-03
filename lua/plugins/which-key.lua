return{
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 800
  end,
  opts = {
    layout = {
      width = { min=20, max=50 },
    }
  }
}

-- Reason: Replaced by VIFM (Can do the same + many more)

return{
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    vim.keymap.set("n", "<leader>oi", function()
      vim.cmd("vsplit | wincmd h | | vertical resize -20")
      require("oil").open()
    end)
  },
  cmd = "Oil",

  config = function ()
    require("oil").setup()
  end,
}

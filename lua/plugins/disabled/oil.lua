-- Reason: Replaced by VIFM (Can do the same + many more)
-- Still, is wayy better than snacks explorer when configured into a sidebar

return{
  'stevearc/oil.nvim',
  lazy = false,
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

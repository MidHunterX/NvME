return {
  'Wansmer/treesj',
  keys = {
    { "<leader>j", "<cmd>lua require('treesj').split()<cr>", desc = "TreeSJ Split" },
    { "<leader>J", "<cmd>lua require('treesj').join()<cr>", desc = "TreeSJ Join" },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
      cursor_behavior = 'hold', ---@type 'hold'|'start'|'end'
      notify = true,
      dot_repeat = true,
      on_error = nil,
    })
  end,
}

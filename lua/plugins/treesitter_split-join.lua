return {
  'Wansmer/treesj',
  keys = {
    { "<leader>j", function() require('treesj').split() end,  desc = "TreeSJ: Split" },
    { "<leader>J", function() require('treesj').join() end,   desc = "TreeSJ: Join" },
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

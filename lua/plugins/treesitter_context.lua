return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  config = function()
    vim.cmd([[highlight TreesitterContextBottom guisp=#45475a]])
    require 'treesitter-context'.setup({
      enable = true,
      max_lines = 5,         -- 0 for no limit
      multiline_threshold = 1, -- Max lines to show for single context
      mode = 'cursor',       -- Choices: 'cursor', 'topline'
      separator = nil,       -- Choices: nil | '-'
    })
  end,
}

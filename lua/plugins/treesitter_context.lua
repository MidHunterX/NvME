return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  config = function ()
    vim.cmd([[highlight TreesitterContextBottom guisp=#45475a]])
  end,
  opts = {
    max_lines = 5,    -- 0 for no limit
    mode = 'cursor', -- Choices: 'cursor', 'topline'
    separator = nil,  -- Choices: nil | '-'
  },
}

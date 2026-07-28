-- Reason: Replaced by core NeoVim https://github.com/neovim/neovim/pull/28176
-- It's a core friendly version of mini.comments by echasnovski

-- Positives:
-- This is the only plugin that supports blockwise comments written in lua

-- Negatives:
-- Doesn't fallback to nvim's default comment support
-- This project is basically abandoned. Not even accepting pull requests.
-- Can't disable single line comments only so that you can use nvim default for
-- single line comments and use this plugin for blockwise comments

return {
  'numToStr/Comment.nvim',
  event = { "BufAdd", "BufNewFile", "BufRead" },
  opts = {},
}

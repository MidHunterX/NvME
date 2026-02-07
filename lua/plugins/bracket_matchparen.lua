-- Highlights matching parenthesis when cursor is on them
-- and also when cursor is anywhere inside the parenthesis block
-- as it should be.

return {
  "utilyre/sentiment.nvim",
  event = "VeryLazy",
  opts = {
    ---@type integer
    delay = 100,
  },
  init = function()
    -- `matchparen.vim` needs to be disabled manually in case of lazy loading
    vim.g.loaded_matchparen = 1
  end,
}

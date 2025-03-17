--[[ return {
  "smjonas/inc-rename.nvim",
  config = function()
    -- Keymap <leader>rn
    vim.keymap.set("n", "<leader>rn", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })
    require("inc_rename").setup({
      hl_group = "Substitute",
    })
  end,
} ]]

-- Wayy better than inc-rename. It uses floating window right on top of the word
-- being renamed. So, you can use all of the vim motions while renaming.
return {
  "saecki/live-rename.nvim",
  config = function()
    local live_rename = require("live-rename")
    -- start in insert mode with an empty word
    -- require("live-rename").rename({ text = "", insert = true })

    vim.keymap.set("n", "<leader>rn", live_rename.rename, { desc = "LSP rename" })
  end,
}

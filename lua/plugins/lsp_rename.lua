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
vim.api.nvim_set_hl(0, "LiveRename", { bg = "#d20f39", fg = "#ffffff" })
return {
  "saecki/live-rename.nvim",
  opts = {
    hl = {
      current = "LiveRename", -- CurSearch
      others = "Search",      -- Search
    },
  },
  keys = {
    -- start in insert mode with an empty word
    -- require("live-rename").rename({ text = "", insert = true })
    {
      "<leader>rn",
      function() require("live-rename").rename() end,
      desc = "LSP: Rename Variable",
    },
  },
}

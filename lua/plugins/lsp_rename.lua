return {
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
}

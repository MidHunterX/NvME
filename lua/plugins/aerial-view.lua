return {
  'stevearc/aerial.nvim',
  keys = {
    {
      "<leader>pv",
      "<CMD>AerialToggle<CR>",
      mode = "n",
      desc = "Toggle Aerial View"
    },
  },
  opts = {
    close_on_select = true,
    -- autojump = true,
    update_events = "InsertLeave", -- TextChanged
    show_guides = true,
    keymaps = {
      ["i"] = "actions.jump",
      ["q"] = "actions.close",
      ["x"] = "actions.close",
    },
    backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
    layout = {
      -- Enum: prefer_right, prefer_left, right, left, float
      default_direction = "float",
    },
    float = {
      relative = "editor", -- cursor editor win
    },
  },
}

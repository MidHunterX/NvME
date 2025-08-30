return {
  "leath-dub/snipe.nvim",
  keys = {
    { "<leader>b", function() require("snipe").open_buffer_menu() end, desc = "Buffer: List" }
  },
  opts = {
    ui = {
      ---@type "topleft"|"bottomleft"|"topright"|"bottomright"|"center"|"cursor"
      position = "center",
      open_win_override = {
        title = " Snipe ",
        ---@type "rounded" | "single"
        border = "rounded",
      },
      ---@type boolean
      preselect_current = true,
    },
    hints = {
      -- Charaters to use for hints (make sure they don't collide with the navigation keymaps)
      ---@type string
      dictionary = "uiopasdfewl", -- sadflewcmpghio
    },
    navigate = {
      next_page = "J",
      prev_page = "K",
      -- Select item under the cursor
      under_cursor = "<CR>",
      ---@type string|string[]
      cancel_snipe = { "q", "<Esc>", "x" },
      close_buffer = "D",
      open_vsplit = "V",
      open_split = "H",
    },
    ---@type "default"|"last"
    sort = "default",
  }
}

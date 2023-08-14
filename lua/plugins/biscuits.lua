return {
  'code-biscuits/nvim-biscuits',
  event = { "BufAdd", "BufNewFile", "BufRead" },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    cursor_line_only = true,
    -- on_events = { 'InsertLeave', 'CursorHoldI' },
    default_config = {
      max_length = 25,
      min_distance = 5,
      prefix_string = " 📎 "
    },
    language_config = {
      html = {
        prefix_string = " 🌐 "
      },
      javascript = {
        prefix_string = " ✨ ",
        max_length = 80
      },
      python = {
        disabled = true
      },
    },
  },
}

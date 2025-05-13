-- Highlights current word on visible buffer lines only.
-- Which means Exceptional Performance, even on large files.
-- Has cool animations using Snacks.nvim

return {
  "tzachar/local-highlight.nvim",
  opts = {
    disable_file_types = {'tex'},
    -- Whether to display highlights in INSERT mode or not
    insert_mode = false,
    min_match_len = 1,
    max_match_len = math.huge,
    highlight_single_match = true,
    animate = {
      enabled = true,
      easing = "linear",
      duration = {
        step = 10, -- ms per step
        total = 100, -- maximum duration
      },
    },
    debounce_timeout = 10, -- default 200
  },
}

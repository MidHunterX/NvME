-- Features
-- Highlights for removed texts like afterimage.

-- Negatives
-- constant lua errors (not actively maintained)
return {
  "aileot/emission.nvim",
  event = "VeryLazy",
  opts = {
    highlight = {
      duration = 150,
    },
    added = {
      enabled = true,
      hl_map = {
        default = true,
        bold = true,
        fg = "#a6e3a1",
        bg = "#396336",
      },
      min_row_offset = 0,
    },
    removed = {
      enabled = true,
      hl_map = {
        default = true,
        bold = true,
        fg = "#f38ba8",
        bg = "#633642",
      },
    },
    attach = {
      -- Useful to avoid extra attaching attempts in simultaneous buffer editing
      -- such as `:bufdo` or `:cdo`.
      delay = 150,
      excluded_buftypes = {
        "help",
        "nofile",
        "terminal",
        "prompt",
      },
      excluded_filetypes = {
        -- "oil",
      },
    },
  },
}

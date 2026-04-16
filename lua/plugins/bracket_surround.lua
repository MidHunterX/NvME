return {
  "kylechui/nvim-surround",
  lazy = true,
  keys = {
    { "gs", mode = { "n", "v" } },
    "gS",
    "cs",
    "cS",
    "ds",
  },
  config = function()
    vim.g.nvim_surround_no_mappings = true

    -- [g]o [s]urround {<motions> <bracket>}
    vim.keymap.set("n", "gs", "<Plug>(nvim-surround-normal)", {
      desc = "Add a surrounding pair around a motion (normal mode)",
    })
    vim.keymap.set("n", "gS", "<Plug>(nvim-surround-normal-line)", {
      desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
    })

    -- [g]o [s]urround this [l]ine with {<bracket>}
    vim.keymap.set("n", "gsl", "<Plug>(nvim-surround-normal-cur)", {
      desc = "Add a surrounding pair around the current line (normal mode)",
    })
    vim.keymap.set("n", "gSl", "<Plug>(nvim-surround-normal-cur-line)", {
      desc = "Add a surrounding pair around the current line, on new lines (normal mode)",
    })

    -- [g]o [s]urround the selection with {<bracket>}
    vim.keymap.set("x", "gs", "<Plug>(nvim-surround-visual)", {
      desc = "Add a surrounding pair around a visual selection",
    })
    vim.keymap.set("x", "gS", "<Plug>(nvim-surround-visual-line)", {
      desc = "Add a surrounding pair around a visual selection, on new lines",
    })

    -- [c]hange [s]urrounding {<bracket>}
    vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", {
      desc = "Change a surrounding pair",
    })
    vim.keymap.set("n", "cS", "<Plug>(nvim-surround-change-line)", {
      desc = "Change a surrounding pair, putting replacements on new lines",
    })

    -- [d]elete [s]urrounding {<bracket>}
    vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", {
      desc = "Delete a surrounding pair",
    })
  end
}

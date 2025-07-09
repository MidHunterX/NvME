return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      "<leader>ur",
      function()
        require('spectre').open_file_search()
      end,
      mode = { "n", "v" },
      desc = "Toggle: Spectre Regex"
    },
    {
      "<leader>uR",
      function() require('spectre').toggle() end,
      mode = "n",
      desc = "Toggle: Spectre Regex (Global)"
    },
  },
  config = function()
    vim.api.nvim_set_hl(0, "SpectreSearch", { fg = "#fad1dc", bg = "#6d132b" })
    vim.api.nvim_set_hl(0, "SpectreReplace", { fg = "#000000", bg = "#a6e3a1", bold = true })

    require('spectre').setup({
      line_sep_start = "╭─────────────────────────────────",
      result_padding = "│  ",
      line_sep = "╰─────────────────────────────────",
      live_update = false,      -- auto execute search again
      lnum_for_results = false, -- show line number for search/replace results
      is_block_ui_break = true, -- map backspace and enter to avoid ui break
      highlight = {
        ui = "String",
        search = "SpectreSearch",
        replace = "SpectreReplace"
      },
      mapping = {
        -- o (insert next line) breaks the UI
        -- so, using it for cycling through different output views (just like ccc)
        ['change_view_mode'] = {
          map = "o", -- "<leader>v"
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "cycle through output views"
        },
        -- overriding global replace keymap "rr"
        ['run_current_replace'] = {
          map = "<leader>rr", -- "<leader>rc"
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line"
        },
        ['run_replace'] = {
          map = "<leader>R",
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "replace all"
        },
        ['quit'] = {
          map = "q",
          cmd = "<C-w>q",
          desc = "quit"
        },
        ['toggle_line'] = {
          map = "dd",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle item"
        },
        ['enter_file'] = {
          map = "<cr>",
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = "open file"
        },
      },
    })
  end,
}

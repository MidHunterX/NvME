return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  keys = {
    { "ghh", "<Cmd>Gitsigns preview_hunk<CR>", mode = "n", desc = "Git Preview Hunk" },
    { "ghn", "<Cmd>Gitsigns next_hunk<CR>", mode = "n", desc = "Git Move to Next Hunk" },
    { "ghp", "<Cmd>Gitsigns prev_hunk<CR>", mode = "n", desc = "Git Move to Previous Hunk" },
    { "ghb", "<Cmd>Gitsigns blame_line<CR>", mode = "n", desc = "Git Blame Line" },
    { "ghd", "<Cmd>Gitsigns toggle_word_diff<CR>", mode = "n", desc = "Git Toggle Word Diff" },
    { "ght", "<Cmd>Gitsigns toggle_current_line_blame<CR>", mode = "n", desc = "Git Toggle Current Line Blame" },
  },
  config = function()
    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#909aa0" })

    require('gitsigns').setup {
      signs                        = {
        add          = { text = '│' }, -- │ ▌
        change       = { text = '│' }, -- │ ▌
        delete       = { text = '🭻' }, -- _ 🭻 ▁ ▂
        topdelete    = { text = '🭶' }, -- ‾ 🭶 ▔ 🮂
        changedelete = { text = '~' }, -- ~
        untracked    = { text = '┆' }, -- ┆
      },
      signcolumn                   = true,
      numhl                        = true,

      current_line_blame_opts      = {
        virt_text_pos = 'right_align', -- eol | overlay | right_align
        delay = 100,
      },
      current_line_blame_formatter = '  <author>,  <author_time:%R> - <summary>',
    }
  end
}

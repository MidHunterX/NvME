return{
  "lewis6991/gitsigns.nvim",
  config = function ()
    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", {fg="#909aa0"})

    require('gitsigns').setup{
      signs = {
        add          = { text = '│' }, -- │ ▌
        change       = { text = '│' }, -- │ ▌
        delete       = { text = '🭻' }, -- _ 🭻 ▁ ▂
        topdelete    = { text = '🭶' }, -- ‾ 🭶 ▔ 🮂
        changedelete = { text = '~' }, -- ~
        untracked    = { text = '┆' }, -- ┆
      },
      signcolumn = true,
      numhl      = true,

      current_line_blame_opts = {
        virt_text_pos = 'eol', -- eol | overlay | right_align
        delay = 1000,
      },
      current_line_blame_formatter = '  <author>,  <author_time:%R> - <summary>',
    }
  end
}

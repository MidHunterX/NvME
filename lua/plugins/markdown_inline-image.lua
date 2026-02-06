local check = require('killswitch')

return {
  "3rd/image.nvim",
  enabled = check.is_kitty,
  ft = { "markdown" },
  config = function()
    require("image").setup({
      backend = "kitty", -- "kitty"|"ueberzug"
      ---@type "magick_cli"|"magick_rock"
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          ---@type "inline"|"popup"
          only_render_image_at_cursor_mode = "inline",
          floating_windows = false,
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = {
          enabled = false,
          filetypes = { "norg" },
        },
        typst = {
          enabled = false,
          filetypes = { "typst" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      window_overlap_clear_ft_ignore = {
        "cmp_menu",
        "cmp_docs",
        "snacks_notif",
        "scrollview",
        "scrollview_sign",
      },
    })
  end
}

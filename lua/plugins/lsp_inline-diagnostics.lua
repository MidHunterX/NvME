-- Disable neovim's diagnostic virtual_text
vim.diagnostic.config({ virtual_text = false })

return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  -- priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup({
      options = {
        show_source = true,
        use_icons_from_diagnostic = false,

        -- virtual_text settings for tiny-inline-diagnostic
        multilines = {
          enabled = true,
          always_show = true,
        },
      },

      -- Overwrites preset
      signs = {
        left = "",
        right = "",
        diag = "●",
        arrow = "    ",
        up_arrow = "    ",
        vertical = " │",
        vertical_end = " └",
      },
      blend = {
        factor = 0.25,
      },
    })
  end
}

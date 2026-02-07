-- Reason: Doesn't work after invoking snacks popups like terminal/lazygit

return {
  "mvllow/modes.nvim",
  config = function()
    local general = 0.30

    require("modes").setup({
      colors = {
        bg      = '', -- Optional bg param, defaults to Normal hl group
        copy    = '#94e2d5',
        delete  = '#f38ba8',
        change  = '#f9e2af', -- Optional param, defaults to delete
        format  = '#dee5ed',
        insert  = '#a6e3a1',
        replace = '#f38ba8',
        select  = '#d8b3ff', -- Optional param, defaults to visual
        visual  = '#d8b3ff',
      },

      line_opacity = {
        copy    = general, -- #94e2d5
        delete  = general, -- #f38ba8
        change  = general, -- #f9e2af
        format  = general, -- #dee5ed
        insert  = 0.20,    -- #a6e3a1
        replace = general, -- #f38ba8
        select  = general, -- #d8b3ff
        visual  = 0.50,    -- #d8b3ff
      },

      set_cursor = true,
      set_cursorline = true,
      set_number = true,
      set_signcolumn = true,
    })
  end,
}

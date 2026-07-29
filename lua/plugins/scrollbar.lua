return {
  "petertriho/nvim-scrollbar",
  config = function()
    require("scrollbar").setup({
      handlers = {
        cursor     = true,
        diagnostic = true,
        handle     = true,
        gitsigns   = true,  -- Requires gitsigns
        search     = false, -- Requires hlslens
      },
    })
  end,
}

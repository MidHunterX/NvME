return {
  "uga-rosa/ccc.nvim",
  cmd = "CccPick",
  config = function()
    local ccc = require("ccc")
    ccc.setup({
      bar_char = "█",
      point_char = "◊",
      inputs = {
        ccc.input.hsl,
        ccc.input.rgb,
        ccc.input.cmyk,
      }
    })
  end,
  -- Test: #fff
}

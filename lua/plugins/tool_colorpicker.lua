return {
  "uga-rosa/ccc.nvim",
  cmd = "CccPick",
  config = function()
    local ccc = require("ccc")
    ccc.setup({
      preserve = true,
      bar_char = "▇", -- 🭸 █ ▇ ▆
      point_char = "◊", -- ◊ 🮮
      empty_point_bg = true,
      inputs = {
        -- ccc.input.hsv,
        ccc.input.hsl,
        ccc.input.rgb,
        ccc.input.cmyk,
        -- ccc.input.hwb,
        ccc.input.lab,
        -- ccc.input.lch,
        -- ccc.input.oklab,
        -- ccc.input.oklch,
        -- ccc.input.hsluv,
        -- ccc.input.okhsl,
        -- ccc.input.okhsv,
        -- ccc.input.xyz,
      },
      outputs = {
        ccc.output.hex,
        ccc.output.hex_short,
        ccc.output.css_rgb,
        ccc.output.css_rgba,
        -- ccc.output.css_hsl,
        -- ccc.output.css_hwb,
        -- ccc.output.css_lab,
        -- ccc.output.css_lch,
        -- ccc.output.css_oklab,
        -- ccc.output.css_oklch,
        -- ccc.output.float,
      }
    })
  end,
  -- Test: #fff
}

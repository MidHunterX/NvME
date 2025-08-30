-- TEST AREA --
-- #cba6f7 #b4befe #89b4fa #94e2d5 #a6e3a1 #f9e2af #fab387 #f38ba8
-- Violet Indigo Blue Green Yellow Orange Red
return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    user_default_options = {
      RGB = true,      -- #RGB hex codes
      RRGGBB = true,   -- #RRGGBB hex codes
      names = true,    -- "Name" codes like Blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      rgb_fn = true,   -- CSS rgb() and rgba() functions
      hsl_fn = true,   -- CSS hsl() and hsla() functions
      css = true,      -- CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
      tailwind = true, -- Enable tailwind colors
    },
    filetypes = {
      "*", -- Highlight all files, but customize some others.
      html = { mode = "background" },
      markdown = { names = false },
      "yaml",
      lua = { names = false },
    },
  }
}

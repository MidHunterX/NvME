return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { "markdown" },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    sign = { enabled = false },

    -- render_modes = { 'n', 'c', 't' }, -- disable render on insert (default)
    render_modes = true, -- enable render on insert as well

    heading = {
      sign = true,
      border = false,
      width = 'block', -- 'block' | 'full'
      right_pad = 1,
      icons = { '󰎦 ', '󰎧 ', '󰎬 ', '󰎭 ', '󰎰 ', '󰎳 ' },
      position = 'overlay', -- 'right' | 'inline' | 'overlay'
    },

    code = {
      sign = true,
      width = 'block',   -- 'block' | 'full'
      border = 'thick',  -- 'thick' | 'thin' | 'hide' | 'none'
      position = 'left', -- 'left' | 'right'
      language_pad = 1,  -- ISSUE: cursor jumping sometimes
      right_pad = 2,
      -- left_pad = 2,
      inline_pad = 1,
    },

    checkbox = {
      -- checked = { scope_highlight = '@markup.strikethrough' },
      unchecked = {
        icon = ' ', -- seti-checkbox
      },
      checked = {
        icon = ' ', -- oct-checkbox-checked
      },
      custom = {
        important = {
          raw = '[~]',
          rendered = '󰓎 ',
          highlight = 'DiagnosticWarn',
        },
      },
    },

    pipe_table = {
      enabled = true,
      preset = "round", -- "heavy" | "double" | "round" | "none"
      -- ISSUE: style="full" breaks sentiment.nvim due to cursor mismatch on G
      style = "normal", -- "none" | "normal" | "full"
      cell = 'padded',  -- 'overlay' | 'raw' | 'padded' | 'trimmed'
    },

    anti_conceal = {
      enabled = true,
      ignore = {
        code_background = true,
        sign = true,
      },
      -- above = 1,
      -- below = 1,
    },
  },
}

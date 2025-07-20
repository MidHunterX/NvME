-- Initial Impressions:
-- The idea is really amazing! Making the cursor itself function like a mode indicator
-- or simply just making everything rective to mode makes things much better.
-- Your eyes are keeping track of the cursor so, mode indicator being there helps.
-- Bugs:
-- Lualine disappear sometimes

return {
  'rasulomaroff/reactive.nvim',
  config = function()
    local reactive = require('reactive')

    local catppuccin_palette = {
      -- Modes
      normal      = { light = '#ffffff', dark = '#2a293d' },
      insert      = { light = '#98f391', dark = '#1b3232' },
      visual      = { light = '#d8b3ff', dark = '#59476b' },
      visualblock = { light = '#d0b3ff', dark = '#59476b' },
      replace     = { light = '#f38ba8', dark = '#42242c' },
      -- Operators
      delete      = { light = '#ff9898', dark = '#532d2d' },
      yank        = { light = '#89dceb', dark = '#2d4d53' },
      change      = { light = '#f9e2af', dark = '#3d3729' },
      g           = { light = '#dee5ed', dark = '#303d4f' },
    }

    -- Set colorscheme here
    local color = catppuccin_palette

    local preset_cursor = {
      name = 'DynamicCursor',
      init = function()
        vim.opt.guicursor:append 'a:ReactiveCursor'
        vim.opt.cursorline = true
      end,
      modes = {

        -- INSERT MODE (niI == <C-o> in insert mode)
        [{ 'i', 'niI' }] = {
          hl = { ReactiveCursor = { bg = color.insert.light } },
          winhl = {
            CursorLineNr = { fg = color.insert.light, bg = color.insert.dark },
            CursorLine = { bg = color.insert.dark },
          },
        },

        -- NORMAL MODE
        n = {
          hl = { ReactiveCursor = { bg = color.normal.light } },
          winhl = {
            CursorLineNr = { fg = color.normal.light, bg = color.normal.dark },
            CursorLine = { bg = color.normal.dark },
          },
        },

        -- VISUAL MODE
        [{ 'v', 'V', '\x16' }] = {
          hl = { ReactiveCursor = { bg = color.visual.light } },
          winhl = {
            CursorLineNr = { fg = color.visual.light },
            Visual = { bg = color.visual.dark },
          },
        },

        -- VISUAL BLOCK MODE
        [{ 's', 'S', '\x13' }] = {
          hl = {
            ReactiveCursor = { bg = color.visualblock.light },
          },
          winhl = {
            CursorLineNr = { fg = color.visualblock.light },
            Visual = { bg = color.visualblock.dark },
          },
        },

        -- REPLACE MODE
        [{ 'R', 'niR', 'niV' }] = {
          hl = {
            ReactiveCursor = { bg = color.replace.light },
          },
          winhl = {
            CursorLine = { bg = color.replace.dark },
            CursorLineNr = { fg = color.replace.light, bg = color.replace.dark },
          },
        },

        no = {
          operators = {
            d = {
              hl = {
                ReactiveCursor = { bg = color.delete.light },
              },
              winhl = {
                CursorLineNr = { fg = color.delete.light, bg = color.delete.dark },
                CursorLine = { bg = color.delete.dark },
              },
            },

            y = {
              hl = {
                ReactiveCursor = { bg = color.yank.light },
              },
              winhl = {
                CursorLineNr = { fg = color.yank.light, bg = color.yank.dark },
                CursorLine = { bg = color.yank.dark },
              },
            },

            c = {
              hl = {
                ReactiveCursor = { bg = color.change.light },
              },
              winhl = {
                CursorLineNr = { fg = color.change.light, bg = color.change.dark },
                CursorLine = { bg = color.change.dark },
              },
            },

            [{ 'gu', 'gU', 'g~', '~' }] = {
              winhl = {
                CursorLineNr = { fg = color.g.light, bg = color.g.dark },
                CursorLine = { bg = color.g.dark },
              },
            },
          },
        },
      },
    }

    reactive.setup {
      builtin = {
        cursor = preset_cursor,
        cursorline = false,
        modemsg = false
      }
    }
  end,
}

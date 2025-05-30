local cmp = require("cmp")
local cmp_gitcommit = require("cmp_gitcommit")

-- Register sources first
cmp.register_source("keywords_source", cmp_gitcommit.keywords_source())
cmp.register_source("scope_source", cmp_gitcommit.scope_source())

cmp.setup.buffer({
  sources = cmp.config.sources(
    {
      {
        name = "keywords_source",
        entry_filter = function()
          -- Available on first n columns
          local available_cols = 6
          local col = vim.api.nvim_win_get_cursor(0)[2]
          return col < available_cols
        end,
      },
      {
        name = "scope_source",
        entry_filter = function()
          -- True only if cursor inside first parentheses
          local line = vim.api.nvim_get_current_line()
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local text_before_cursor = line:sub(1, col)
          local text_after_cursor = line:sub(col + 1)
          local open_paren_count = select(2, text_before_cursor:gsub("%(", ""))
          local close_paren_count = select(2, text_after_cursor:gsub("%)", ""))
          if open_paren_count == 0 and close_paren_count == 0 then
            return false
          end
          return open_paren_count == close_paren_count
        end,
      },
      {
        -- Not available on first n columns
        -- Not available if cursor is inside first parentheses
        name = "buffer",
        entry_filter = function()
          local available_cols = 6
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local line = vim.api.nvim_get_current_line()
          local text_before_cursor = line:sub(1, col)
          local text_after_cursor = line:sub(col + 1)
          local open_paren_count = select(2, text_before_cursor:gsub("%(", ""))
          local close_paren_count = select(2, text_after_cursor:gsub("%)", ""))
          local is_outside_paren = open_paren_count ~= close_paren_count
          local is_no_paren = open_paren_count == 0 and close_paren_count == 0
          local is_outside_available_cols = col >= available_cols
          return is_outside_available_cols and (is_outside_paren or is_no_paren)
        end,
      }
    }
  ),
})

-- SPELL DETECTION
vim.opt_local.spell = true

-- ------------------------------------------------------------------------ --
--                             CUSTOM FUNCTIONS                             --
-- ------------------------------------------------------------------------ --

-- LSP Server Attach Status
local function lsp_name()
  -- local clients = vim.lsp.get_active_clients()  -- Deprecated
  local clients = vim.lsp.get_clients()
  local buffer = vim.api.nvim_get_current_buf()

  -- SHOW AN ICON IF LSP IS ATTACHED ON CURRENT BUFFER (MUCH BETTER)
  for _, client in pairs(clients) do
    local attached = vim.lsp.buf_is_attached(buffer, client.id)
    if attached then
      return '󰍜' -- LSP server attached on current buffer
    end
  end
  return '' -- No LSP servers loaded at all
end

-- Recording Status
local function recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then return "" end -- not recording
  return "󰑊 REC @" .. reg
end

-- 'o:encoding': Don't display if encoding is UTF-8.
local encoding = function()
  local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
  return ret
end

-- 'fileformat': Don't display if &ff is unix.
local fileformat = function()
  local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
  local icons = {
    dos = '', -- e70f
    mac = '', -- e711
    unix = '' -- e712
  }
  return icons[ret] or ret
end

--------------------------------------------------------------------------- --
--                             CUSTOM TUI THEME                             --
-- ------------------------------------------------------------------------ --

---@type "slanted_bubble" | "futuristic"
local ui = "futuristic"
local tui = {}
if ui == "futuristic" then
  tui = {
    lualine = {
      a = {  left = '█', right = ''  },
      z = {  left = '', right = '█'  },
    },
    tabline = {
      a = {  left = '█', right = ''  },
      a_next = {  left = '█', right = ''  },
      z = {  left = '', right = '█'  },
    }
  }
elseif ui == "bubble" then
  tui = {
    lualine = {
      a = {  left = '', right = ''  },
      z = {  left = '', right = ''  },
    },
    tabline = {
      a = {  left = '', right = ''  },
      a_next = {  left = '', right = ''  },
      z = {  left = '', right = ''  },
    }
  }
end


-- ------------------------------------------------------------------------- --
--                               RETURN CONFIG                               --
-- ------------------------------------------------------------------------- --

return {
  'nvim-lualine/lualine.nvim',
  -- For preventing loading of lualine on dashboard
  -- Enabling any events makes bufferline disappear after opening a file from dashboard via fuzzy finding (+8ms)
  -- event = { "BufAdd", "BufNewFile", "BufRead" },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {

    options = {
      theme = 'catppuccin',
      icons_enabled = true,
      component_separators = '',
      section_separators = '',
      globalstatus = true,
      refresh = {
        tabline = 100,
        statusline = 100,
        winbar = 100,
      }
    },

    -- +-------------------------------------------------------------------+ --
    -- |  A  |  B  |  C                                     X  |  Y  |  Z  | --
    -- +-------------------------------------------------------------------+ --

    sections = {

      lualine_a = {
        {
          'mode',
          separator = { left = tui.lualine.a.left, right = tui.lualine.a.right },
          -- fmt = function(str) return str:sub(1,3) end,
          padding = { left = 1, right = 1 }
        },
      },
      lualine_b = {
        { 'branch', separator = { right = '' }, draw_empty = true, },
      },
      lualine_c = {
        {
          'filename',
          path = 1,
          symbols = {
            modified = '[+]',
            readonly = '[-]',
            unnamed = '[No Name]',
            newfile = '[New]',
          }
        },
        { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } },
        '%=',
        'diagnostics',
      },

      lualine_x = {
        fileformat,
        encoding,
        'filetype',
      },
      lualine_y = {
        { 'progress', separator = { left = '' } },
      },
      lualine_z = {
        { 'location', separator = { left = tui.lualine.z.left, right = tui.lualine.z.right } },
      },

    },

    -- +-------------------------------------------------------------------+ --
    -- |  A  |  B  |  C                                     X  |  Y  |  Z  | --
    -- +-------------------------------------------------------------------+ --

    tabline = {

      lualine_a = {
        { 'searchcount', separator = { left = tui.tabline.a.left, right = tui.tabline.a.right } },
        {
          recording,
          separator = { left = tui.tabline.a_next.left, right = tui.tabline.a_next.right },
          color = { fg = "white", bg = "red" }
        }
      },
      lualine_b = {
      },
      lualine_c = { 'selectioncount' },
      lualine_x = {
        {
          'tabs',
          cond = function() return #vim.api.nvim_list_tabpages() > 1 end,
          -- fmt = function(str) return str:sub(1, 4) end,
          mode = 0, -- 0 = number | 1 = name | 2 = number + name
          use_mode_colors = true,
          show_modified_status = false,
          symbols = {
            modified = '[+]',
          },
        },
      },
      lualine_y = {
        { lsp_name, separator = { left = '', }, draw_empty = true },
      },
      lualine_z = {
        -- Returns initial 4 characters of filename because:
        -- I only need a simple visual id for quickly recognizing buffers.
        -- Prevents overflow on long filenames
        {
          'buffers',
          fmt = function(str) return str:sub(1, 4) end,
          use_mode_colors = true,
          symbols = {
            modified = ' ●',
            directory = ' ',
            alternate_file = '',
          },
          -- Source: Nerdfont ple-.*
          separator = { left = tui.tabline.z.left, right = tui.tabline.z.right },
          component_separators = { right = '' },
          section_separators = { left = '', right = '' },
        },
      }

    },

  },

}

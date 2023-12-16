-- ------------------------------------------------------------------------ --
--                             CUSTOM FUNCTIONS                             --
-- ------------------------------------------------------------------------ --

-- Buffer Attached LSP Server
local function lsp_status()
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return ''
  end
  return '('..clients[1].name..')'
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
    dos = '',  -- e70f
    mac = '',  -- e711
    unix = ''  -- e712
  }
  return icons[ret] or ret
end

-- ------------------------------------------------------------------------- --
--                               RETURN CONFIG                               --
-- ------------------------------------------------------------------------- --

return {
  'nvim-lualine/lualine.nvim',
  -- For preventing loading of lualine on dashboard
  event = { "BufAdd", "BufNewFile", "BufRead" },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {

    options = {
      icons_enabled = true,
      component_separators = '',
      -- section_separators = '',
      section_separators = { left = '', right = '' },
      refresh = {
        statusline = 3000,
        tabline = 3000,
        winbar = 3000,
      }
    },

    -- +-------------------------------------------------+ --
    -- | A | B | C                             X | Y | Z | --
    -- +-------------------------------------------------+ --

    sections = {

      lualine_a = {
        { 'mode', separator = { left = '' }},
      },
      lualine_b = {
        'branch',
        { 'diff', symbols = {added = '+', modified = '~', removed = '-'} },
        'diagnostics',
      },
      lualine_c = {
        '%=',
        { 'filetype', colored = true, icon_only = true },
        'filename',
        lsp_status,
      },

      lualine_x = {
        fileformat,
        encoding
      },
      lualine_y = {
        'filetype',
        'progress'
      },
      lualine_z = {
        { 'location', separator = { right = '' }},
      },

    },

  },

}

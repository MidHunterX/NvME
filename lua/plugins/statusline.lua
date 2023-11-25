return {
  'nvim-lualine/lualine.nvim',
  -- For preventing loading of lualine on dashboard
  event = { "BufAdd", "BufNewFile", "BufRead" },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      icons_enabled = true,
      component_separators = '|',
      section_separators = '',
    },
  }
}

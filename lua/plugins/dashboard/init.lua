local function MidHunterX_UI()
  local table = require("plugins.dashboard.header")
  local ascii_art = table.table
  return ascii_art
end

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = {
    theme = 'hyper',     --  theme is doom and hyper default is hyper
    disable_move = true, -- boolean default is false disable move key
    config = {
      header = MidHunterX_UI(),
      ---------- [ACTIONS] ----------
      -- lua vim.api.nvim_command("!<shell cmd>")
      shortcut = {
        {
          desc = '󰊳 Netrw',
          group = 'Number',
          action = 'lua vim.api.nvim_command("Ex")',
          key = 'f'
        },
        {
          desc = ' Telescope',
          group = 'DiagnosticHint',
          action = 'Telescope find_files',
          key = 'd',
        },
        {
          desc = ' Grep',
          group = 'Label',
          action = 'Telescope live_grep',
          key = 's',
        },
        {
          desc = ' Random',
          group = 'Debug',
          action = 'lua print(math.random(1, 100))',
          key = 'r',
        },
      },
      -- Most Recent Files
      mru = {
        limit = 2,
        icon = ' ',
        label = 'Recent Files',
      },
      footer = {}
    }
  },
}

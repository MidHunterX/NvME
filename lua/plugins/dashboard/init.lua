local function MidHunterX_UI()
  local table = require("plugins.dashboard.header")
  local ascii_art = table.table
  return ascii_art
end

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function ()
    -- General
    vim.cmd([[highlight DashboardHeader guifg=#b5bfe2 gui=nocombine]])
    -- Hyper theme
    vim.cmd([[highlight DashboardProjectTitle guifg=#89b4fa gui=nocombine]])
    vim.cmd([[highlight DashboardMruTitle guifg=#89b4fa gui=nocombine]])
    vim.cmd([[highlight DashboardFiles guifg=#cdd6f4 gui=nocombine]])

    require('dashboard').setup {
      theme = 'hyper',     --  theme is doom and hyper default is hyper
      disable_move = false, -- boolean default is false
      hide = {
        statusline = false,
        tabline = true,
      },
      config = {
        header = MidHunterX_UI(),
        shortcut = {
          {
            desc = ' New File',
            group = 'Number',
            action = 'enew',
            key = 'n'
          },
          {
            desc = ' Fuzzy Find',
            group = 'DiagnosticHint',
            action = 'lua Snacks.picker.files()',
            key = 'f',
          },
          {
            desc = ' Grep Search',
            group = 'Label',
            action = 'lua Snacks.picker.grep()',
            key = 'g',
          },
          {
            desc = ' Random',
            group = 'Debug',
            action = 'lua print(" " .. math.random(1, 999))',
            key = 'r',
          },
        },
        -- Project List
        project = {
          limit = 4,
          icon = '  ',
          label = 'Recent Projects',
        },
        -- Most Recent Files
        mru = {
          limit = 3,
          icon = '  ',
          label = 'Recent Files',
        },
        footer = {''}
      }
    }
  end,
}

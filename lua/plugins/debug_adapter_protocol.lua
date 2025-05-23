local hint = [[
 _n_:  step over   _s_:  Start/Continue
 _i_:  step into   _x_: 󰈆 Exit Debug Hydra
 _o_:  step out    _b_:  Breakpoint
 _c_: to cursor     _u_: UI Toggle
 ^
 ^ ^            _q_: Quit DAP
]]

return {
  "mfussenegger/nvim-dap",

  keys = {
    -- Keymaps on Normal mode
    { '<leader>ub', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { "<leader>ud", function() require 'hydra'.spawn('dap-hydra') end, desc = "Debug: Toggle Debug Mode" },
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Hydra Debug mode
    -- Source: https://github.com/anuvyklack/hydra.nvim/issues/3#issuecomment-1162988750
    local Hydra = require('hydra')
    local dap_hydra = Hydra({
      hint = hint,
      config = {
        -- see `:h hydra-colors`
        color = 'pink',
        invoke_on_body = true,
        hint = {
          --  top-left   |  top   |  top-right
          -- middle-left | middle | middle-right
          -- bottom-left | bottom | bottom-right
          position = "bottom",
          offset = 0,
        },
      },
      name = 'dap',
      mode = { 'n', 'x' },
      -- body = '<leader>dh',
      heads = {
        { 'n', dap.step_over,         { silent = true } },
        { 'i', dap.step_into,         { silent = true } },
        { 'o', dap.step_out,          { silent = true } },
        { 'c', dap.run_to_cursor,     { silent = true } },
        { 's', dap.continue,          { silent = true } },
        { 'u', dapui.toggle,          { silent = true } },
        { 'b', dap.toggle_breakpoint, { silent = true } },
        { 'x', nil,                   { exit = true, nowait = true } },
        {
          'q',
          function()
            dap.close()
            dapui.close()
          end,
          { exit = true, silent = true },
        },
      }
    })
    Hydra.spawn = function(head)
      if head == 'dap-hydra' then
        dap_hydra:activate()
        dapui.open()
      end
    end

    -- Mason DAP
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {},
    }

    -- DAP UI setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = 'red' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = 'yellow' })
    local breakpoint_icons = {
      Breakpoint = '',
      BreakpointCondition = '',
      BreakpointRejected = '',
      LogPoint = '',
      Stopped = '',
    }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end
  end,

  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio", -- Required dependency for nvim-dap-ui

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Needed for setting up Debug mode
    "nvimtools/hydra.nvim",
  },
}

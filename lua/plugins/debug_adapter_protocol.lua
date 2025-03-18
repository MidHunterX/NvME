return {
  "mfussenegger/nvim-dap",

  keys = {
    -- Keymaps on Normal mode
    { '<leader>ub', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { "<leader>ud", function() require("dapui").toggle() end,          desc = "Debug: Toggle DAP UI" },
    -- Keymaps in Debug mode
    { '<F1>',       function() require('dap').step_into() end,         desc = 'Debug: Step Into' },
    { '<F2>',       function() require('dap').step_over() end,         desc = 'Debug: Step Over' },
    { '<F3>',       function() require('dap').step_out() end,          desc = 'Debug: Step Out' },
    { '<F4>',       function() require('dap').continue() end,          desc = 'Debug: Start/Continue' },
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

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
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
        or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    -- Automatically open DAP UI
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,

  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio", -- Required dependency for nvim-dap-ui

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
}

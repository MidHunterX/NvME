-- Reason: Not really a seamless integration into buffer

return {
  'gorbit99/codewindow.nvim',
  config = function()
    local codewindow = require('codewindow')
    codewindow.setup(
      {
        active_in_terminals = false,
        auto_enable = false,
        exclude_filetypes = { 'help' },
        max_minimap_height = nil,
        max_lines = nil,
        minimap_width = 20,
        use_lsp = true,
        use_treesitter = true,
        use_git = true,
        width_multiplier = 4, -- How many characters one dot represents
        z_index = 1,
        show_cursor = true,
        screen_bounds = 'lines', -- How the visible area is displayed, "lines": lines above and below, "background": background color
        window_border = 'single', -- The border style of the floating window (accepts all usual options)
        relative = 'win', -- What will be the minimap be placed relative to, "win": the current window, "editor": the entire editor
        events = { 'TextChanged', 'InsertLeave', 'DiagnosticChanged', 'FileWritePost' } -- Events that update the code window
      }
    )
    codewindow.apply_default_keybinds()
  end,
}

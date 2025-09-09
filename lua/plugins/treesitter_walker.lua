return {
  'aaronik/treewalker.nvim',
  keys = {
    -- Move
    { '<C-k>',   '<cmd>Treewalker Up<cr>',        mode = { 'n', 'v' }, desc = 'TreeWalker: Move Up' },
    { '<C-j>',   '<cmd>Treewalker Down<cr>',      mode = { 'n', 'v' }, desc = 'TreeWalker: Move Down' },
    { '<C-h>',   '<cmd>Treewalker Left<cr>',      mode = { 'n', 'v' }, desc = 'TreeWalker: Move Left' },
    { '<C-l>',   '<cmd>Treewalker Right<cr>',     mode = { 'n', 'v' }, desc = 'TreeWalker: Move Right' },
    -- Swap
    { '<C-S-k>', '<cmd>Treewalker SwapUp<cr>',    mode = 'n',          desc = 'TreeWalker: Swap Up' },
    { '<C-S-j>', '<cmd>Treewalker SwapDown<cr>',  mode = 'n',          desc = 'TreeWalker: Swap Down' },
    { '<C-S-h>', '<cmd>Treewalker SwapLeft<cr>',  mode = 'n',          desc = 'TreeWalker: Swap Left' },
    { '<C-S-l>', '<cmd>Treewalker SwapRight<cr>', mode = 'n',          desc = 'TreeWalker: Swap Right' },

  },
  opts = {
    highlight_duration = 150,
    select = false,
  }
}

return {
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    vim.cmd([[highlight RainbowBracket1 guifg=#d4d65c gui=nocombine]])
    vim.cmd([[highlight RainbowBracket2 guifg=#d78cd9 gui=nocombine]])
    vim.cmd([[highlight RainbowBracket3 guifg=#82c1e3 gui=nocombine]])
    vim.cmd([[highlight RainbowBracket4 guifg=#8cd98c gui=nocombine]])

    -- This module contains a number of default definitions
    local rainbow_delimiters = require 'rainbow-delimiters'

    vim.g.rainbow_delimiters = {
      strategy = {
        -- Use global strategy by default
        [''] = rainbow_delimiters.strategy['global'],
        -- Use local strategy
        vim = rainbow_delimiters.strategy['local'],
        html = rainbow_delimiters.strategy['local'],
        htmldjango = rainbow_delimiters.strategy['local'],
      },
      query = {
        -- Use parentheses by default
        [''] = 'rainbow-delimiters',
        -- Use blocks for Lua
        lua = 'rainbow-blocks',
      },
      highlight = {
        'RainbowBracket1',
        'RainbowBracket2',
        'RainbowBracket3',
        'RainbowBracket4',
      },
    }
  end
}

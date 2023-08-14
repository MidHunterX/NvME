return {
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    vim.cmd([[highlight RainbowBracket1 guifg=#dbc560 gui=nocombine]])
    vim.cmd([[highlight RainbowBracket2 guifg=#cc81cc gui=nocombine]])
    vim.cmd([[highlight RainbowBracket3 guifg=#67b4e7 gui=nocombine]])
    vim.cmd([[highlight RainbowBracket4 guifg=#7cdb7b gui=nocombine]])
    -- This module contains a number of default definitions
    local rainbow_delimiters = require 'rainbow-delimiters'

    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
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

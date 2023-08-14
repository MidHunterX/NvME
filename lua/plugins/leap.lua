return {
  'ggandor/leap.nvim',
  -- event = { "BufAdd", "BufNewFile", "BufRead" },
  config = function()
    require('leap').add_default_mappings()
  end,
}

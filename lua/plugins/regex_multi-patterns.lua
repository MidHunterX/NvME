return {
  "Mr-LLLLL/interestingwords.nvim",
  keys = {
    {
      "<leader>m",
      function() require("interestingwords").InterestingWord('n', false) end,
      mode = "n",
      desc = "Mark: Multi Regex Search"
    },
    {
      "<leader>m",
      function() require("interestingwords").InterestingWord('v', false) end,
      mode = "x",
      desc = "Mark: Multi Regex Search"
    },
    {
      "<leader>em",
      function() require("interestingwords").UncolorAllWords() end,
      desc = "Mark: Erase Multi Regex"
    },
  },
  opts = {
    colors = {
      '#a6e3a1',
      '#c6a0f6',
      '#89dceb',
      '#f5bde6',
      '#fab387',
    },
    -- provides better noice.nvim search virtual text configuration
    -- automatically hides search count after some seconds
    search_count = true,
    -- navigate using n and N
    navigation = true,
    -- smooth scroll
    scroll_center = false,

    -- Disabling the default mappings
    search_key = false,
    color_key = false,
    select_mode = "loop", -- random or loop
  },
}

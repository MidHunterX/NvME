return {
  'nvim-telescope/telescope.nvim',
  cmd = "Telescope",
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    -- FUZZY FINDER
    {
      "<leader>ff",
      "<CMD>Telescope find_files<CR>",
      mode = "n",
      desc = "Telescope Fuzzy Find Files"
    },
    -- GET GREP
    {
      "<leader>gg",
      "<CMD>Telescope live_grep<CR>",
      mode = "n",
      desc = "Telescope Live GREP"
    },
    -- MARKS LIST
    {
      "<leader>m",
      "<CMD>Telescope marks<CR>",
      mode = "n",
      desc = "Telescope Marks List"
    },
    -- BUFFER LIST
    {
      "<leader>b",
      "<CMD>Telescope buffers<CR>",
      mode = "n",
      desc = "Telescope Buffer List"
    },
  },
  opts = {
    defaults = {
      prompt_prefix = "   ",
      selection_caret = "󱞩 ",
    }
  },
}

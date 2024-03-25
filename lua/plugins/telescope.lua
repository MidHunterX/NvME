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
    -- PROJECT VISIT BUFFERS
    {
      "<leader>pv",
      "<CMD>Telescope buffers<CR><Esc>",
      mode = "n",
      desc = "Telescope Buffer List"
    },
    -- MARKS LIST
    {
      "<leader>m",
      "<CMD>Telescope marks<CR>",
      mode = "n",
      desc = "Telescope Marks List"
    }
  },
}

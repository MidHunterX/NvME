return {
  'nvim-telescope/telescope.nvim',
  cmd = "Telescope",
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    -- FUZZY FINDER
    { "<leader>ff", "<CMD>Telescope find_files<CR>",   mode = "n" },
    -- GET GREP
    { "<leader>gg", "<CMD>Telescope live_grep<CR>",    mode = "n" },
    -- PROJECT VISIT BUFFERS
    { "<leader>pv", "<CMD>Telescope buffers<CR><Esc>", mode = "n" },
  },
}

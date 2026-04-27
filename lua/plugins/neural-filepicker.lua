return {
  "dtormoen/neural-open.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  -- NeuralOpen implements lazy loading internally. It needs to be loaded for recency tracking to work.
  lazy = false,
  keys = {
    { "<leader><leader>", "<Plug>(NeuralOpen)", desc = "Neural Open Files" },
  },
  opts = {
    -- Scoring algorithm: "nn" (neural network), "classic" (weighted features), or "naive"
    algorithm = "nn",
  },
}

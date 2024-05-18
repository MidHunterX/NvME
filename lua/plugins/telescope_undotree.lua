return {
  "debugloop/telescope-undo.nvim",
  cmd = "Telescope undo",
  lazy = true,
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    -- UNDO TREE
    {
      "<leader>u",
      "<cmd>Telescope undo<cr>",
      mode = "n",
      desc = "Telescope Undo Tree"
    },
  },

  opts = {
    extensions = {
      undo = {
        side_by_side = true,
        -- layout_strategy = "vertical",
        -- layout_config = {
        --   preview_height = 0.8,
        -- },
      },
    },
  },

  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("undo")
  end,

}

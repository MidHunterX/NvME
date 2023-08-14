return {
  "debugloop/telescope-undo.nvim",
  cmd = "Telescope undo",
  lazy = true,
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    -- UNDO TREE
    { "<leader>u", "<cmd>Telescope undo<cr>", mode = "n" },
  },
  config = function()
    require("telescope").setup({
      extensions = {
        undo = {
          side_by_side = true,
          layout_config = {
            preview_height = 0.8,
          },
        },
      },
    })
    require("telescope").load_extension("undo")
    -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
  end

}

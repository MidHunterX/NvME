vim.keymap.set("n", "<leader>v", function()
  require("dap-view").toggle()
end, { desc = "Toggle nvim-dap-view" })

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "igorlfs/nvim-dap-view", opts = {} },
  },
}

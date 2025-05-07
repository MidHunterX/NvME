vim.api.nvim_set_hl(0, "VirtColumn", {fg="#45475a"}) -- #45475a #585b70

return {
  "lukas-reineke/virt-column.nvim",
  opts = {
    char = "│", -- │┃
    highlight = "VirtColumn",
  },
}

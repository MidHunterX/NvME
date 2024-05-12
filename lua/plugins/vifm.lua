vim.g.vifm_exec_args = "+'set vifminfo-=savedirs,dirstack'"

return {
  "vifm/vifm.vim",
  keys = {
    vim.keymap.set("n", "<leader>pf", "<Cmd>Vifm<CR>")
  },
  cmd = "Vifm",
}

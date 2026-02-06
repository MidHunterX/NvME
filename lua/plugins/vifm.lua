local check = require('killswitch')

-- Cannot be replaced by Snacks.terminal yet
-- as it can be used to load file into nvim buffer as well

-- local setting = "-c 'set vifminfo-=savedirs,dirstack,state,tui' "
-- local command = "-c only"

-- vim.g.vifm_exec_args = setting .. command

return {
  "vifm/vifm.vim",
  enabled = check.is_vifm,
  keys = {
    vim.keymap.set("n", "<leader>pf", "<Cmd>Vifm<CR>", { desc = "Project File Browser (vifm)" }),
    vim.keymap.set("n", "<leader>uv", "<Cmd>Vifm<CR>", { desc = "Toggle: VIFM Explorer" }),
  },
  cmd = "Vifm",
}

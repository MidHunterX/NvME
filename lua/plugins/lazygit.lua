return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>gc", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  },
  config = function ()
    vim.g.lazygit_use_custom_config_file_path = 1
    -- lazygit_config_file_path = '~/.config/lazygit/config.yml'
  end
}

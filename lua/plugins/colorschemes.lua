return {
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme "vscode"
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "onedark"
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      -- vim.cmd.colorscheme "rose-pine"
    end,
  },
}

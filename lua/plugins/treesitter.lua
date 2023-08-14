return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    -- ZIG made it possible to compile parsers for windows :D
    require 'nvim-treesitter.install'.compilers = {'zig'}

    require 'nvim-treesitter.configs'.setup {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { "yaml" } },
      modules = {},
      ignore_install = {},
      incremental_selection = {
        -------------------------------------------- [ Enables on Normal mode ]
        enable = true,
        keymaps = {
          init_selection = '<C-k>',
          node_incremental = '<C-k>',
          node_decremental = '<C-j>',
          scope_incremental = '<C-h>',
        },
      },
    }
  end,
}

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    -- ZIG is more compatible with windows :D
    require 'nvim-treesitter.install'.compilers = {'gcc', 'zig'}

    require 'nvim-treesitter.configs'.setup {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "dockerfile",
        "gitignore",
        "graphql",
        "html",
        "java",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
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

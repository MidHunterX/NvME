return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fm",
      function() require("conform").format({ async = true }) end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      css = { "prettier" },
      go = { "goimports", "gofmt" },
      graphql = { "prettier" },
      html = { "prettier" },
      htmldjango = { "djlint" },
      javascript = { "prettier", "prettierd", stop_after_first = true },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      less = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      python = { "black", "isort" },
      rust = { "rustfmt", lsp_format = "fallback" },
      scss = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      yaml = { "prettier" },
    },

    default_format_opts = {
      lsp_format = "fallback",
    },

    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_format = "fallback",
    -- },

    notify_no_formatters = true,

    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      djlint = {
        prepend_args = {
          "--reformat",
          "--indent", "2",
          "--format-css", "--indent-css", "2",
          "--format-js", "--indent-js", "2",
          "--max-blank-lines", "5",
          "--max-line-length", "120",
          "--max-attribute-length", "120",
        },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

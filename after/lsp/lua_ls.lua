local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      capabilities = capabilities,
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = {
        -- Make the server aware of Neovim runtime files
        -- Opens up completions for `vim.*`
        -- This includes sources from everything loaded in runtime, which you
        -- should not need unless you are actively developing nvim or plugins.
        -- Downside: Constant diagnosing workspace and slow performance
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

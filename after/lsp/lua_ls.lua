-- The most popular Lua language server

-- Disadvantages:
-- * Constant diagnosing workspace and slow performance if nvim_get_runtime_file is enabled

local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      capabilities = capabilities,
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = {
        -- library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

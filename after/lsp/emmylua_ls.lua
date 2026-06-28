-- Advantages:
-- emmylua is super fast and can even load nvim_get_runtime_file without any hiccups unlike lua_ls

-- Notes:
-- Not really a disadvantage but it will catch every single logic shortcuts / quick hacks and warns you.
-- The buffer will look like a christmas tree unless you write code properly.
-- Same rule goes when using other's plugins as well.

local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
  settings = {
    Lua = {
      capabilities = capabilities,
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = {
        -- Make the server aware of Neovim runtime files
        -- Opens up completions for `vim.*`
        library = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
}

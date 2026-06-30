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
      version = "LuaJIT", -- the version nvim uses
      runtime = {
        requirePattern = {
          "lua/?.lua",
          "lua/?/init.lua",
          "?/lua/?.lua", -- this allows plugins to be loaded
          "?/lua/?/init.lua"
        }
      },
      capabilities = capabilities,
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = {
        ignoreGlobs = { "**/*_spec.lua" }, --- to avoid some weird type defs in a plugin
        library = {
          "$VIMRUNTIME",                 -- for vim.*
          "$LLS_Addons/luvit",           -- for vim.uv.*
          "$HOME/.local/share/nvim/lazy" -- plugins dir, change to something else if you don't use lazy.nvim
        }
      }
    }
  }
}

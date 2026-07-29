-- Advantages:
-- emmylua is super fast and can even load nvim_get_runtime_file without any hiccups unlike lua_ls

-- Notes:
-- Not really a disadvantage but it will catch every single logic shortcuts / quick hacks and warns you.
-- The buffer will look like a christmas tree unless you write code properly.
-- Same rule goes when using other's plugins as well.

return {
  vim.lsp.config('emmylua_ls', {
    settings = {
      emmylua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        -- Make the server aware of Neovim runtime files.
        workspace = {
          --[[ library = {
            vim.env.VIMRUNTIME,
            -- For LSP Settings Type Annotations:
            vim.api.nvim_get_runtime_file('lua/lspconfig', false)[1]
          } ]]
          -- Or pull in all of 'runtimepath'. May be slower!
          -- but, emmy is fast enough to take such a hit.
          library = vim.api.nvim_get_runtime_file('', true)
        }
      }
    }
  })
}

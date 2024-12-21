return {
  --==========================[ MASON LSP MANAGER ]==========================--

  -- Manager for language servers, linters, formatters
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = ' ',
          package_pending = ' ',
          package_uninstalled = ' ',
        },
        border = 'rounded',
        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
      },
    },
  },


  --=====================[ MASON TOOLS AUTO INSTALLER ]=====================--

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server", -- Bash LSP
        "lua-language-server",  -- Lua LSP
        "emmet_ls",             -- Emmet LSP
        "css-lsp",              -- CSS LSP
        "json-lsp",             -- JSON LSP
        "pyright",              -- Python LSP
        "black",                -- Python Formatter
        "prettier",             -- Webdev Stuff Formatter
      },
    },
  },

  --==========================[ MASON LSP CONFIG ]==========================--

  -- Configures Mason installed servers to LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {},
    },

    -- Automatically configures LSP servers
    config = function()

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("mason-lspconfig").setup_handlers {
        function(server_name)  -- default handler (optional)

          -- LUA LANGUAGE SERVER CUSTOM CONFIG
          if server_name == 'lua_ls' then
            require("lspconfig")[server_name].setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim', 'require' },
                  },
                  workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                    -- Removes stupid notice to configure as 'luassert'
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                }
              }
            }

            -- ELIXIR LANGUAGE SERVER
          elseif server_name == 'elixirls' then
            require("lspconfig")[server_name].setup{
              cmd = { vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh" };
            }
          elseif server_name == 'lexical' then
            require("lspconfig")[server_name].setup{
              cmd = { vim.fn.stdpath("data") .. "/mason/packages/lexical/lexical" };
            }

            -- OTHER LANGUAGE SERVER AUTO CONFIG
          else
            require("lspconfig")[server_name].setup {
              capabilities = capabilities
            }
          end
        end,
      }
    end,
  },

  --==========================[ NEOVIM LSP CONFIG ]==========================--

  -- Configure Language servers to Neovim LSP
  {
    "neovim/nvim-lspconfig",
    opts = {},
    -----------------------------------------------------[ @LSPCONFIG_CONFIG ]
    config = function()
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      -- Global mappings.
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)


      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wl', function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, opts)
          -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end,
  },
}

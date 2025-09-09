return {
  --==========================[ MASON LSP MANAGER ]==========================--

  -- Manager for language servers, linters, formatters
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = ' ',
          package_pending = ' ',
          package_uninstalled = ' ',
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
        -- Made by Microsoft employees. Adding in hopes of not being abandoned.
        "pyright",              -- Python LSP
        -- PEP-8 compliant opinionated formatter
        "black",                -- Python Formatter
        "prettier",             -- Webdev Stuff Formatter
      },
    },
  },

  --==========================[ MASON LSP CONFIG ]==========================--

  -- Configures Mason installed servers to LSPConfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      automatic_enable = true,
      ensure_installed = {},
    },

    -- Automatically configures LSP servers
    --[[ config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local custom_lsp_configs = {
        -- LUA LANGUAGE SERVER
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { 'vim', 'require' } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },

        -- ELIXIR LANGUAGE SERVER
        elixirls = {
          cmd = { vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh" },
        },

        lexical = {
          cmd = { vim.fn.stdpath("data") .. "/mason/packages/lexical/lexical" },
        },
      }

      require("mason-lspconfig").setup_handlers {
        function(server_name)
          if custom_lsp_configs[server_name] then
            -- APPLY CUSTOM CONFIG IF EXISTS
            local config = custom_lsp_configs[server_name]
            config.capabilities = capabilities
            require("lspconfig")[server_name].setup(config)
          else
            -- OTHER LANGUAGE SERVER AUTO CONFIG
            require("lspconfig")[server_name].setup {
              capabilities = capabilities,
            }
          end
        end,
      }
    end, ]]

  },

  --==========================[ NEOVIM LSP CONFIG ]==========================--

  -- Configure Language servers to Neovim LSP
  {
    "neovim/nvim-lspconfig",
    opts = {},
    -----------------------------------------------------[ @LSPCONFIG_CONFIG ]
    config = function()
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      -- Diagnostic Signs
      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
      })


      -- Global diagnostic mappings
      vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
        { desc = "Diagnostic: Prev" })
      vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
        { desc = "Diagnostic: Next" })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
        { desc = "Diagnostic: Quickfix List" })

      -- NOTE: Replaced by lsp_inline_diagnostics
      -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open Floating Diagnostic" })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, {
            buffer = ev.buf,
            desc = "LSP: Hover Docs",
          })

          vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, {
            buffer = ev.buf,
            desc = "LSP: Signature Help",
          })

          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {
            buffer = ev.buf,
            desc = "LSP: Code Action",
          })

          -- NOTE: Replaced by live-rename.nvim
          -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          -- vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)

          -- NOTE: Replaced by snacks.nvim
          -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

          -- NOTE: Replaced by conform.nvim
          -- vim.keymap.set('n', '<space>fm', function()
          --   vim.lsp.buf.format { async = true }
          -- end, opts)
        end,
      })
    end,
  },
}

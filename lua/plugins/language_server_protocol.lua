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
        "pyright",              -- Python LSP
        "black",                -- Python Formatter
        "prettier",             -- Webdev Stuff Formatter
      },
    },
  },

  --==========================[ MASON LSP CONFIG ]==========================--

  -- Configures Mason installed servers to LSPConfig
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {},
      automatic_enable = {
        exclude = {
          -- Manually enabled in nvim-lspconfig
          "lua_ls",
        }
      }
    },
  },

  --==========================[ NEOVIM LSP CONFIG ]==========================--

  -- Configure Language servers to Neovim LSP
  {
    "neovim/nvim-lspconfig",
    opts = {},
    -----------------------------------------------------[ @LSPCONFIG_CONFIG ]
    config = function()
      local lspconfig = require('lspconfig')

      -- Fix: Undefined global "vim"
      -- Source: https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                'vim',
                'require'
              },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      }

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

          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {
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

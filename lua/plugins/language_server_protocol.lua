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
    },
  },

  --==========================[ NEOVIM LSP CONFIG ]==========================--

  -- Configure Language servers to Neovim LSP
  {
    "neovim/nvim-lspconfig",
    opts = {},
    -----------------------------------------------------[ @LSPCONFIG_CONFIG ]
    config = function()
      -- Diagnostic Signs
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
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


      -- Global mappings.
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Quickfix List" })
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
          local opts = { buffer = ev.buf }
          -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wl', function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, opts)
          -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          -- vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {
            buffer = ev.buf,
            desc = "LSP: Code Action",
          })
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          -- vim.keymap.set('n', '<space>fm', function()
          --   vim.lsp.buf.format { async = true }
          -- end, opts)
        end,
      })
    end,
  },
}

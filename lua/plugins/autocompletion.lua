return{
  --=====================================================[ @COMPLETION_ENGINE ]
  -- AutoCompletion engine for external source
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local neotab = require("neotab")

      -- Load friendly snippet using LuaSnip loader
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({

        ---------------------------------------------------[ @CMP_SOURCE_LIST ]

        sources = cmp.config.sources({
          {
            name = 'luasnip',
            -- Doesn't trigger keyword/snippet completion inside string
            entry_filter = function()
              local context = require("cmp.config.context")
              return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
            end,
          },
          { name = 'nvim_lsp' },
        }, {
            { name = 'buffer' },
            { name = 'path' },
          }),

        --------------------------------------------------[ @CMP_MENU_BORDERS ]

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        ---------------------------------------------------[ @CMP_KEY_MAPPING ]

        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-e>'] = cmp.mapping(cmp.mapping.abort(), {'i', 'c'}),

          -- NEO SUPER TAB
          ["<Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              neotab.tabout()
            end
          end, { "i", "c" }),

          -- -- SUPER TAB
          -- ["<Tab>"] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_next_item()
          --   elseif luasnip.expand_or_jumpable() then
          --     luasnip.expand_or_jump()
          --   else
          --     fallback()
          --   end
          -- end, { "i", "c" }),

          -- SUPER SHIFT TAB
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "c" }),

          -- CONFIRM ONLY IF SELECTED
          ["<CR>"] = cmp.mapping(function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end, { "i", "c" }),

        }),


        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },


        -----------------------------------------------[ @CMP_MENU_FORMATTING ]
        formatting = {
          -- changing the order of fields so the icon is the first
          fields = { 'menu', 'abbr', 'kind' },
          -- here is where the change happens
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = 'λ',
              luasnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
              nvim_lua = 'Π',
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },

      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          })
      })

    end,

    dependencies = {

      --===========================================================[ @SOURCES ]
      -- LSP server source
      { "hrsh7th/cmp-nvim-lsp" },
      -- LuaSnip snippet source to configure external collections
      { 'saadparwaiz1/cmp_luasnip' },
      -- Path completion source
      { "hrsh7th/cmp-path" },
      -- Buffer completion source
      { "hrsh7th/cmp-buffer" },
      -- Commandline completion source
      { "hrsh7th/cmp-cmdline" },

      --====================================================[ @SNIPPET_ENGINE ]
      -- Snippet engine which parses custom snippets
      { 'L3MON4D3/LuaSnip' },
      -- Snippet collection for different languages
      { "rafamadriz/friendly-snippets" },

    },

  },

}

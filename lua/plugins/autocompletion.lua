local function abort_if_selected(fallback)
  local cmp = require("cmp")
  if cmp.visible() and cmp.get_active_entry() then
    cmp.abort()
  else
    fallback()
  end
end

local function confirm_if_selected(fallback)
  local cmp = require("cmp")
  if cmp.visible() and cmp.get_active_entry() then
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
  else
    fallback()
  end
end


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
      local cmp_buffer = require('cmp_buffer')

      -- Load friendly snippet using LuaSnip loader
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Get html + htmldjango completion together
      luasnip.filetype_extend("htmldjango", { "html" })

      cmp.setup({

        performance = {
          enabled = true,
          debounce = 0, -- 60ms
          throttle = 0, -- 30ms
          max_view_entries = 30,
        },

        ---------------------------------------------------[ @CMP_SOURCE_LIST ]

        sources = cmp.config.sources({
          { name = 'path' },
          {
            name = 'luasnip',
            -- Doesn't trigger keyword/snippet completion inside string
            entry_filter = function()
              local context = require("cmp.config.context")
              return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
            end,
          },
          { name = 'nvim_lsp' },
          {
            name = 'buffer',
            max_item_count = 7,
            -- Disable buffer completion on large files (e.g., > 1 MB)
            option = {
              get_bufnrs = function()
                local buf = vim.api.nvim_get_current_buf()
                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                if byte_size > 1024 * 1024 then -- 1 Megabyte max
                  return {}
                end
                return { buf }
              end,
            },
          },
        }),

        sorting = {
          comparators = {
            -- Locality bonus comparator (distance-based sorting)
            function(...) return cmp_buffer:compare_locality(...) end,
          }
        },

        --------------------------------------------------[ @CMP_MENU_BORDERS ]

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        ---------------------------------------------------[ @CMP_KEY_MAPPING ]

        mapping = cmp.mapping.preset.insert({

          -- =================[ AUTOCOMPLETION BEHAVIOURS ]================= --

          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-e>'] = cmp.mapping(cmp.mapping.abort(), {'i', 'c'}),

          -- =====================[ ITEM CONFIRMATION ]===================== --

          -- DISABLE CMP MENU (ONLY IF SELECTED)
          ["o"] = cmp.mapping(abort_if_selected,{"i","c"}),
          ["<C-o>"] = cmp.mapping(abort_if_selected,{"i","c"}),

          -- CONFIRM ITEM (ONLY IF SELECTED)
          ["i"] = cmp.mapping(confirm_if_selected,{"i","c"}),
          ["<C-i>"] = cmp.mapping(confirm_if_selected,{"i","c"}),
          ["<CR>"] = cmp.mapping(confirm_if_selected,{"i","c"}),

          -- ======================[ ITEM SELECTION ]====================== --

          -- DOWN TO SELECT NEXT ITEM
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(),{"i","c"}),

          -- UP TO SELECT PREVIOUS ITEM
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(),{"i","c"}),

          -- TAB TO JUMP SNIPPETS OR SELECT OR TABOUT
          ["<Tab>"] = cmp.mapping(function()
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            elseif cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              neotab.tabout()
            end
          end, { "i", "c" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
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
            local menu_icons = {
              nvim_lsp = 'λ',
              luasnip = '󰢱',
              buffer = '',
              path = '󰘍',
              nvim_lua = 'Π',
            }

            item.menu = menu_icons[entry.source.name]

            local kind_icons = {
              Text = ' ',
              Method = ' ',
              Function = ' ',
              Constructor = ' ',
              Field = ' ',
              Variable = ' ',
              Class = ' ',
              Interface = ' ',
              Module = ' ',
              Property = ' ',
              Unit = ' ',
              Value = ' ',
              Enum = ' ',
              Keyword = ' ',
              Snippet = ' ',
              Color = ' ',
              File = ' ',
              Reference = ' ',
              Folder = ' ',
              EnumMember = ' ',
              Constant = ' ',
              Struct = ' ',
              Event = ' ',
              Operator = ' ',
              TypeParameter = ' ',
            }

            item.kind = (kind_icons[item.kind] or '') .. item.kind

            return item
          end,

        },
      })

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

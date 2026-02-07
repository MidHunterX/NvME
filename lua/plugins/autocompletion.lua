local function abort_if_selected(fallback)
  local cmp = require("cmp")
  if cmp.visible() and cmp.get_active_entry() then
    cmp.abort()
  else
    fallback()
  end
end

-- Confirms only if user explicitly selects an item
local function confirm_if_selected(fallback)
  local cmp = require("cmp")
  if cmp.visible() and cmp.get_active_entry() then
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
  else
    fallback()
  end
end

-- Supports confirming explicit preselection by LSP
-- Confirms first item if menu is visible
local function confirm_if_menu(fallback)
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
  else
    fallback()
  end
end

-- BUGFIX: stop snippets when you leave to normal mode
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end
})

return {
  --=====================================================[ @COMPLETION_ENGINE ]
  -- AutoCompletion engine for external source
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter", "LspAttach" },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local neotab = require("neotab")
      local compare = require('cmp.config.compare')
      local cmp_buffer = require('cmp_buffer')

      local regex_source = require('cmp_regex')
      cmp.register_source('regex', regex_source)

      -- Load friendly snippet using LuaSnip loader
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Combine snippets with other filetypes
      luasnip.filetype_extend("htmldjango", { "html" })
      luasnip.filetype_extend("heex", { "html" })
      luasnip.filetype_extend("javascriptreact", { "html" })
      luasnip.filetype_extend("typescriptreact", { "html" })

      cmp.setup({
        -- Some LSPs can explicitly ask for selecting items on their own
        -- preselect = cmp.PreselectMode.None,

        performance = {
          enabled = true,
          debounce = 0, -- 60ms
          throttle = 0, -- 30ms
          max_view_entries = 30,
        },

        ---------------------------------------------------[ @CMP_SOURCE_LIST ]

        sources = cmp.config.sources({
          { name = 'regex',    priority = 69 },
          { name = 'nvim_lua', priority = 8 },
          { name = 'nvim_lsp', priority = 8 },
          {
            name = 'luasnip',
            priority = 7,
            -- Doesn't trigger keyword/snippet completion inside string
            entry_filter = function()
              local context = require("cmp.config.context")
              return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
            end,
          },
          {
            name = 'buffer',
            max_item_count = 7,
            priority = 6,
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
          {
            name = 'path',
            priority = 5,
          },
        }),


        -------------------------------------------------------[ @CMP_SORTING ]
        -- https://www.reddit.com/r/neovim/comments/u3c3kw/comment/i4p8gck/
        -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/compare.lua

        --[[ sorting = {
          comparators = {
            -- compare.score_offset, -- not good at all
            compare.locality,
            compare.recently_used,
            compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
            compare.offset,
            compare.order,
            function(entry1, entry2) -- score by lsp, if available
              local t1 = entry1.completion_item.sortText
              local t2 = entry2.completion_item.sortText
              if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
                return t1 < t2
              end
            end,
            -- compare.scopes, -- what?
            -- compare.sort_text,
            -- compare.exact,
            compare.kind,
            -- compare.length, -- useless
            -- Buffer: Locality bonus comparator (distance-based sorting)
            function(...) return cmp_buffer:compare_locality(...) end,
          }
        }, ]]

        --------------------------------------------------[ @CMP_MENU_BORDERS ]

        window = {
          -- completion = cmp.config.window.bordered(),
          completion = {
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
          },
          documentation = cmp.config.window.bordered(),
        },

        ---------------------------------------------------[ @CMP_KEY_MAPPING ]

        mapping = cmp.mapping.preset.insert({

          -- =================[ AUTOCOMPLETION BEHAVIOURS ]================= --

          ["<m-.>"] = cmp.mapping({
            i = function()
              if cmp.visible() then
                cmp.abort()
              else
                cmp.complete()
              end
            end,
            c = function()
              if cmp.visible() then
                cmp.close()
              else
                cmp.complete()
              end
            end,
          }),

          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-e>'] = cmp.mapping(cmp.mapping.abort(), { 'i', 'c' }),

          -- =====================[ ITEM CONFIRMATION ]===================== --

          -- DISABLE CMP MENU (ONLY IF SELECTED)
          ["o"] = cmp.mapping(abort_if_selected, { "i", "c" }),
          ["<C-o>"] = cmp.mapping(abort_if_selected, { "i", "c" }),

          -- CONFIRM ITEM (ONLY IF SELECTED)
          ["i"] = cmp.mapping(confirm_if_selected, { "i", "c" }),
          ["<C-i>"] = cmp.mapping(confirm_if_selected, { "i", "c" }),
          ["<CR>"] = cmp.mapping(confirm_if_selected, { "i", "c" }),

          -- ======================[ ITEM SELECTION ]====================== --

          -- DOWN TO SELECT NEXT ITEM
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),

          -- UP TO SELECT PREVIOUS ITEM
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),

          -- SUPER TAB
          -- Jumps to next snippet field if snippet is expanded
          -- Selects first item or LSP preselected item if menu is visible
          -- Else, tab out with fallbacks
          ["<Tab>"] = cmp.mapping(function()
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            elseif cmp.visible() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
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
          fields = { 'menu', 'abbr', 'kind' },

          format = function(entry, item)
            local menu_icons = {
              nvim_lsp = 'λ',
              luasnip = '󰯁',
              buffer = '',
              path = '󰘍',
              nvim_lua = 'Π',
            }

            item.menu = menu_icons[entry.source.name]

            -- Placed here as path only needs source and icon
            if vim.tbl_contains({ 'path' }, entry.source.name) then
              local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
              if icon then
                item.kind = icon .. ' ' .. item.kind
                item.kind_hl_group = hl_group
                return item
              end
            end

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

            -- CUSTOM TREESITTER BASED COLORFUL CMP MENU
            local highlights_info = require("colorful-menu").cmp_highlights(entry)
            if highlights_info ~= nil then
              item.abbr_hl_group = highlights_info.highlights
              item.abbr = highlights_info.text
            end

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
      -- Nvim lua api source
      { "hrsh7th/cmp-nvim-lua" },
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
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
      },
      -- Snippet collection for different languages
      { "rafamadriz/friendly-snippets" },

    },

  },

}

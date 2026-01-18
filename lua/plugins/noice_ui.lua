return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {

    presets = {
      bottom_search = false,        -- classic bottom cmdline for search
      command_palette = true,       -- position the cmdline and popupmenu
      long_message_to_split = true, -- long messages will be sent to a split
      lsp_doc_border = true,        -- add a border to hover docs
      inc_rename = true,            -- input dialog for inc-rename.nvim
    },

    cmdline = {
      enabled = true,
      view = "cmdline_popup", -- cmdline, cmdline_popup
      format = {
        cmdline = { icon = "" },
        search_down = { icon = " " },
        search_up = { icon = " " },
        filter = { icon = "$" },
        lua = { icon = "" },
        help = { icon = "" },
      },
    },

    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages",
      view_search = false, -- false, "virtualtext"
    },

    popupmenu = {
      enabled = false,
      ---@type 'nui'|'cmp'
      backend = "nui",
    },

    lsp = {
      progress = {
        enabled = true,
        view = "mini",
      },
      -- override markdown rendering so cmp and other plugins use Treesitter
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
      message = {
        enabled = false,
        view = "notify",
        opts = {},
      },
    },

    health = {
      checker = false,
    },

    routes = {

      --[[ { -- Show @recording messages
        view = "notify",
        filter = {
          event = "msg_showmode",
          find = "recording",
        },
      }, ]]

    },

  },

  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify", -- Disabled bc of popup notifs
  }
}

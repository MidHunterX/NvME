return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {

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

    lsp = {
      -- override markdown rendering so cmp and other plugins use Treesitter
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },

    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },

  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify", -- Disabled bc of popup notifs
  }
}

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()

    local non_highlight = {
      "NonHighlight1",
      "NonHighlight2",
      "NonHighlight3",
      "NonHighlight4",
    }

    local highlight = {
      "Highlight1",
      "Highlight2",
      "Highlight3",
      "Highlight4",
    }

    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()

      vim.api.nvim_set_hl(0, "NonHighlight1", {fg="#65661a"})
      vim.api.nvim_set_hl(0, "NonHighlight2", {fg="#643266"})
      vim.api.nvim_set_hl(0, "NonHighlight3", {fg="#164a66"})
      vim.api.nvim_set_hl(0, "NonHighlight4", {fg="#336633"})

      vim.api.nvim_set_hl(0, "Highlight1", {fg="#c9cc33"})
      vim.api.nvim_set_hl(0, "Highlight2", {fg="#c964cc"})
      vim.api.nvim_set_hl(0, "Highlight3", {fg="#2d94cc"})
      vim.api.nvim_set_hl(0, "Highlight4", {fg="#66cc66"})

    end)

    require("ibl").setup {
      scope = {
        highlight = highlight
      },
      indent = {
        highlight = non_highlight
      },
    }
  end
}

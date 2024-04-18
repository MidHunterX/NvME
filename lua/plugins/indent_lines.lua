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

      vim.api.nvim_set_hl(0, "NonHighlight1", {fg="#797a1f"})
      vim.api.nvim_set_hl(0, "NonHighlight2", {fg="#864389"})
      vim.api.nvim_set_hl(0, "NonHighlight3", {fg="#247aa8"})
      vim.api.nvim_set_hl(0, "NonHighlight4", {fg="#448844"})

      vim.api.nvim_set_hl(0, "Highlight1", {fg="#d4d65c"})
      vim.api.nvim_set_hl(0, "Highlight2", {fg="#d78cd9"})
      vim.api.nvim_set_hl(0, "Highlight3", {fg="#82c1e3"})
      vim.api.nvim_set_hl(0, "Highlight4", {fg="#8cd98c"})

    end)

    vim.g.rainbow_delimiters = { highlight = highlight }

    require("ibl").setup {
      scope = {
        highlight = highlight
      },
      indent = {
        highlight = non_highlight
      },
      exclude = {
        filetypes = { "terminal", 'nofile', 'quickfix', 'dashboard' }
      },
    }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

  end
}

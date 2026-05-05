return {
  'andymass/vim-matchup',
  init = function()
    -- perf: lines to search for highlighting
    vim.g.matchup_treesitter_stopline = 69
    -- fix: lualine statusline flicker
    vim.g.matchup_matchparen_offscreen = {}
    -- fix: nvim-cmp lsp entry getting autoselected
    vim.g.matchup_matchparen_pumvisible = 0

    -- feat: auto edit closing tags just by normal editing
    vim.g.matchup_transmute_enabled = 1

    -- feat: highlight tags only
    vim.g.matchup_matchpref = {
      html = { tagnameonly = 1 }
    }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "htmldjango", "django", "twig", "eruby" },
      callback = function()
        vim.b.match_words = vim.fn["matchup#util#standard_html"]()
      end,
    })
  end,
}

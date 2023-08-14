return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    ------------------------- NON HIGHLIGHTED INDENTS -------------------------
    vim.cmd [[highlight IndentBlanklineIndent1 guifg=#65661a gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent2 guifg=#643266 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent3 guifg=#164a66 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent4 guifg=#336633 gui=nocombine]]

    --------------------------- HIGHLIGHTED INDENTS ---------------------------
    vim.cmd([[highlight IndentContext1 guifg=#c9cc33 gui=nocombine]])
    vim.cmd([[highlight IndentContext2 guifg=#c964cc gui=nocombine]])
    vim.cmd([[highlight IndentContext3 guifg=#2d94cc gui=nocombine]])
    vim.cmd([[highlight IndentContext4 guifg=#66cc66 gui=nocombine]])

    require("indent_blankline").setup {
      -- char = "│",
      -- char_blankline = "╎", -- │ | ╎ ¦ ┆ ┊ └
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
      },
      context_highlight_list = {
        "IndentContext1",
        "IndentContext2",
        "IndentContext3",
        "IndentContext4",
      },
      strict_tabs = true,
      use_treesitter = true,
      show_current_context = true,
      show_current_context_start = true,
      show_trailing_blankline_indent = false,
      buftype_exclude = { "terminal", 'nofile', 'quickfix' },
      filetype_exclude = { "dashboard", "NvimTree", "packer", "lsp-installer" },
      context_patterns = {
        "class", "return", "function", "method", "^if", "^while", "^for",
        "^table", "try_statement", "if_statement", "import_statement",
        "arguments",


        --------------------------[ PATTERN FILTER ]--------------------------
        -- "^object", "block", "jsx_element", "jsx_self_closing_element",
        -- "else_clause", "catch_clause", "operation_type",
        --
        --------------------------[ PATTERN BACKUP ]--------------------------
        -- "class", "return", "function", "method", "^if", "^while", "jsx_element",
        -- "^for", "^object", "^table", "block", "arguments", "if_statement",
        -- "else_clause", "jsx_element", "jsx_self_closing_element",
        -- "try_statement", "catch_clause", "import_statement", "operation_type"
      },
    }
  end
}

-- Fastest and most optimized indent plugin ever
-- return {
--   'nvimdev/indentmini.nvim',
--   event = 'BufEnter',
--   config = function()
--     require("indentmini").setup({
--       char = "│",
--       exclude = {
--         "erlang",
--         "markdown",
--       }
--     })
--     -- use comment color
--     vim.cmd.highlight("default link IndentLine Comment")
--   end,
-- }

local picker       = true
local explorer     = true
local quickfile    = true
local statuscolumn = false
local indent       = false

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
    { "<leader>,",       function() Snacks.picker.buffers() end,               desc = "Find: Buffers" },
    { "<leader>/",       function() Snacks.picker.grep() end,                  desc = "Grep: Files" },
    { "<leader>:",       function() Snacks.picker.command_history() end,       desc = "Command History" },
    { "<leader>n",       function() Snacks.picker.notifications() end,         desc = "Notification History" },
    { "<leader>ex",      function() Snacks.explorer() end,                     desc = "File Explorer (Side)" },
    -- find
    { "<leader>ff",      function() Snacks.picker.files() end,                 desc = "Find: Files" },
    { "<leader>fb",      function() Snacks.picker.buffers() end,               desc = "Find: Buffers" },
    { "<leader>fg",      function() Snacks.picker.git_files() end,             desc = "Find: Git Files" },
    { "<leader>fp",      function() Snacks.picker.projects() end,              desc = "Find: Projects" },
    { "<leader>fr",      function() Snacks.picker.recent() end,                desc = "Find: Recent" },
    -- Grep
    { "<leader>gg",      function() Snacks.picker.grep() end,                  desc = "Grep: Files" },
    { "<leader>sf",      function() Snacks.picker.grep() end,                  desc = "Grep: Files" },
    { "<leader>sb",      function() Snacks.picker.lines() end,                 desc = "Grep: Buffer Lines" },
    { "<leader>sB",      function() Snacks.picker.grep_buffers() end,          desc = "Grep: Open Buffers" },
    { "<leader>sw",      function() Snacks.picker.grep_word() end,             desc = "Grep: Word" },
    -- undo
    { "<leader>u",       function() Snacks.picker.undo() end,                  desc = "Grep: Undo Tree" },
    { "<leader>su",      function() Snacks.picker.undo() end,                  desc = "Grep: Undo Tree" },
    -- git
    { "<leader>gc",      function() Snacks.lazygit.open() end,                 desc = "Git: LazyGit (Commit)" },
    { "<leader>gb",      function() Snacks.picker.git_branches() end,          desc = "Git: Branches" },
    { "<leader>gl",      function() Snacks.picker.git_log() end,               desc = "Git: Log" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,            desc = "Git: Status" },
    { "<leader>gd",      function() Snacks.picker.git_diff() end,              desc = "Git: Diff (Hunks)" },
    -- lsp
    { "gd",              function() Snacks.picker.lsp_definitions() end,       desc = "LSP: Goto Definition" },
    { "gD",              function() Snacks.picker.lsp_declarations() end,      desc = "LSP: Goto Declaration" },
    { "gr",              function() Snacks.picker.lsp_references() end,        desc = "LSP: References" },
    { "gI",              function() Snacks.picker.lsp_implementations() end,   desc = "LSP: Goto Implementation" },
    { "gy",              function() Snacks.picker.lsp_type_definitions() end,  desc = "LSP: Goto T[y]pe Definition" },
    { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,           desc = "LSP: Symbols" },
    { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP: Workspace Symbols" },
  },
  opts = {
    -- bigfile = { enabled = bigfile },
    -- dashboard = { enabled = dashboard },
    -- input = { enabled = input },
    -- notifier = { enabled = notifier },
    -- scope = { enabled = scope },
    -- scroll = { enabled = scroll }, -- It's so janky and limits your speed
    -- words = { enabled = words },   -- No use for it yet


    -- █▀█ █ █▀▀ █▄▀ █▀▀ █▀█
    -- █▀▀ █ █▄▄ █░█ ██▄ █▀▄

    -- Positives
    -- 1. Hell lotta stuff bro
    -- 2. Wayyy better token highlighting than telescope

    picker = {
      enabled = picker,
      focus = "input", --"input"|"list" (defaults to "input")
      win = {
        input = {
          keys = {
            ["x"] = "close",
          }
        },
        list = {
          keys = {
            ["x"] = "close",
          }
        }
      }
    },


    -- █▀ ▀█▀ ▄▀█ ▀█▀ █░█ █▀ █▀▀ █▀█ █░░ █░█ █▀▄▀█ █▄░█
    -- ▄█ ░█░ █▀█ ░█░ █▄█ ▄█ █▄▄ █▄█ █▄▄ █▄█ █░▀░█ █░▀█

    -- Negatives
    -- 1. Adds one more column after numberline which adds slight bulk

    -- Positives
    -- 1. Solves the issue of not showing git signs and LSP diagnostics at the same time
    -- 2. Even though it adds one more column, it's pretty neat tho.

    -- WARN: Conclusion: Love it! Disabled for now.
    -- Will be useful after I use folds in my workflow

    statuscolumn = {
      enabled = statuscolumn,
      left = { "mark", "sign" }, -- priority of signs on the left
      right = { "fold", "git" }, -- priority of signs on the right
      folds = {
        open = false,            -- show open fold icons
        git_hl = true,           -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 100, -- refresh at most every 50ms
    },


    -- █ █▄░█ █▀▄ █▀▀ █▄░█ ▀█▀
    -- █ █░▀█ █▄▀ ██▄ █░▀█ ░█░

    -- Negatives
    -- 1. Scope using Treesitter doesn't work
    -- 2. Default indent opts.indent.char doesn't work
    -- 3. indent-blankline have full scope outlining

    -- Positives
    -- 1. Breezy Animations
    -- 2. Sits well with rainbow brackets

    -- WARN: Conclusion: Use indent-blankline instead

    indent = {
      priority = 1,
      enabled = indent,
      char = "│",
      scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 200,
        char = "│", -- ▎ ▍ │
        underline = false, -- underline the start of the scope
        only_scope = false, -- only show indent guides of the scope
        hl = {
          "RainbowBracket1",
          "RainbowBracket2",
          "RainbowBracket3",
          "RainbowBracket4",
        },
      },
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        style = "out", -- "out"|"up_down"|"down"|"up"
        easing = "linear",
        duration = {
          step = 20,   -- ms per step
          total = 400, -- maximum duration
        },
      },
    },


    -- █▀▀ ▀▄▀ █▀█ █░░ █▀█ █▀█ █▀▀ █▀█
    -- ██▄ █░█ █▀▀ █▄▄ █▄█ █▀▄ ██▄ █▀▄

    -- Positives
    -- 1. Acts as a side bar file picker with fuzzy finding
    -- 2. Shows LSP diagnostics for all files in the project
    -- 3. Shows Git status for all files in the project

    explorer = {
      enabled = explorer,
      replace_netrw = true,
    },


    -- █▀█ █░█ █ █▀▀ █▄▀ █▀▀ █ █░░ █▀▀
    -- ▀▀█ █▄█ █ █▄▄ █░█ █▀░ █ █▄▄ ██▄

    -- Positives
    -- 1. Fastest File in the West
    -- 2. Quickly loads file before loading plugins

    quickfile = {
      enabled = quickfile,
      exclude = { "latex" },
    },

  },
}

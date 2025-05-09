local picker       = true
local quickfile    = true
local statuscolumn = true
local notifier     = true
local bigfile      = false
local scroll       = false
local indent       = false
local dashboard    = false
local words        = false
-- Custom Functions
local sidebar      = false -- Open explorer on startup

local function toggle_terminal()
  if vim.bo.buftype == "terminal" then
    vim.cmd("hide")
  else
    Snacks.terminal.toggle("fish")
  end
end

local function quit_with_explorer()
  local explorer = Snacks.picker.get({ source = "explorer" })
  if #explorer == 0 then
    for _, p in pairs(explorer) do
      p:close()
    end
  end
  vim.cmd("wqa")
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  init = function()
    local function AutostartSidebar(something)
      if not something then return end
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          Snacks.explorer.open()
        end,
      })
    end
    AutostartSidebar(sidebar)
  end,

  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
    { "<leader>,",       function() Snacks.picker.buffers() end,               desc = "Find: Buffers" },
    { "<leader>/",       function() Snacks.picker.grep() end,                  desc = "Grep: Files" },
    { "<leader>:",       function() Snacks.picker.command_history() end,       desc = "Command History" },
    { "<leader>us",      function() Snacks.explorer() end,                     desc = "Toggle: Sidebar" },
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
    { "<leader>su",      function() Snacks.picker.undo() end,                  desc = "Grep: Undo History Tree" },
    { "<leader>sn",      function() Snacks.picker.notifications() end,         desc = "Grep: Notification History" },
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
    { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,           desc = "Grep: LSP Symbols" },
    { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end, desc = "Grep: LSP Workspace Symbols" },
    -- buffer
    -- Snacks.bufdelete keeps the split open but delete the buffer (:bd is better for my workflow)
    -- But Snacks.bufdelete is needed for not affecting the explorer as it is technically a split buffer
    { "<leader>x",       function() Snacks.bufdelete.delete() end,             desc = "Buffer: Close" },
    { "<leader>X",       function() Snacks.bufdelete.all() end,                desc = "Buffer: Close All" },
    { "]]",              function() Snacks.words.jump(vim.v.count1) end,       desc = "Next Reference" },
    { "[[",              function() Snacks.words.jump(-vim.v.count1) end,      desc = "Prev Reference" },
    {
      "<leader>uw",
      function()
        if Snacks.words.is_enabled() then
          Snacks.words.disable()
        else
          Snacks.words.enable()
        end
      end,
      desc = "Toggle: Words (LSP)",
    },
    { "<m-/>", toggle_terminal, desc = "Toggle: Terminal",        mode = { "n", "t" } },
    { "<m-_>", toggle_terminal, desc = "Toggle: Terminal (TMUX)", mode = { "n", "t" } },
    -- HACK: Fixes issue temporarily with Explorer not closing properly on ZZ
    {
      "ZZ",
      quit_with_explorer,
      desc = "Close All (including Explorer)"
    },
  },

  opts = {
    -- input = { enabled = input },
    -- scope = { enabled = scope },


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
      },
      sources = {

        -- █▀▀ ▀▄▀ █▀█ █░░ █▀█ █▀█ █▀▀ █▀█
        -- ██▄ █░█ █▀▀ █▄▄ █▄█ █▀▄ ██▄ █▀▄

        -- Positives
        -- 1. Acts as a side bar file picker with fuzzy finding
        -- 2. Shows LSP diagnostics for all files in the project
        -- 3. Shows Git status for all files in the project

        explorer = {
          focus = false,
          layout = {
            layout = {
              -- width = 0.2,       -- fixed percentage width
              position = "left", -- default "left"
            },
            hidden = { "input" },
            auto_hide = { "input" },
          }
        },
      },

      ---@class snacks.picker.icons
      icons = {
        tree = {
          vertical = "│ ",
          middle   = "├╴",
          last     = "╰╴",
        },
        git = {
          staged    = "",
          modified  = "",
          renamed   = "",
          untracked = "?",
        },
      },
    },


    -- █▀ ▀█▀ ▄▀█ ▀█▀ █░█ █▀ █▀▀ █▀█ █░░ █░█ █▀▄▀█ █▄░█
    -- ▄█ ░█░ █▀█ ░█░ █▄█ ▄█ █▄▄ █▄█ █▄▄ █▄█ █░▀░█ █░▀█

    -- Negatives
    -- 1. Adds one more column after numberline which adds slight bulk

    -- Positives
    -- 1. Solves the issue of not showing git signs and LSP diagnostics at the same time
    -- 2. Even though it adds one more column, it's pretty neat tho.

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

    -- Conclusion: Use indent-blankline for now

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


    -- █▀▄ ▄▀█ █▀ █░█ █▄▄ █▀█ ▄▀█ █▀█ █▀▄
    -- █▄▀ █▀█ ▄█ █▀█ █▄█ █▄█ █▀█ █▀▄ █▄▀

    -- Negatives
    -- 1. Not that customizable.. (single line key section)

    -- Positives
    -- 1. Advanced multi panel layout
    -- 2. Responsive UI

    -- Conclusion: Use dashboard-nvim for now

    dashboard = {
      enabled = dashboard,
      sections = {
        { section = "header" },
        { section = "keys",  gap = 0, padding = 1 },
        {
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          indent = 3,
          padding = { 2, 0 },
        },
        { section = "startup" },
      },
    },


    -- █▀ █▀▀ █▀█ █▀█ █░░ █░░
    -- ▄█ █▄▄ █▀▄ █▄█ █▄▄ █▄▄

    -- Negatives
    -- 1. Not fast enough for my workflow even after lowering numbers drastically

    scroll = {
      enabled = scroll,
      animate = {
        duration = { step = 2, total = 20 },
        easing = "linear",
      },
      animate_repeat = {
        duration = { step = 1, total = 10 },
        easing = "linear",
      },
      -- Prevents activation on terminal
      -- Prevents activation until half page jump and next half page jump
      filter = function(buf)
        local cursor_line = vim.fn.line(".")
        local half_page = vim.fn.winheight(0) / 2
        local half_jump = half_page / 2
        local disabled_lines = half_page + half_jump - 1
        return vim.g.snacks_scroll ~= false
            and vim.b[buf].snacks_scroll ~= false
            and vim.bo[buf].buftype ~= "terminal"
            and cursor_line > disabled_lines
      end,
    },


    -- █▄▄ █ █▀▀ █▀▀ █ █░░ █▀▀
    -- █▄█ █ █▄█ █▀░ █ █▄▄ ██▄

    -- Negatives
    -- 1. Premature so, no out of the box configs like faster.nvim/bigfile.nvim

    bigfile = {
      enabled = bigfile,
      notify = true,
      size = 1 * 1024 * 1024, -- 1MB
      line_length = 3000,
      ---@param ctx {buf: number, ft:string}
      setup = function(ctx)
        -- matchparen
        if vim.fn.exists(":NoMatchParen") ~= 0 then
          vim.cmd([[NoMatchParen]])
        end
        -- lsp
        if vim.fn.exists(":LspStop") ~= 0 then
          vim.cmd([[LspStop]])
        end
        -- treesitter
        if vim.fn.exists(":TSBufDisable") ~= 0 then
          vim.cmd([[TSBufDisable all]])
        end
        -- syntax
        vim.cmd "syntax clear"
        vim.opt_local.syntax = "OFF"
        -- filetype
        vim.opt_local.filetype = ""
        -- winopts
        Snacks.util.wo(0, {
          swapfile = false,
          foldmethod = "manual",
          statuscolumn = "",
          conceallevel = 0,
          undolevels = -1,
          undoreload = 0,
          list = false
        })
        vim.b.minianimate_disable = true
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(ctx.buf) then
            vim.bo[ctx.buf].syntax = ctx.ft
          end
        end)
      end,
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


    -- ▀█▀ █▀▀ █▀█ █▀▄▀█ █ █▄░█ ▄▀█ █░░
    -- ░█░ ██▄ █▀▄ █░▀░█ █ █░▀█ █▀█ █▄▄

    terminal = {
      win = {
        border = "rounded", -- single | rounded | double | solid | shadow | none
        resize = true,
        position = "float", -- "bottom"|"float"|"left"|"right"|"top"
      }
    },


    -- █░░ ▄▀█ ▀█ █▄█ █▀▀ █ ▀█▀
    -- █▄▄ █▀█ █▄ ░█░ █▄█ █ ░█░

    lazygit = {
      configure = false, -- apply colorscheme to lazygit
      win = {
        border = "rounded",
        width = 0,
        height = 0,
      },
    },


    -- █░█░█ █▀█ █▀█ █▀▄ █▀
    -- ▀▄▀▄▀ █▄█ █▀▄ █▄▀ ▄█

    words = {
      enabled = words,
      debounce = 100,  -- time in ms to wait before updating
      modes = { "n" }, -- default { "n", "i", "c" }
    },


    -- █▄░█ █▀█ ▀█▀ █ █▀▀ █▄█
    -- █░▀█ █▄█ ░█░ █ █▀░ ░█░

    -- Positives
    -- 1. Works best in tandem with Noice.nvim lsp messages on bottom

    notifier = {
      enabled = notifier,
      timeout = 3000, -- default timeout in ms
      ---@type "minimal" | "compact" | "fancy"
      style = "compact",
      top_down = true, -- place notifications from top to bottom
      refresh = 100,   -- default 50
    },
  },
}

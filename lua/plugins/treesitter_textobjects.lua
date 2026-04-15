return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter", branch = "main" },
  init = function()
    vim.g.no_plugin_maps = true
  end,
  config = function()
    require("nvim-treesitter-textobjects").setup {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')

        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V',  -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        include_surrounding_whitespace = false,
      },
      move = {
        -- whether to set jumps in the jumplist
        set_jumps = true,
      },
    }

    -- █▀ █▀▀ █░░ █▀▀ █▀▀ ▀█▀
    -- ▄█ ██▄ █▄▄ ██▄ █▄▄ ░█░
    -- (i)nner and (a)round

    local select = require "nvim-treesitter-textobjects.select"

    -- ==================== [ FUNCTION/METHOD ] ==================== --

    vim.keymap.set({ "x", "o" }, "im", function()
      select.select_textobject("@function.inner", "textobjects")
    end, { desc = 'method' })

    vim.keymap.set({ "x", "o" }, "am", function()
      select.select_textobject("@function.outer", "textobjects")
    end, { desc = 'method' })

    vim.keymap.set({ "x", "o" }, "if", function()
      select.select_textobject("@function.inner", "textobjects")
    end, { desc = 'function' })

    vim.keymap.set({ "x", "o" }, "af", function()
      select.select_textobject("@function.outer", "textobjects")
    end, { desc = 'function' })

    -- ========================= [ CLASS ] ========================= --

    vim.keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject("@class.inner", "textobjects")
    end, { desc = 'class' })

    vim.keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject("@class.outer", "textobjects")
    end, { desc = 'class' })

    -- ========================= [ LOOPS ] ========================= --

    vim.keymap.set({ "x", "o" }, "il", function()
      select.select_textobject("@loop.outer", "textobjects")
    end, { desc = 'loop' })

    vim.keymap.set({ "x", "o" }, "al", function()
      select.select_textobject("@loop.outer", "textobjects")
    end, { desc = 'loop' })

    -- ====================== [ CONDITIONAL ] ====================== --

    vim.keymap.set({ "x", "o" }, "ii", function()
      select.select_textobject("@conditional.outer", "textobjects")
    end, { desc = 'conditional' })

    vim.keymap.set({ "x", "o" }, "ai", function()
      select.select_textobject("@conditional.outer", "textobjects")
    end, { desc = 'conditional' })

    -- ======================= [ ARGUMENTS ] ======================= --

    vim.keymap.set({ "x", "o" }, "ia", function()
      select.select_textobject("@parameter.outer", "textobjects")
    end, { desc = 'argument' })

    vim.keymap.set({ "x", "o" }, "aa", function()
      select.select_textobject("@parameter.outer", "textobjects")
    end, { desc = 'argument' })

    -- ====================== [ ASSIGNMENTS ] ====================== --

    vim.keymap.set({ "x", "o" }, "i=", function()
      select.select_textobject("@assignment.lhs", "textobjects")
    end, { desc = 'assignment' })

    vim.keymap.set({ "x", "o" }, "a=", function()
      select.select_textobject("@assignment.rhs", "textobjects")
    end, { desc = 'assignment' })

    -- works for javascript/typescript files
    vim.keymap.set({ "x", "o" }, "i:", function()
      select.select_textobject("@property.lhs", "textobjects")
    end, { desc = 'property' })

    vim.keymap.set({ "x", "o" }, "a:", function()
      select.select_textobject("@property.rhs", "textobjects")
    end, { desc = 'property' })

    -- You can also use captures from other query groups like `locals.scm`
    vim.keymap.set({ "x", "o" }, "as", function()
      select.select_textobject("@local.scope", "locals")
    end, { desc = 'scope' })

    -- █▀ █░█░█ ▄▀█ █▀█
    -- ▄█ ▀▄▀▄▀ █▀█ █▀▀
    -- (n)ext and (p)revious

    local swap = require("nvim-treesitter-textobjects.swap")
    vim.keymap.set("n", "<leader>a", function()
      swap.swap_next "@parameter.inner"
    end, { desc = 'swap argument' })
    vim.keymap.set("n", "<leader>A", function()
      swap.swap_previous "@parameter.outer"
    end, { desc = 'swap argument' })

    -- █▀▄▀█ █▀█ █░█ █▀▀
    -- █░▀░█ █▄█ ▀▄▀ ██▄

    local move = require("nvim-treesitter-textobjects.move")

    -- ==================== [ FUNCTION/METHOD ] ==================== --

    vim.keymap.set({ "n", "x", "o" }, "]f", function()
      move.goto_next_start("@function.outer", "textobjects")
    end, { desc = 'function' })
    vim.keymap.set({ "n", "x", "o" }, "]F", function()
      move.goto_next_end("@function.outer", "textobjects")
    end, { desc = 'function end' })

    vim.keymap.set({ "n", "x", "o" }, "]m", function()
      move.goto_next_start("@function.outer", "textobjects")
    end, { desc = 'method' })
    vim.keymap.set({ "n", "x", "o" }, "]M", function()
      move.goto_next_end("@function.outer", "textobjects")
    end, { desc = 'method end' })

    -- ========================= [ CLASS ] ========================= --

    vim.keymap.set({ "n", "x", "o" }, "]c", function()
      move.goto_next_start("@class.outer", "textobjects")
    end, { desc = 'class' })
    vim.keymap.set({ "n", "x", "o" }, "]C", function()
      move.goto_next_end("@class.outer", "textobjects")
    end, { desc = 'class end' })

    -- ========================= [ LOOPS ] ========================= --

    vim.keymap.set({ "n", "x", "o" }, "]l", function()
      move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
    end, { desc = 'loop' })
    vim.keymap.set({ "n", "x", "o" }, "]L", function()
      move.goto_next_end("@loop.outer", "textobjects")
    end, { desc = 'loop end' })

    -- ====================== [ CONDITIONAL ] ====================== --

    vim.keymap.set({ "n", "x", "o" }, "]i", function()
      move.goto_next_start("@conditional.outer", "textobjects")
    end, { desc = 'conditional' })
    vim.keymap.set({ "n", "x", "o" }, "]I", function()
      move.goto_next_end("@conditional.outer", "textobjects")
    end, { desc = 'conditional end' })

    -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
    vim.keymap.set({ "n", "x", "o" }, "]s", function()
      move.goto_next_start("@local.scope", "locals")
    end, { desc = 'scope' })
    vim.keymap.set({ "n", "x", "o" }, "]z", function()
      move.goto_next_start("@fold", "folds")
    end, { desc = 'fold' })

    -- Go to either the start or the end, whichever is closer.
    -- Use if you want more granular movements
    -- vim.keymap.set({ "n", "x", "o" }, "]d", function()
    --   move.goto_next("@conditional.outer", "textobjects")
    -- end)
    -- vim.keymap.set({ "n", "x", "o" }, "[d", function()
    --   move.goto_previous("@conditional.outer", "textobjects")
    -- end)


    -- █▀█ █▀▀ █▀█ █▀▀ ▄▀█ ▀█▀   █▀▄▀█ █▀█ █░█ █▀▀
    -- █▀▄ ██▄ █▀▀ ██▄ █▀█ ░█░   █░▀░█ █▄█ ▀▄▀ ██▄

    local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

    -- vim way: ; goes to the direction you were moving.
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)


    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    -- WARN: Disabling bc this conflicts and breaks flash.nvim f/t motions

    -- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    -- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    -- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    -- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}

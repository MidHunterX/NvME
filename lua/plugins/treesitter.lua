return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- ZIG is more compatible with windows :D
    -- GCC for linux as it's built in

    require 'nvim-treesitter.install'.compilers = { 'gcc', 'zig' }

    require 'nvim-treesitter.configs'.setup {

      -- ▀█▀ █▀█ █▀▀ █▀▀ █▀ █ ▀█▀ ▀█▀ █▀▀ █▀█   █▀█ ▄▀█ █▀█ █▀ █▀▀ █▀█
      -- ░█░ █▀▄ ██▄ ██▄ ▄█ █ ░█░ ░█░ ██▄ █▀▄   █▀▀ █▀█ █▀▄ ▄█ ██▄ █▀▄
      -- =============================================================

      ensure_installed = {
        "bash",
        "c",
        "css",
        "gitignore",
        "html",
        "java",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "zathurarc",
      },
      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
        -- NOTE: enabling indentation significantly slows down editing in Dart files
        disable = { "yaml", "dart" }
      },

      modules = {},
      ignore_install = {},
      incremental_selection = {
        -------------------------------------------- [ Enables on Normal mode ]
        -- NOTE: Replaced by flash.nvim "treesitter()"
        enable = false,
        --[[ keymaps = {
          init_selection = '<C-k>',
          node_incremental = '<C-k>',
          node_decremental = '<C-j>',
          scope_incremental = '<C-h>',
        }, ]]
      },


      -- ▀█▀ █▀▀ ▀▄▀ ▀█▀   █▀█ █▄▄ ░░█ █▀▀ █▀▀ ▀█▀ █▀
      -- ░█░ ██▄ █░█ ░█░   █▄█ █▄█ █▄█ ██▄ █▄▄ ░█░ ▄█
      -- ============================================

      textobjects = {

        -- █▀ █▀▀ █░░ █▀▀ █▀▀ ▀█▀
        -- ▄█ ██▄ █▄▄ ██▄ █▄▄ ░█░
        -- (i)nner and (a)round

        select = {
          enable = true,
          lookahead = true,
          include_surrounding_whitespace = false,

          keymaps = {

            -- ====================== [ ASSIGNMENTS ] ====================== --

            -- You can use the capture groups defined in textobjects.scm
            ["i="] = {
              query = "@assignment.lhs",
              desc = "Select LHS of Assignment"
            },
            ["a="] = {
              query = "@assignment.rhs",
              desc = "Select RHS of Assignment"
            },

            -- works for javascript/typescript files
            ["i:"] = {
              query = "@property.lhs",
              desc = "Select LHS of an object property"
            },
            ["a:"] = {
              query = "@property.rhs",
              desc = "Select RHS of an object property"
            },

            -- ======================= [ ARGUMENTS ] ======================= --

            ["ia"] = {
              query = "@parameter.inner",
              desc = "Select inside Parameter/Argument"
            },
            ["aa"] = {
              query = "@parameter.outer",
              desc = "Select around Parameter/Argument"
            },

            -- ====================== [ CONDITIONAL ] ====================== --

            ["ai"] = {
              query = "@conditional.outer",
              desc = "Select around Conditional"
            },
            ["ii"] = {
              query = "@conditional.inner",
              desc = "Select inside Conditional"
            },

            -- ========================= [ LOOPS ] ========================= --

            ["il"] = {
              query = "@loop.inner",
              desc = "Select inside Loop"
            },
            ["al"] = {
              query = "@loop.outer",
              desc = "Select around Loop"
            },

            -- ==================== [ FUNCTION/METHOD ] ==================== --

            ["if"] = {
              query = "@function.inner",
              desc = "Select inside Function"
            },
            ["af"] = {
              query = "@function.outer",
              desc = "Select around Function"
            },
            ["im"] = {
              query = "@function.inner",
              desc = "Select inside Method"
            },
            ["am"] = {
              query = "@function.outer",
              desc = "Select around Method"
            },

            -- ========================= [ CLASS ] ========================= --

            ["ic"] = {
              query = "@class.inner",
              desc = "Select inside Class"
            },
            ["ac"] = {
              query = "@class.outer",
              desc = "Select around Class"
            },

          },

          selection_modes = {
            -- charwise 'v' linewise 'V' blockwise '<c-v>'
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = 'V',
          },

        },


        -- █▀ █░█░█ ▄▀█ █▀█
        -- ▄█ ▀▄▀▄▀ █▀█ █▀▀
        -- (n)ext and (p)revious

        swap = {
          enable = true,

          swap_next = {
            ["<leader>na"] = "@parameter.inner", -- swap parame/arg with next
            ["<leader>n:"] = "@property.outer",  -- swap obj property with next
            ["<leader>nm"] = "@function.outer",  -- swap function with next
          },

          swap_previous = {
            ["<leader>pa"] = "@parameter.inner", -- swap param/arg with prev
            ["<leader>p:"] = "@property.outer",  -- swap obj property with prev
            ["<leader>pm"] = "@function.outer",  -- swap function with previous
          },

        },


        -- █▀▄▀█ █▀█ █░█ █▀▀
        -- █░▀░█ █▄█ ▀▄▀ ██▄

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist

          goto_next_start = {
            ["]f"] = {
              query = "@function.outer",
              desc = "Next Function start"
            },
            ["]m"] = {
              query = "@function.outer",
              desc = "Next Method start"
            },
            ["]c"] = {
              query = "@class.outer",
              desc = "Next Class start"
            },
            ["]i"] = {
              query = "@conditional.outer",
              desc = "Next Conditional start"
            },
            ["]l"] = {
              query = "@loop.outer",
              desc = "Next Loop start"
            },
            ["]s"] = {
              query = "@scope", query_group = "locals",
              desc = "Next Scope"
            },
            ["]z"] = {
              query = "@fold", query_group = "folds",
              desc = "Next Fold"
            },
          },

          goto_next_end = {
            ["]F"] = {
              query = "@function.outer",
              desc = "Next Function end"
            },
            ["]M"] = {
              query = "@function.outer",
              desc = "Next Method end"
            },
            ["]C"] = {
              query = "@class.outer",
              desc = "Next Class end"
            },
            ["]I"] = {
              query = "@conditional.outer",
              desc = "Next Conditional end"
            },
            ["]L"] = {
              query = "@loop.outer",
              desc = "Next Loop end"
            },
          },

          goto_previous_start = {
            ["[f"] = {
              query = "@function.outer",
              desc = "Previous Function start"
            },
            ["[m"] = {
              query = "@function.outer",
              desc = "Previous Method start"
            },
            ["[c"] = {
              query = "@class.outer",
              desc = "Previous Class start"
            },
            ["[i"] = {
              query = "@conditional.outer",
              desc = "Previous Conditional start"
            },
            ["[l"] = {
              query = "@loop.outer",
              desc = "Previous Loop start"
            },
          },

          goto_previous_end = {
            ["[F"] = {
              query = "@function.outer",
              desc = "Previous Function end"
            },
            ["[M"] = {
              query = "@function.outer",
              desc = "Previous Method end"
            },
            ["[C"] = {
              query = "@class.outer",
              desc = "Previous Class end"
            },
            ["[I"] = {
              query = "@conditional.outer",
              desc = "Previous Conditional end"
            },
            ["[L"] = {
              query = "@loop.outer",
              desc = "Previous Loop end"
            },

          },
        },

      },
    }


    -- █▀█ █▀▀ █▀█ █▀▀ ▄▀█ ▀█▀   █▀▄▀█ █▀█ █░█ █▀▀
    -- █▀▄ ██▄ █▀▀ ██▄ █▀█ ░█░   █░▀░█ █▄█ ▀▄▀ ██▄

    local move = require("nvim-treesitter.textobjects.repeatable_move")

    -- vim way: ; goes to the direction you were moving.
    vim.keymap.set({ "n", "x", "o" }, ";", move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    -- WARN: Disabling bc this conflicts and breaks flash.nvim f/t motions
    -- But only when opening file from dashboard via fuzzy finding

    -- vim.keymap.set({ "n", "x", "o" }, "f", move.builtin_f_expr, { expr = true })
    -- vim.keymap.set({ "n", "x", "o" }, "F", move.builtin_F_expr, { expr = true })
    -- vim.keymap.set({ "n", "x", "o" }, "t", move.builtin_t_expr, { expr = true })
    -- vim.keymap.set({ "n", "x", "o" }, "T", move.builtin_T_expr, { expr = true })
  end,

  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
  },
}

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true,
  config = function()
    require'nvim-treesitter.configs'.setup {
      textobjects = {


        -- █▀ █▀▀ █░░ █▀▀ █▀▀ ▀█▀
        -- ▄█ ██▄ █▄▄ ██▄ █▄▄ ░█░

        select = {
          enable = true,
          lookahead = true,
          include_surrounding_whitespace = false,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["i="] = {
              query = "@assignment.lhs",
              desc = "Select LHS of assignment"
            },
            ["a="] = {
              query = "@assignment.rhs",
              desc = "Select RHS of assignment"
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

            -- ============================================================= --
            ["ia"] = {
              query = "@parameter.inner",
              desc = "Select inside parameter/argument"
            },
            ["aa"] = {
              query = "@parameter.outer",
              desc = "Select around parameter/argument"
            },

            -- ============================================================= --
            ["ai"] = {
              query = "@conditional.outer",
              desc = "Select around conditional"
            },
            ["ii"] = {
              query = "@conditional.inner",
              desc = "Select inside conditional"
            },

            -- ============================================================= --
            ["il"] = {
              query = "@loop.inner",
              desc = "Select inside loop"
            },
            ["al"] = {
              query = "@loop.outer",
              desc = "Select around loop"
            },

            -- ============================================================= --
            ["if"] = {
              query = "@call.inner",
              desc = "Select inside function call"
            },
            ["af"] = {
              query = "@call.outer",
              desc = "Select around function call"
            },

            -- ============================================================= --
            ["im"] = {
              query = "@function.inner",
              desc = "Select inside method/function definition"
            },
            ["am"] = {
              query = "@function.outer",
              desc = "Select around method/function definition"
            },

            -- ============================================================= --
            ["ic"] = {
              query = "@class.inner",
              desc = "Select inside class"
            },
            ["ac"] = {
              query = "@class.outer",
              desc = "Select around class"
            },
          },

          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },

        },


        -- █▀ █░█░█ ▄▀█ █▀█
        -- ▄█ ▀▄▀▄▀ █▀█ █▀▀

        swap = {
          enable = true,

          swap_next = {
            ["<leader>na"] = "@parameter.inner", -- swap parame/arg with next
            ["<leader>n:"] = "@property.outer", -- swap obj property with next
            ["<leader>nm"] = "@function.outer", -- swap function with next
          },

          swap_previous = {
            ["<leader>pa"] = "@parameter.inner", -- swap param/arg with prev
            ["<leader>p:"] = "@property.outer", -- swap obj property with prev
            ["<leader>pm"] = "@function.outer", -- swap function with previous
          },

        },


        -- █▀▄▀█ █▀█ █░█ █▀▀
        -- █░▀░█ █▄█ ▀▄▀ ██▄

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist

          goto_next_start = {
            ["]f"] = {
              query = "@call.outer",
              desc = "Next function call start"
            },
            ["]m"] = {
              query = "@function.outer",
              desc = "Next method/function def start"
            },
            ["]c"] = {
              query = "@class.outer",
              desc = "Next class start"
            },
            ["]i"] = {
              query = "@conditional.outer",
              desc = "Next conditional start"
            },
            ["]l"] = {
              query = "@loop.outer",
              desc = "Next loop start"
            },
            ["]s"] = {
              query = "@scope", query_group = "locals",
              desc = "Next scope"
            },
            ["]z"] = {
              query = "@fold", query_group = "folds",
              desc = "Next fold"
            },
          },

          goto_next_end = {
            ["]F"] = {
              query = "@call.outer",
              desc = "Next function call end"
            },
            ["]M"] = {
              query = "@function.outer",
              desc = "Next method/function def end"
            },
            ["]C"] = {
              query = "@class.outer",
              desc = "Next class end"
            },
            ["]I"] = {
              query = "@conditional.outer",
              desc = "Next conditional end"
            },
            ["]L"] = {
              query = "@loop.outer",
              desc = "Next loop end"
            },
          },

          goto_previous_start = {
            ["[f"] = {
              query = "@call.outer",
              desc = "Prev function call start"
            },
            ["[m"] = {
              query = "@function.outer",
              desc = "Prev method/function def start"
            },
            ["[c"] = {
              query = "@class.outer",
              desc = "Prev class start"
            },
            ["[i"] = {
              query = "@conditional.outer",
              desc = "Prev conditional start"
            },
            ["[l"] = {
              query = "@loop.outer",
              desc = "Prev loop start"
            },
          },

          goto_previous_end = {
            ["[F"] = {
              query = "@call.outer",
              desc = "Prev function call end"
            },
            ["[M"] = {
              query = "@function.outer",
              desc = "Prev method/function def end"
            },
            ["[C"] = {
              query = "@class.outer",
              desc = "Prev class end"
            },
            ["[I"] = {
              query = "@conditional.outer",
              desc = "Prev conditional end"
            },
            ["[L"] = {
              query = "@loop.outer",
              desc = "Prev loop end"
            },

          },
        },

      },
    }


    -- █▀█ █▀▀ █▀█ █▀▀ ▄▀█ ▀█▀   █▀▄▀█ █▀█ █░█ █▀▀
    -- █▀▄ ██▄ █▀▀ ██▄ █▀█ ░█░   █░▀░█ █▄█ ▀▄▀ ██▄

    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

    -- vim way: ; goes to the direction you were moving.
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)


  end
}

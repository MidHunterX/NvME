return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({

      keymaps = {
        -- [g]o [s]urround {<motions> <bracket>}
        normal = "gs",
        normal_line = "gS",

        -- [g]o [s]urround this [l]ine with {<bracket>}
        normal_cur = "gsl",
        normal_cur_line = "gsL",

        -- [c]hange [s]urrounding {<bracket>}
        change = "cs",
        change_line = "cS",

        -- [d]elete [s]urrounding {<bracket>}
        delete = "ds",

        -- insert = "<C-g>s",
        -- insert_line = "<C-g>S",
        -- visual = "S",
        -- visual_line = "gS",
      },

      aliases = {
        -- angle bracket
        ["a"] = ">",
        -- bracket (default brackets.. the paranthesis!)
        ["b"] = ")",
        -- brace
        ["B"] = "}",
        -- rectangle bracket
        ["r"] = "]",
        -- quote
        ["q"] = { '"', "'", "`" },
        -- surrounding
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
      },

    })
  end
}

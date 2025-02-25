-- Reason: Replaced by Snacks

return {
  "nvim-telescope/telescope-file-browser.nvim",
  lazy = true,
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    -- PROJECT FILE BROWSER
    {
      "<leader>pf",
      "<CMD>Telescope file_browser<CR>",
      mode = "n",
      desc = "Telescope File Browser"
    },
    -- open file_browser with the path of the current buffer
    {
      "<leader>pf",
      "<CMD>Telescope file_browser path=%:p:h select_buffer=true<CR>",
      mode = "n",
      desc = "Telescope Project File Browser"
    },
  },
  config = function()
    local fb_actions = require "telescope".extensions.file_browser.actions
    require("telescope").setup {
      extensions = {
        file_browser = {
          ---------------------------------[ vim style file explorer keymaps ]
          mappings = {
            ["i"] = {},
            ["n"] = {
              ["h"] = fb_actions.goto_parent_dir,
              ["n"] = fb_actions.create,
              ["<C-n>"] = fb_actions.create,
              ["yy"] = fb_actions.copy,
              ["dd"] = fb_actions.remove,
              ["cw"] = fb_actions.rename,
            },
          },
        },
      },
    }
    require("telescope").load_extension "file_browser"
  end,
}

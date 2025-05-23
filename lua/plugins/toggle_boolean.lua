return {
  "nat-418/boole.nvim",
  keys = {
    { "<C-a>", "<Cmd>Boole Increment<CR>", desc = "Boole: Increment" },
    { "<C-x>", "<Cmd>Boole Decrement<CR>", desc = "Boole: Decrement" },
  },
  opts = {
    mappings = {
      increment = '<C-a>',
      decrement = '<C-x>'
    },

    -- Case sensitive
    additions = {
      { 'Foo', 'Bar' },
      { 'tic', 'tac', 'toe' }
    },

    -- Case adaptive
    allow_caps_additions = {
      { 'enable', 'disable' }
      -- enable → disable
      -- Enable → Disable
      -- ENABLE → DISABLE
    }
  }
}

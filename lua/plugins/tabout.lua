return {
  "kawre/neotab.nvim",
  event = "InsertEnter",
  opts = {
    tabkey = "<Tab>",
    act_as_tab = true,
    behavior = "nested",

    pairs = {
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "<", close = ">" },
    },

    -- ignore these filetypes for tabout
    exclude = {},

    -- █▀ █▀▄▀█ ▄▀█ █▀█ ▀█▀   █▀ █▀▀ █▀▄▀█ █ █▀▀ █▀█ █░░ █▀█ █▄░█
    -- ▄█ █░▀░█ █▀█ █▀▄ ░█░   ▄█ ██▄ █░▀░█ █ █▄▄ █▄█ █▄▄ █▄█ █░▀█
    smart_punctuators = {
      enabled = true,
      semicolon = {
        enabled = true,
        ft = { "cs", "c", "cpp", "java" },
      },

      -- █▀ █▀▄▀█ ▄▀█ █▀█ ▀█▀   █▀▀ █▀ █▀▀ ▄▀█ █▀█ █▀▀
      -- ▄█ █░▀░█ █▀█ █▀▄ ░█░   ██▄ ▄█ █▄▄ █▀█ █▀▀ ██▄
      -- escapes pairs with specified punctuators
      escape = {
        enabled = true,
        triggers = {

          ["+"] = {
            pairs = {
              { open = '"', close = '"' },
            },
            -- string.format(format, typed_char)
            format = " %s ", -- " + "
            ft = { "java" },
          },

          [","] = {
            pairs = {
              { open = "'", close = "'" },
              { open = '"', close = '"' },
            },
            format = "%s ", -- ", "
          },

          ["="] = {
            pairs = {
              { open = "(", close = ")" },
            },
            ft = { "javascript", "typescript" },
            format = " %s> ", -- ` => `
            -- string.match(text_between_pairs, cond)
            cond = "^$", -- match only pairs with empty content
          },

        },
      },
    },
  },
}

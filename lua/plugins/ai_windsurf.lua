---@type "trace" | "debug" | "info" | "warn" | "error"
vim.env.DEBUG_CODEIUM = "warn"

local function codeium_cmp_cycle()
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.abort()
    return
  end
  require('codeium.virtual_text').cycle_or_complete()
end

-- Windsurf (Codeium)
return {
  "Exafunction/windsurf.nvim",
  -- load only when actually using windsurf
  -- highlight won't work correctly with this though
  -- event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    vim.keymap.set('i', '<M-,>', codeium_cmp_cycle, { expr = true, silent = true })

    require("codeium").setup({
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        manual = false,
        filetypes = {
          ["snacks_picker_input"] = false,
          ["typr"] = false,
        },
        idle_delay = 100, -- ms to wait before requesting completions
        map_keys = true,
        key_bindings = {
          accept = "<C-f>",
          accept_word = false,
          accept_line = false,
          clear = false,
          next = "<M-]>",
          prev = "<M-[>",
        }
      }
    })
  end
}

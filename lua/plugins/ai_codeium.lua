-- vim.g.codeium_enabled = false -- Enable manually by :CodeiumEnable
vim.g.codeium_manual = false -- Enable manually with codeium#CycleOrComplete
vim.g.codeium_disable_bindings = 1

vim.g.codeium_filetypes = {
  ["snacks_picker_input"] = false,
}

return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.keymap.set('i', '<c-f>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<c-l>', function() return vim.fn['codeium#AcceptNextLine']() end, { expr = true, silent = true })

    -- Workflow: Yeet CMP menu when doing codeium#CycleOrComplete
    -- Algorithm:
    -- 1. If CMP menu is visible, abort it
    -- 2. Cycle through Codeium completions

    vim.keymap.set('i', '<c-,>', function()
      local cmp = require("cmp")
      if cmp.visible() then
        cmp.abort()
        return
      end
      return vim.fn['codeium#CycleOrComplete']()
    end, { expr = true, silent = true , desc = "Cycle or complete with Codeium" })
  end
}

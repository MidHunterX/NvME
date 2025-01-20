-- vim.g.codeium_enabled = false -- Enable manually by :CodeiumEnable
vim.g.codeium_manual = false -- Enable manually with codeium#CycleOrComplete
vim.g.codeium_disable_bindings = 1

return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function ()
    vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleOrComplete']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-i>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  end
}

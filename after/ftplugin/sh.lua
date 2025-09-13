vim.bo.expandtab = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

-- Printf Debug
local esc = string.char(27)
vim.fn.setreg("l", "yoecho \"" .. esc .. "pA: ${" .. esc .. "pA}\"" .. esc)

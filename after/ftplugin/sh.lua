-- Printf Debug
local esc = string.char(27)
vim.fn.setreg("l", "yoecho \"" .. esc .. "pa: ${" .. esc .. "pa}\"" .. esc)

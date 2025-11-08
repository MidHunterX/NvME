vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

local esc = string.char(27)

-- Printf Debug
vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa: ', " .. esc .. "pa)" .. esc)

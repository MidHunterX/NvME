-- How to get Macros?
-- :registers
-- replace \^\[ with " .. esc .. "

-- ================================[ MACROS ]================================ --
local esc = string.char(27)

-- Printf Debug
vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa: ', " .. esc .. "pa)" .. esc)

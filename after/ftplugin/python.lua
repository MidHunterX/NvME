-- ================================[ MACROS ]================================ --
local esc = string.char(27)

-- Printf Debug
vim.fn.setreg("l", "yoprint(f\"" .. esc .. "pa: {" .. esc .. "pa}\")" .. esc)

-- 80 char break is preferred so, keep the indentation minimal at 2 to prevent over breaking
-- Luarocks uses 3 space indentation. Also does Sputnik:
-- http://sputnik.freewisdom.org/en/Coding_Standard
--
-- Their rationale is since this is a language with lots of do / end blocks, it produces a pleasant looking code.
-- https://github.com/luarocks/lua-style-guide?tab=readme-ov-file

vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

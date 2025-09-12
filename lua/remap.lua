local custard = require("custom_functions")

--============================[ USEFUL_KEYMAPS ]============================--

vim.g.mapleader = " "
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
------------------------------------------------------ Redo: Undo inverse [ U ]
vim.keymap.set("n", "U", "<C-r>")
--------------------------------------------- Move line with autoindent [ J/K ]
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
----------------------------------------- Indent without leaving Visual [ </> ]
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
------------------------------------- Return to Normal in Terminal [ Ctrl n n ]
-- FIXES: <C-BS> Conflict in Terminal
-- <C-w> == <C-BS> == <C-h> (ASCII 0x17)
vim.keymap.set("t", "<C-n>n", "<C-\\><C-n>")
--------------------------------------------------------- Goto line start [ H ]
vim.keymap.set({ 'n', 'v' }, 'H', custard.SmartMotionH, { expr = true, desc = 'Smart H (^ or {)' })
----------------------------------------------------------- Goto line end [ L ]
vim.keymap.set({ 'n', 'v' }, 'L', custard.SmartMotionL, { expr = true, desc = 'Smart L ($ or })' })
-------------------------------------------------- Scroll centered [ Ctrl d/u ]
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
----------------------------------------------- Jump to matching bracket [ mm ]
vim.keymap.set("n", "mm", "%", { desc = "Jump to matching bracket" })
-- Selects until matching pair, ex: `vm` - select until matching pair
vim.keymap.set("x", "m", "%")
-- Use with operators, ex: `dm` - delete until matching pair
vim.keymap.set("o", "m", "%")


--=============================[ LEADER REMAPS ]=============================--

----------------------------------------------------- Write file [ <leader> w ]
vim.keymap.set("n", "<leader>w", custard.WriteFile, { desc = "Write file" })
---------------------------------------------- Erase highlight [ <leader> er ]
vim.keymap.set("n", "<leader>er", "<Cmd>noh<CR>", { desc = "Erase Replace Highlight" })
----------------------------------- Highlight for Replace word [ <leader> rr ]
vim.keymap.set("n", "<leader>rr", "*N", { desc = "Highlight & Replace word" })
vim.keymap.set("v", "<leader>rr", "y/<C-r>0<CR>N", { desc = "Highlight & Replace Word" })

----------------------------------------------------- Super Yank [ <leader> y ]
vim.keymap.set("n", "<leader>y", "<Cmd>%yank<CR>", { desc = "Buffer: Yank content" })

-------------------------------------------------- Spell Toggle [ <leader> us ]
vim.keymap.set("n", "<leader>us", function()
  vim.wo.spell = not vim.wo.spell
  print("Spell: " .. (vim.wo.spell and "ON" or "OFF"))
end, { desc = "Toggle: Spell Check" })


--===========================[ BUFFER MANAGEMENT ]===========================--

---------------------------------------------- Cycle across buffers [ Alt h/l ]
vim.keymap.set("n", "<A-h>", "<Cmd>bp<CR>")
vim.keymap.set("n", "<A-l>", "<Cmd>bn<CR>")
---------------------------------------------------- Delete buffer [ leader x ]
-- Currently replaced by Snacks
-- vim.keymap.set("n", "<leader>x", "<Cmd>bd<CR>", { desc = "Close buffer" })
--------------------------------------------- Execute buffer [ F5 / leader ru ]
vim.keymap.set("n", "<F5>", custard.Execute_order_69)
vim.keymap.set("n", "<leader>ru", custard.Execute_order_69, { desc = "Execute buffer" })


--============================[ TAB MANAGEMENT ]============================--
vim.keymap.set("n", "<leader>tn", "<Cmd>tabnew<CR>", { desc = "Tab: New" })
vim.keymap.set("n", "<leader>tc", "<Cmd>tabnew<CR>", { desc = "Tab: Create" })

vim.keymap.set("n", "<leader>tx", "<Cmd>tabclose<CR>", { desc = "Tab: Exit" })
vim.keymap.set("n", "<leader>tq", "<Cmd>tabclose<CR>", { desc = "Tab: Quit" })

vim.keymap.set("n", "<leader>tX", "<Cmd>tabonly<CR>", { desc = "Tab: Exit Other Tabs" })
vim.keymap.set("n", "<leader>tQ", "<Cmd>tabonly<CR>", { desc = "Tab: Quit Other Tabs" })
vim.keymap.set("n", "<leader>th", "<Cmd>tabprevious<CR>", { desc = "Tab: Previous" })
vim.keymap.set("n", "<leader>tl", "<Cmd>tabnext<CR>", { desc = "Tab: Next" })
----------------------------------------- Cycle across tabs [ leader Alt h/l ]
vim.keymap.set("n", "<leader><A-h>", "<Cmd>tabprevious<CR>", { desc = "Tab: Previous" })
vim.keymap.set("n", "<leader><A-l>", "<Cmd>tabnext<CR>", { desc = "Tab: Next" })
----------------------------------------- Quick Cycle across tabs [ Ctrl h/l ]
vim.keymap.set("n", "<C-h>", "<Cmd>tabprevious<CR>", { desc = "Tab: Previous" })
vim.keymap.set("n", "<C-l>", "<Cmd>tabnext<CR>", { desc = "Tab: Next" })


--=================================[ FIXES ]=================================--

-- Deletes selected text into blackhole register "_" and paste
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
-- Deletes into the blackhole register "_"
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- Set description for default vim keymaps
vim.keymap.set({ "n", "v" }, "g?", "g?", { desc = "ROT13 Cipher" })


--==============================[ GUI REMAPS ]==============================--

--------------------------------------------------------- Select all [ Ctrl a ]
-- vim.keymap.set("n", "<C-a>", "ggVG")  -- Conflicts with C-a Increment
------------------------------------------------------ Save document [ Ctrl s ]
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")

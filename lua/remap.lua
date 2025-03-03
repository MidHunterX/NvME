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
-------------------------------------------- Goto buffer in position [Alt J/K ]
vim.keymap.set("n", "<A-h>", "<Cmd>bp<CR>")
vim.keymap.set("n", "<A-l>", "<Cmd>bn<CR>")
------------------------------------- Return to Normal in Terminal [ Ctrl n n ]
-- <C-w> == <C-BS> == <C-h> (ASCII 0x17)
vim.keymap.set("t", "<C-n>n", "<C-\\><C-n>")
--------------------------------------------------------- Goto line start [ H ]
vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "H", "^")
----------------------------------------------------------- Goto line end [ L ]
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "L", "$")
-------------------------------------------------- Scroll centered [ Ctrl d/u ]
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
--------------------------------------------------------- Execute buffer [ F5 ]
vim.keymap.set("n", "<F5>", custard.Execute_order_69)


--=============================[ LEADER REMAPS ]=============================--

----------------------------------------------------- Write file [ <leader> w ]
vim.keymap.set("n", "<leader>w", custard.WriteFile, { desc = "Write file" })
------------------------------------------ Find and Replace word [ <leader> r ]
vim.keymap.set("n", "<leader>r", "*N", { desc = "Replace Highlight" })
vim.keymap.set("v", "<leader>r", "y/<C-r>0<CR>N", { silent = true, desc = "Replace Highlight" })
------------------------------------------- Erase "r" highlight [ <leader> er ]
vim.keymap.set("n", "<leader>er", "<Cmd>noh<CR>", { desc = "Erase Replace Highlight" })
-------------------------------------------- Replace word Regex [ <leader> rr ]
vim.keymap.set("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word (Regex)" })
---------------------------------------------------- Delete buffer [ leader x ]
vim.keymap.set("n", "<leader>x", "<Cmd>bd<CR>", { desc = "Close buffer" })


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

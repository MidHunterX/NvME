local custard = require("custom_functions")

--============================[ @USEFUL_KEYMAPS ]============================--

vim.g.mapleader = " "
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
----------------------------------------------------- Write file [ <leader> w ]
vim.keymap.set("n", "<leader>w", custard.WriteFile)
------------------------------------------------------ Redo: Undo inverse [ U ]
vim.keymap.set("n", "U", "<C-r>")
--------------------------------------------- Move line with autoindent [ J/K ]
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
----------------------------------------- Indent without leaving Visual [ </> ]
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
------------------------------------------ Find and Replace word [ <leader> r ]
vim.keymap.set("n", "<leader>r", "*N")
------------------------------------------- Erase "r" highlight [ <leader> er ]
vim.keymap.set("n", "<leader>er", "<Cmd>noh<CR>")
-------------------------------------------- Replace word Regex [ <leader> rr ]
vim.keymap.set("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
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
---------------------------------------------------- Delete buffer [ leader x ]
vim.keymap.set("n", "<leader>x", "<Cmd>bd<CR>")
--------------------------------------------------------- Execute buffer [ F5 ]
vim.keymap.set("n", "<F5>", custard.Execute_order_69)


--==============================[ GIT REMAPS ]==============================--

------------------------------------------------------------- Git Hunks [ gh- ]
vim.keymap.set("n", "ghh", "<Cmd>Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "ghn", "<Cmd>Gitsigns next_hunk<CR>")
vim.keymap.set("n", "ghp", "<Cmd>Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "ghb", "<Cmd>Gitsigns blame_line<CR>")
vim.keymap.set("n", "ght", "<Cmd>Gitsigns toggle_current_line_blame<CR>")


--============================[ WINDOWS REMAPS ]============================--

--------------------------------------------------------- Select all [ Ctrl a ]
-- vim.keymap.set("n", "<C-a>", "ggVG")  -- Conflicts with C-a Increment
------------------------------------------------------ Save document [ Ctrl s ]
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")


--=================================[ FIXES ]=================================--

-- Deletes selected text into blackhole register "_" and paste
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Deletes into the blackhole register "_"
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

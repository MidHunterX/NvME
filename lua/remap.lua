--============================[ @USEFUL_KEYMAPS ]============================--

vim.g.mapleader = " "
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-------------------------------------------------------------- ESCAPE to Normal
vim.keymap.set("i", "fj", "<Esc>")
vim.keymap.set("i", "jf", "<Esc>")
------------------------------------------------------- Write file [ leader w ]
vim.keymap.set("n", "<leader>w", ":w<CR>")
---------------------------------------------------- Save and Quit [ leader q ]
-- vim.keymap.set("n", "<leader>q", "ZZ")
------------------------------------------------------ Redo: Undo inverse [ U ]
vim.keymap.set("n", "U", "<C-r>")
--------------------------------------------- Move line with autoindent [ J/K ]
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
----------------------------------------------- Replace word Regex [ leader r ]
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-------------------------------------------- Goto buffer in position [alt J/K ]
vim.keymap.set("n", "<A-j>", "<Cmd>bp<CR>")
vim.keymap.set("n", "<A-k>", "<Cmd>bn<CR>")
------------------------------------------ Return to Normal in Terminal [ Esc ]
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
--------------------------------------------------------- Goto line start [ H ]
vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "H", "^")
----------------------------------------------------------- Goto line end [ L ]
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "L", "$")

--============================[ WINDOWS REMAPS ]============================--

--------------------------------------------------------- Select all [ Ctrl a ]
vim.keymap.set("n", "<C-a>", "gg0vG$")
-- Tip: You can return to Normal mode by pressing gh
------------------------------------------------------ Save document [ Ctrl s ]
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")

--===========================[ @GENERAL_COMMANDS ]===========================--
-- Highlighted Yank
vim.cmd([[ autocmd TextYankPost * silent! lua vim.hl.on_yank() ]])

-- Scroll past last line
vim.cmd([[nnoremap <expr> j line(".") == line('$') ? '<C-e>':'j']])

-- Automatically change number based on Insert Mode, except in floating windows
-- Philosophy:
-- When typing (insert mode), it should look like every other editors out there
-- But on navigation (normal mode), line numbers should serve a purpose (feature)
-- "Insert mode is for writing - don't distract me. Normal mode is for navigating - give me tools."

local function is_normal_win()
  -- Only in normal windows, skipping floating windows (like popups, LSP hovers, etc.)
  return vim.api.nvim_win_get_config(0).relative == ""
end

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    if is_normal_win() then
      vim.opt_local.relativenumber = false
    end
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if is_normal_win() then
      vim.opt_local.relativenumber = true
    end
  end,
})


-- Yank into system clipboard "+"
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

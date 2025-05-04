-- Disable 80 Char column on HTML because it breaks with markdown preview
vim.opt_local.colorcolumn = "0"

vim.keymap.set("v", "<C-b>", "c**<ESC>pa**<ESC>",
  { buffer = true, desc = "Bold text with **" })

vim.keymap.set("v", "<C-i>", "c*<ESC>pa*<ESC>",
  { buffer = true, desc = "Italic text with *" })

vim.keymap.set("v", "<C-`>", "c`<ESC>pa`<ESC>",
  { buffer = true, desc = "Code text with `" })

vim.keymap.set("v", "<C-x>", "c~<ESC>pa~<ESC>",
  { buffer = true, desc = "Strikethrough text with ~" })


-- BUG: Detects as link if http is anywhere in the line, not just selection
local function make_markdown_link()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_number = cursor[1]
  local current_line = vim.fn.getline(line_number)

  if current_line:match("http") then
    local key = vim.api.nvim_replace_termcodes('c[](<ESC>pa)<ESC>F[a',
      true, false, true)
    vim.api.nvim_feedkeys(key, 'n', true)
  else
    local key = vim.api.nvim_replace_termcodes('c[<ESC>pa]()<ESC>',
      true, false, true)
    vim.api.nvim_feedkeys(key, 'n', true)
  end
end

vim.keymap.set("v", "<C-l>", make_markdown_link,
  { buffer = true, desc = "Text/URL to link with []()" })


-- MARKDOWN LIST ITEMS (using commentstrings)
vim.opt_local.comments = { "b:*", "b:-", "b:+", "n:>" }
-- r → Continues the comment when pressing <Enter> inside a comment.
-- o → Continues the comment when opening a new line with o or O.
vim.opt_local.formatoptions:append("ro")

-- Number of spaces that a <Tab> counts for while performing editing operations
-- like inserting a <Tab> or using <BS>.
-- It "feels" like <Tab>s are being inserted.
vim.opt_local.softtabstop = 2

-- Number of spaces to use for each step of (auto)indent.
-- Used for |'cindent'|, |>>|, |<<|, etc.
vim.opt_local.shiftwidth = 2

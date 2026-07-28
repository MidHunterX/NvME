local M = {}

---@alias PathType "absolute" | "relative"
---@alias YankMode "n" | "v"
--- Yanks the filepath with specified options
---@param pathtype PathType
---@param mode     YankMode
---@return nil
function M.YankFilepath(pathtype, mode)
  local file_path

  if pathtype == "absolute" then
    file_path = vim.fn.expand("%:p")
  else
    file_path = vim.fn.expand("%:.")
  end

  if mode == "v" then
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    file_path = string.format("%s:%d:%d", file_path, start_line, end_line)
  end

  vim.fn.setreg("+", file_path)

  -- ACTION: Trigger TextYankPost event
  vim.api.nvim_exec_autocmds("TextYankPost", {
    pattern = "*",
    data = { regcontents = { file_path }, regname = "+", operator = "y", regtype = "v", visual = true }
  })

  -- ACTION: Goto Normal Mode
  if mode == "v" then
    vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
  end
end

--- Yanks the filepath and contents
---@param pathtype PathType
---@param mode     YankMode
---@return nil
function M.YankFileContext(pathtype, mode)
  local file_path
  if pathtype == "absolute" then
    file_path = vim.fn.expand("%:p")
  else
    file_path = vim.fn.expand("%:.")
  end

  local selected_text
  local extension = vim.fn.expand("%:e")
  local lang_hint = extension ~= "" and extension or ""

  if mode == "v" then
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    file_path = string.format("%s:%d:%d", file_path, start_line, end_line)
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    selected_text = table.concat(lines, "\n")

    -- Simple line highlighting
    local ns_id = vim.api.nvim_create_namespace("yank_highlight")
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
    -- Highlight the range
    for i = start_line, end_line do
      local line_len = #vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1] or 0
      vim.hl.range(0, ns_id, "Search", { i - 1, 0 }, { i - 1, line_len })
    end
    -- Clear Highlight
    vim.defer_fn(function () vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1) end, 200)
  else
    selected_text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
  end

  local output = string.format("%s\n```%s\n%s\n```", file_path, lang_hint, selected_text)

  vim.fn.setreg("+", output)

  -- ACTION: Trigger TextYankPost event
  vim.api.nvim_exec_autocmds("TextYankPost", {
    pattern = "*",
    data = { regcontents = { output }, regname = "+", operator = "y", regtype = "v", visual = true }
  })

  -- ACTION: Goto Normal Mode
  if mode == "v" then
    vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
  end
end

-- Smart Motion Philosophy:
-- Capital letters represent the "extreme" form of their lowercase motion.
-- Therefore, H (← extreme) and L (→ extreme) should go to ^ and $ respectively,
-- and adapt to jump blocks ({, }) when cursor is on an empty line.
-- This mapping restores consistency, utility, and fluidity in navigation.
-- During macro recording, the paragraph jump is not used as it's only intended
-- for navigational purposes. And it can cause unintended effects in a macro.
-- NOTE: { and } by default adds the current position to the jumplist leading
-- to jumplist pollution. vim Marks are provided as a solution for this issue.

function M.SmartMotionH()
  local line = vim.fn.getline('.')
  local empty_line = line:match("^%s*$")
  if empty_line then
    return '{'
  else
    return '^'
  end
end

function M.SmartMotionL()
  local line = vim.fn.getline('.')
  local empty_line = line:match("^%s*$")
  if empty_line then
    return '}'
  else
    return '$'
  end
end

--- Remove trailing whitespace and save the current buffer
function M.WriteFile()
  local save_cursor = vim.fn.getpos(".")
  -- Remove trailing whitespace
  vim.cmd('%s/\\s\\+$//e')
  vim.cmd('nohlsearch')
  vim.fn.setpos(".", save_cursor)
  -- Save the current buffer
  vim.cmd('w')
end

--- Execute the current file
function M.Execute_order_69()
  local function terminal(cmd)
    if vim.fn.winwidth(0) > 100 then
      vim.cmd(":vsplit")
    else
      vim.cmd(":split")
    end
    vim.cmd(":term " .. cmd)
  end
  local file_type = vim.bo.filetype

  if file_type == 'python' then
    terminal('python %')
  elseif file_type == "html" then
    local check = require('core.killswitch')
    if check.is_liveserver then
      vim.cmd(":term live-server --no-browser")
    end
  elseif file_type == "sh" then
    terminal('bash %')
  elseif file_type == "rust" then
    if vim.fn.filereadable('Cargo.toml') == 1 then
      terminal('cargo run')
    else
      local filename = vim.fn.expand('%')
      terminal('rustc ' .. filename .. ' && ./' .. filename:gsub('.rs', ''))
    end
  elseif file_type == 'go' then
    terminal('go run %')
  elseif file_type == 'perl' then
    if vim.fn.expand('%:e') == 'pl' then
      terminal('perl %')
    elseif vim.fn.expand('%:e') == 't' then
      terminal('prove -v %')
    end
  elseif file_type == 'c' then
    terminal('gcc % && ./a.out')
  elseif file_type == 'java' then
    terminal('java %')
  elseif file_type == 'javascript' then
    terminal('node %')
  elseif file_type == 'elixir' then
    terminal('elixir %')
  elseif file_type == 'tcl' then
    terminal('tclsh %')
  elseif file_type == 'php' then
    terminal('php %')
  elseif file_type == 'nim' then
    terminal('nim c -r %')
  else
    local messages = { "This file?... Cannot run because no.", "I'm sorry dave. I'm afraid I can't do that." }
    local message = messages[math.random(#messages)]
    print(message)
  end
end

return M

local M = {}

-- Smart Motion Philosophy:
-- Capital letters represent the "extreme" form of their lowercase motion.
-- Therefore, H (← extreme) and L (→ extreme) should go to ^ and $ respectively,
-- and adapt to jump blocks ({, }) when already at the edge.
-- This mapping restores consistency, utility, and fluidity in navigation.
-- During macro recording, the paragraph jump is not used as it's only intended
-- for navigational purposes. And it can cause unintended effects in a macro.
-- NOTE: { and } by default adds the current position to the jumplist leading
-- to jumplist pollution. vim Marks are provided as a solution for this issue.

local function is_macro_recording()
  return vim.fn.reg_recording() ~= ''
end

function M.SmartMotionH()
  if is_macro_recording() then return '^' end

  local col = vim.fn.col('.')
  local line = vim.fn.getline('.')
  local first_nonblank = vim.fn.match(line, [[\S]]) + 1
  if (col == first_nonblank) or (col == 1) then
    return '{'
  else
    return '^'
  end
end

function M.SmartMotionL()
  if is_macro_recording() then return '$' end

  local col = vim.fn.col('.')
  local line = vim.fn.getline('.')
  if col >= #line then
    return '}'
  else
    return '$'
  end
end

---Remove trailing whitespace and save the current buffer
function M.WriteFile()
  local save_cursor = vim.fn.getpos(".")
  -- Remove trailing whitespace
  vim.cmd('%s/\\s\\+$//e')
  vim.cmd('nohlsearch')
  vim.fn.setpos(".", save_cursor)
  -- Save the current buffer
  vim.cmd('w')
end

---Execute the current file
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
    vim.cmd(":term live-server --no-browser")
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
  elseif file_type == 'c' then
    terminal('gcc % && ./a.out')
  elseif file_type == 'java' then
    terminal('java %')
  elseif file_type == 'javascript' then
    terminal('node %')
  elseif file_type == 'elixir' then
    terminal('elixir %')
  else
    print('This file?... Cannot run because no.')
  end
end

return M

local M = {}

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
    vim.cmd(":vs")
    vim.cmd(":term " .. cmd)
  end
  local file_type = vim.bo.filetype

  if file_type == 'python' then
    terminal('python %')
  elseif file_type == "html" then
    vim.cmd(":term live-server --no-browser")
  elseif file_type == "sh" then
    terminal('bash %')
  elseif file_type == 'c' then
    terminal('gcc % && ./a.out')
  elseif file_type == 'elixir' then
    terminal('elixir %')
  else
    print('This file?... Cannot run because no.')
  end
end

return M

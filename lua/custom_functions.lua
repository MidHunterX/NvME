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
  local file_type = vim.bo.filetype
  -- PYTHON SCRIPT
  if file_type == 'python' then
    vim.cmd(':vs')
    vim.cmd(':term python %')
    -- HTML SERVER
  elseif file_type == "html" then
    vim.cmd(":term live-server --no-browser")
    -- BASH SCRIPT
  elseif file_type == "sh" then
    vim.cmd(':vs')
    vim.cmd(":term bash %")
    -- C PROGRAMMING LANGUAGE
  elseif file_type == 'c' then
    vim.cmd(':vs')
    vim.cmd(":term gcc % && ./a.out")
  else
    print('This file?... Cannot run because no.')
  end
end

return M

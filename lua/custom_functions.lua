--=============================[ @EXECUTE_FILES ]=============================--

function Execute_order_69()
  local file_type = vim.bo.filetype
  if file_type == 'python' then
    -- Vertical Split
    vim.cmd(':vs')
    -- Execute terminal command
    vim.cmd(':term python %')
  elseif file_type == "html" then
    vim.cmd(":term live-server --no-browser")
  else
    print('This file?... Cannot run because no.')
  end
end

-- Map <F5> to execute the function
vim.cmd('nnoremap <F5> :lua Execute_order_69()<CR>')

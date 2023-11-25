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


--=============================[ @FORMAT_FILES ]=============================--

local function is_filetype_in_list(filetype, list)
  for _, value in ipairs(list) do
    if value == filetype then return true end
  end
  return false
end

function Run_formatter()
  local file_type = vim.bo.filetype
  local list_prettier = { "markdown", "html", "json", "javascript", "css" }

  -- pip Black Formatter: Python
  if file_type == "python" then
    vim.cmd("silent !black " .. vim.fn.shellescape(vim.fn.expand("%")))
  -- npm Prettier Formatter: Web Development
  elseif is_filetype_in_list(file_type, list_prettier) then
    vim.cmd("silent !prettier --write " .. vim.fn.shellescape(vim.fn.expand("%")))
  else
    print('Filetype not supported for fotmatting yet')
  end

end

-- Map <leader>fm to execute the function
vim.cmd('nnoremap <leader>fm :lua Run_formatter()<CR>')

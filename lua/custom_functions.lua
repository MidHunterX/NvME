-- ============================ [ @WRITE_FILE ] ============================ --

function WriteFile()
  local save_cursor = vim.fn.getpos(".")
  -- Remove trailing whitespace
  vim.cmd('%s/\\s\\+$//e')
  vim.cmd('nohlsearch')
  vim.fn.setpos(".", save_cursor)
  -- Save the current buffer
  vim.cmd('w')
end

vim.keymap.set("n", "<leader>w", ":lua WriteFile()<CR>")


-- ========================== [ @GIT_COMMIT_ALL ] ========================== --

function GitAddAndCommit()
  local commit_message = vim.fn.input('Enter commit message: ')
  -- Check if the commit message is empty
  if commit_message == '' then
    print('Commit message cannot be empty. Aborting.')
    return
  end
  -- Execute git commands
  vim.fn.system('git add .')
  vim.fn.system('git commit -m "' .. commit_message .. '"')
  print(' ✅')
end

-- Map <leader>gc to execute the function
vim.cmd('nnoremap <leader>gc :lua GitAddAndCommit()<CR>')


--============================[ @EXECUTE_FILES ]============================--

function Execute_order_69()
  local file_type = vim.bo.filetype
  if file_type == 'python' then
    vim.cmd(':vs')
    vim.cmd(':term python %')
  elseif file_type == "html" then
    vim.cmd(":term live-server --no-browser")
  elseif file_type == "sh" then
    vim.cmd(':vs')
    vim.cmd(":term bash %")
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
  local list_prettier = {
    "markdown", "html", "json",
    "javascript", "css",
    "javascriptreact"
  }

  -- pip Black Formatter: Python
  if file_type == "python" then
    vim.cmd("silent !black " .. vim.fn.shellescape(vim.fn.expand("%")))
  -- npm Prettier Formatter: Web Development
  elseif is_filetype_in_list(file_type, list_prettier) then
    vim.cmd("silent !prettier --write " .. vim.fn.shellescape(vim.fn.expand("%")))
  else
    print('Formatter not set-up')
  end
end

-- Map <leader>fm to execute the function
vim.cmd('nnoremap <leader>fm :lua Run_formatter()<CR>')

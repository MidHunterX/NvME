-- =========================== [ @TOGGLE_VALUE ] =========================== --

local toggles = {
  ["True"] = "False",
  ["true"] = "false",
  ["Yes"] = "No",
  ["yes"] = "no",
}

function ToggleValue(value)
  local toggled_value = value
  for k, v in pairs(toggles) do
    if string.find(toggled_value, k) then
      toggled_value = string.gsub(toggled_value, k, v, 1)
      break
    elseif string.find(toggled_value, v) then
      toggled_value = string.gsub(toggled_value, v, k, 1)
      break
    end
  end
  return toggled_value
end

function IncrementOrToggle()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_number = cursor[1]
  local col = cursor[2] + 1  -- Added 1 bc 0 val gives weird result
  local current_line = vim.fn.getline(line_number)
  local rest_of_line = string.sub(current_line, col)
  local toggled_value = ToggleValue(rest_of_line)
  if rest_of_line ~= toggled_value then
    -- Toggle value
    vim.api.nvim_set_current_line(string.sub(current_line, 1, col - 1) .. toggled_value)
  else
    -- Increment value
    local key = vim.api.nvim_replace_termcodes('<C-a>', true, false, true)
    vim.api.nvim_feedkeys(key, 'n', true)
  end
end

-- Map <C-a> to the IncrementOrToggle function
vim.keymap.set('n', '<C-a>', '<cmd>lua IncrementOrToggle()<CR>')


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

vim.keymap.set("n", "<leader>w", "<cmd>lua WriteFile()<CR>")


-- ========================== [ @GIT_COMMIT_ALL ] ========================== --

-- -- DEPRECATED: REPLACED WITH LAZYGIT
-- function GitAddAndCommit()
--   local commit_message = vim.fn.input('Enter commit message: ')
--   -- Check if the commit message is empty
--   if commit_message == '' then
--     print('Commit message cannot be empty. Aborting.')
--     return
--   end
--   -- Execute git commands
--   vim.fn.system('git add .')
--   vim.fn.system('git commit -m "' .. commit_message .. '"')
--   print(' ✅')
-- end

-- -- Map <leader>gc to execute the function
-- vim.cmd('nnoremap <leader>gc :lua GitAddAndCommit()<CR>')


--============================[ @EXECUTE_FILES ]============================--

function Execute_order_69()
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
    "markdown",
    "html",
    "json",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
    "less",
    "scss",
    "graphql",
    "yaml",
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

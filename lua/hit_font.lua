local data_hitfont = {
  "█▀█",
  "▀▀█",
  "█░█░█",
  "▀▄▀▄▀",
  "█▀▀",
  "██▄",
  "█▀█",
  "█▀▄",
  "▀█▀",
  "░█░",
  "█▄█",
  "░█░",
  "█░█",
  "█▄█",
  "█",
  "█",
  "█▀█",
  "█▄█",
  "█▀█",
  "█▀▀",
  "▄▀█",
  "█▀█",
  "█▀",
  "▄█",
  "█▀▄",
  "█▄▀",
  "█▀▀",
  "█▀░",
  "█▀▀",
  "█▄█",
  "█░█",
  "█▀█",
  "░░█",
  "█▄█",
  "█▄▀",
  "█░█",
  "█░░",
  "█▄▄",
  "▀█",
  "█▄",
  "▀▄▀",
  "█░█",
  "█▀▀",
  "█▄▄",
  "█░█",
  "▀▄▀",
  "█▄▄",
  "█▄█",
  "█▄░█",
  "█░▀█",
  "█▀▄▀█",
  "█░▀░█",
}

local function HitList()
  local lines = data_hitfont
  local characters = {}
  for i = 1, #lines, 2 do
    local character = lines[i] .. "\n" .. lines[i + 1]
    table.insert(characters, character)
  end
  return characters
end

local function ModernCaesar(sentence)
  local cipher = "qwertyuiopasdfghjklzxcvbnm "
  sentence = tostring(sentence):lower()
  local number_list = {}
  for i = 1, #sentence do
    local letter = sentence:sub(i, i)
    local index = cipher:find(letter, 1, true)
    if index ~= nil then
      table.insert(number_list, cipher:find(letter, 1, true) - 0)
    end
  end
  return number_list
end

function HitFont()
  local font = HitList()

  local line_number = vim.fn.line('.')
  local sentence = vim.fn.getline(line_number)

  -- io.write("String: ")
  -- local sentence = io.read()

  local cipher = ModernCaesar(sentence)
  local toprow = ""
  local botrow = ""
  for _, number in ipairs(cipher) do
    local top, bot
    if number ~= 27 then
      top, bot = string.match(font[number], "([^\n]+)\n([^\n]+)")
    else
      top = " "
      bot = " "
    end
    toprow = toprow .. top .. " "
    botrow = botrow .. bot .. " "
  end

  -- print(toprow)
  -- print(botrow)

  -- local hit_comment = toprow .. "\n" .. botrow .. "\n"
  -- vim.fn.setline(line_number, hit_comment)

  -- STRIP SPACES
  toprow = toprow:gsub("^%s*(.-)%s*$", "%1")
  botrow = botrow:gsub("^%s*(.-)%s*$", "%1")

  -- INSERT FONT IN NEOVIM BUFFER
  vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { toprow })
  vim.api.nvim_buf_set_lines(0, line_number, line_number, false, { botrow })
end

function LeetSpeak()
  local plain = "qwertyuiopasdfghjklzxcvbnm"
  local cipher = "QW3R7YU10P45DF6HJKLZXCVBNM"

  local line_number = vim.fn.line('.')
  local sentence = vim.fn.getline(line_number)

  local leet_sentence = ""

  for i = 1, #sentence do
    local letter = sentence:sub(i, i)
    local array_id = plain:find(letter, 1, true)
    if array_id then
      leet_sentence = leet_sentence .. cipher:sub(array_id, array_id)
    else
      leet_sentence = leet_sentence .. letter
    end
  end

  vim.fn.setline(line_number, leet_sentence)
end

-- COMMAND MAPPINGS
vim.cmd("command! HitFont lua HitFont()")
vim.cmd("command! LeetSpeak lua LeetSpeak()")

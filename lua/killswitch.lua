local function cmd_exists(cmd)
  return vim.fn.executable(cmd) == 1
end

return {
  -- is_x = cmd_exists("cmd_name"),   -- package-name
  ---------------------------------------------------
  is_kitty = cmd_exists("kitty"),     -- kitty
  is_mermaid = cmd_exists("mmdc"),    -- mermaid-cli
  is_vifm = cmd_exists("vifm"),       -- vifm
  is_lazygit = cmd_exists("lazygit"), -- git
  is_ripgrep = cmd_exists("rg"),      -- ripgrep
  is_fd = cmd_exists("fd"),           -- fd
}

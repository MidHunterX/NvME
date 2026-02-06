local function cmd_exists(cmd)
  return vim.fn.executable(cmd) == 1
end

return {
  is_kitty = cmd_exists("kitty"), -- kitty
  is_mermaid = cmd_exists("mmdc") -- mermaid-cli
}

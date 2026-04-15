local function cmd_exists(cmd)
  return vim.fn.executable(cmd) == 1
end

return {
  -- is_x = cmd_exists("cmd_name"),          -- package-name
  ----------------------------------------------------------
  is_git = cmd_exists("git"),                -- git
  is_kitty = cmd_exists("kitty"),            -- kitty
  is_mermaid = cmd_exists("mmdc"),           -- mermaid-cli
  is_vifm = cmd_exists("vifm"),              -- vifm
  is_lazygit = cmd_exists("lazygit"),        -- lazygit
  is_ripgrep = cmd_exists("rg"),             -- ripgrep
  is_fd = cmd_exists("fd"),                  -- fd
  is_gcc = cmd_exists("gcc"),                -- gcc
  is_zig = cmd_exists("zig"),                -- zig
  is_treesitter = cmd_exists("tree-sitter"), -- tree-sitter-cli
  is_node = cmd_exists("node"),              -- node
  is_liveserver = cmd_exists("live-server"), -- live-server
}

-- Usage:
-- local check = require('killswitch')
-- return {
--   "plugin_name",
--   enabled = check.is_kitty and check.is_mermaid,
--   ft = "markdown",
--   ...
-- }

local function cmd_exists(cmd)
  return vim.fn.executable(cmd) == 1
end

return {
  is_kitty = cmd_exists("kitty"),  -- kitty
  is_mermaid = cmd_exists("mmdc"), -- mermaid-cli
  is_vifm = cmd_exists("vifm"),    -- vifm
}

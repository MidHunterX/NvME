-- ASCIIDOC LIST ITEMS (using commentstrings)
vim.opt_local.comments = {
  "b:*",
  "b:**",
  "b:***",
  "b:****",
  "b:-",
  "b:.",
  "b:..",
  "b:...",
  "b:....",
  "n:>",
}
-- r → Continues the comment when pressing <Enter> inside a comment.
-- o → Continues the comment when opening a new line with o or O.
vim.opt_local.formatoptions:append("ro")

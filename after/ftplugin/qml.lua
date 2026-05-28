vim.lsp.config("qml-language-server", {
  cmd = { "qml-language-server" },
  filetypes = { "qml" },
  root_markers = { { "qmldir", "shell.qml" }, ".git" },
})

vim.lsp.enable("qml-language-server")

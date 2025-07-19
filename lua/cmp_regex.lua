local source = {}

function source:is_available()
  local filetype = vim.bo.filetype
  return filetype == 'spectre_panel'
end

-- Regular expressions use + by default as humans think this way by default.
-- * is used as an edge case where whatever being matched is optional
function source:complete(_, callback)
  local cmp = require('cmp')
  local cmp_snip = cmp.lsp.CompletionItemKind.Snippet
  callback({
    items = {
      { label = "any",            insertText = ".+",           kind = cmp_snip, documentation = "Match any character 1 or more times" },
      { label = "capture any",    insertText = "(.+)",         kind = cmp_snip, documentation = "Capture any character 1 or more times" },

      { label = "all",            insertText = ".*",           kind = cmp_snip, documentation = "Match all character 1 or more times" },
      { label = "capture all",    insertText = "(.*)",         kind = cmp_snip, documentation = "Capture all character 1 or more times" },

      { label = "num",            insertText = "[0-9]+",       kind = cmp_snip, documentation = "Match 1 or more numbers" },
      { label = "capture num",    insertText = "([0-9]+)",     kind = cmp_snip, documentation = "Capture 1 or more numbers" },

      { label = "word",           insertText = "[a-zA-Z]+",    kind = cmp_snip, documentation = "Match 1 word" },
      { label = "capture word",   insertText = "([a-zA-Z]+)",  kind = cmp_snip, documentation = "Capture 1 word" },

      { label = "words",          insertText = "[a-z A-Z]+",   kind = cmp_snip, documentation = "Match 1 or more words" },
      { label = "capture words",  insertText = "([a-z A-Z]+)", kind = cmp_snip, documentation = "Capture 1 or more words" },

      { label = "init",           insertText = "^$",           kind = cmp_snip, documentation = "Initialize regex" },
    },
    isIncomplete = false
  })
end

return source

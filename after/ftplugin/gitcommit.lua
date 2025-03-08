local cmp = require("cmp")
local cmp_gitcommit = require("cmp_gitcommit")

-- Register sources first
cmp.register_source("keywords_source", cmp_gitcommit.keywords_source())
cmp.register_source("scope_source", cmp_gitcommit.scope_source())

-- Set up nvim-cmp for gitcommit buffer
cmp.setup.buffer({
  sources = cmp.config.sources(
    {
      { name = "keywords_source" },
      { name = "scope_source" },
    },
    -- Get below sources only if previouss source are not available in menu
    {
      { name = "buffer" }
    }),
})

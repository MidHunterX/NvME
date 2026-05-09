-- Positives:
-- * Does one thing and does it well

return {
  "windwp/nvim-ts-autotag",
  ft = { 'astro', 'dot', 'glimmer', 'handlebars', 'html', 'javascript', 'jsx',
    'liquid', 'vento', 'markdown', 'php', 'rescript', 'svelte', 'tsx', 'twig',
    'typescript', 'vue', 'xml'
  },
  config = function()
    require('nvim-ts-autotag').setup({
      opts = {
        enable_close = true,          -- Auto close tags
        enable_rename = true,         -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
    })
  end,
}

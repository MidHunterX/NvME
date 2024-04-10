return {
  "dstein64/vim-startuptime",
  -- lazy-load on a command
  cmd = "StartupTime",
  init = function()
    vim.g.startuptime_tries = 10
  end,
}

return {
  "LunarVim/bigfile.nvim",
  event = "BufReadPre",
  opts = {
    filesize = 1, -- size of the file in MiB
  },
}

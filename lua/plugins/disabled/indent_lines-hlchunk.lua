-- Code Chunk highlighting (performance first)

return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true
      },
      indent = {
        enable = true
      },
      style = {
        { bg = "#FF0000", fg = "#FFFFFF" },
        { bg = "#FF7F00", fg = "FF7F00" },
      },
    })
  end
}

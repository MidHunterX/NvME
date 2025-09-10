local options = {
  -- Default AI popup type
  ---@type "popup" | "horizontal" | "vertical"
  popup_type = "vertical",

  -- Default provider
  ---@type "anthropic" | "copilot" | "deepseek" | "gemini" | "grok" | "ollama" | "openai"
  provider = "gemini",

  -- Default search engine
  ---@type "google" | "duck_duck_go" | "stack_overflow" | "github" | "phind" | "perplexity"
  search_engine = "google",
}

return {
  "piersolenski/wtf.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>wd",
      mode = { "n", "x" },
      function()
        -- If the window is too small, switch to horizontal
        if vim.fn.winwidth(0) < 100 then
          options.popup_type = "horizontal"
          require("wtf").setup(options)
        end

        require("wtf").diagnose()
      end,
      desc = "WTF: Debug with AI",
    },
    {
      "<leader>wf",
      mode = { "n", "x" },
      function()
        require("wtf").fix()
      end,
      desc = "WTF: Fix automatically with AI",
    },
    {
      mode = { "n" },
      "<leader>ws",
      function()
        require("wtf").search()
      end,
      desc = "WTF: Search with Google",
    },
    {
      mode = { "n" },
      "<leader>wp",
      function()
        require("wtf").pick_provider()
      end,
      desc = "WTF: Pick provider",
    },
  },
  opts = options,
}

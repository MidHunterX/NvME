-- Catppuccin Colors with OneDark Syntax highlighting
return {
  {
    "catppuccin/nvim",
    priority = 1000,

    opts = {
      transparent_background = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        dashboard = true,
        gitsigns = true,
        leap = true,
        mason = true,
        noice = true,
        notify = true,
        treesitter_context = true,
        treesitter = true,
        nvim_surround = true,
        render_markdown = true,
        snacks = {
          enabled = true,
        },
        which_key = false,
      },
      custom_highlights = function(colors)
        -- OneDark to Catppuccin Color Adapter
        local catppuccin_onedark_adapter = {
          -- onedark.palette
          black = colors.crust,
          bg0 = colors.mantle,
          bg1 = colors.base,
          bg2 = colors.surface0,
          bg3 = colors.surface1,
          bg_d = colors.base,
          bg_blue = colors.blue,
          bg_yellow = colors.yellow,
          fg = colors.text,
          purple = colors.mauve,
          green = colors.green,
          orange = colors.peach,
          blue = colors.blue,
          yellow = colors.yellow,
          cyan = colors.sky,
          red = colors.red,
          grey = colors.overlay2,
          light_grey = colors.subtext1,
          diff_add = colors.green,
          diff_delete = colors.red,
          diff_change = colors.yellow,
          diff_text = colors.blue,
        }

        local c = catppuccin_onedark_adapter

        return {
          -- groups/editor.lua
          -- Thoughts: Some tweaks to make Catppuccin more readable
          CurSearch = { bg = colors.maroon, fg = colors.mantle },
          LineNr = { fg = colors.overlay1 },
          Visual = { bg = colors.surface2, style = { "bold" } },

          -- ONEDARK
          -- source: onedark.nvim/lua/onedark/highlights.lua
          -- -----------------------------------------------

          -- onedark common
          -- Thoughts: Catppuccin's common colors does a wayy better job
          --[[
          Normal = { fg = c.fg },
          Terminal = { fg = c.fg },
          ...
          FloatBorder = { fg = c.grey, bg = c.bg1 },
          NormalFloat = { fg = c.fg, bg = c.bg1 },
          ]]

          -- onedark syntax
          -- Thoughts: Onedark has the best syntax highlighting.
          -- Every component is color separated really well.
          Array = { fg = c.yellow },
          Boolean = { fg = c.orange },
          Character = { fg = c.orange },
          Class = { fg = c.yellow },
          Color = { fg = c.green },
          Comment = { fg = c.grey },
          Conditional = { fg = c.purple },
          Constant = { fg = c.cyan },
          Constructor = { fg = c.blue },
          Define = { fg = c.purple },
          Delimiter = { fg = c.light_grey },
          Enum = { fg = c.purple },
          EnumMember = { fg = c.yellow },
          Error = { fg = c.purple },
          Event = { fg = c.yellow },
          Exception = { fg = c.purple },
          Field = { fg = c.purple },
          File = { fg = c.blue },
          Float = { fg = c.orange },
          Folder = { fg = c.orange },
          Function = { fg = c.blue },
          Identifier = { fg = c.red },
          Include = { fg = c.purple },
          Interface = { fg = c.green },
          Key = { fg = c.cyan },
          Keyword = { fg = c.purple },
          Label = { fg = c.purple },
          Macro = { fg = c.red },
          Method = { fg = c.blue },
          Module = { fg = c.orange },
          Namespace = { fg = c.red },
          Null = { fg = c.grey },
          Number = { fg = c.orange },
          Object = { fg = c.red },
          Operator = { fg = c.purple },
          Package = { fg = c.yellow },
          PreCondit = { fg = c.purple },
          PreProc = { fg = c.purple },
          Property = { fg = c.cyan },
          Reference = { fg = c.orange },
          Repeat = { fg = c.purple },
          Snippet = { fg = c.red },
          Special = { fg = c.red },
          SpecialChar = { fg = c.red },
          SpecialComment = { fg = c.grey },
          Statement = { fg = c.purple },
          StorageClass = { fg = c.yellow },
          String = { fg = c.green },
          Struct = { fg = c.purple },
          Structure = { fg = c.yellow },
          Tag = { fg = c.green },
          Text = { fg = c.light_grey },
          Title = { fg = c.cyan },
          Todo = { fg = c.red },
          Type = { fg = c.yellow },
          TypeParameter = { fg = c.red },
          Typedef = { fg = c.yellow },
          Unit = { fg = c.green },
          Value = { fg = c.orange },
          Variable = { fg = c.purple },

          -- onedark treesitter
          -- nvim-treesitter@0.9.2 and after
          ["@annotation"] = { fg = c.fg },
          ["@attribute"] = { fg = c.cyan },
          ["@attribute.typescript"] = c.Blue,
          ["@boolean"] = { fg = c.orange },
          ["@character"] = { fg = c.orange },
          ["@comment"] = { fg = c.grey },
          ["@comment.todo"] = { fg = c.red },
          ["@comment.todo.unchecked"] = { fg = c.red },
          ["@comment.todo.checked"] = { fg = c.green },
          ["@constant"] = { fg = c.orange },
          ["@constant.builtin"] = { fg = c.orange },
          ["@constant.macro"] = { fg = c.orange },
          ["@constructor"] = { fg = c.yellow, style = { "bold" } },
          -- Catppuccin handles diff colors similarly
          --[[
          ["@diff.add"] = hl.common.DiffAdded,
          ["@diff.delete"] = hl.common.DiffDeleted,
          ["@diff.plus"] = hl.common.DiffAdded,
          ["@diff.minus"] = hl.common.DiffDeleted,
          ["@diff.delta"] = hl.common.DiffChanged,
          ]]
          ["@error"] = { fg = c.fg },
          ["@function"] = { fg = c.blue },
          ["@function.builtin"] = { fg = c.cyan },
          ["@function.macro"] = { fg = c.cyan },
          ["@function.method"] = { fg = c.blue },
          ["@keyword"] = { fg = c.purple },
          ["@keyword.conditional"] = { fg = c.purple },
          ["@keyword.directive"] = { fg = c.purple },
          ["@keyword.exception"] = { fg = c.purple },
          ["@keyword.function"] = { fg = c.purple },
          ["@keyword.import"] = { fg = c.purple },
          ["@keyword.operator"] = { fg = c.purple },
          ["@keyword.repeat"] = { fg = c.purple },
          ["@label"] = { fg = c.red },
          -- Catppuccin's markdown colors are bit better
          --[[
          ["@markup.emphasis"] = { fg = c.fg, style = { 'italic' } },
          ["@markup.environment"] = { fg = c.fg },
          ["@markup.environment.name"] = { fg = c.fg },
          ["@markup.heading"] = { fg = c.orange, style = { 'bold' } },
          ["@markup.link"] = { fg = c.blue },
          ["@markup.link.url"] = { fg = c.cyan, style = { 'underline' } },
          ["@markup.list"] = { fg = c.red },
          ["@markup.math"] = { fg = c.fg },
          ["@markup.raw"] = { fg = c.green },
          ["@markup.strike"] = { fg = c.fg, style = { 'strikethrough' } },
          ["@markup.strong"] = { fg = c.fg, style = { 'bold' } },
          ["@markup.underline"] = { fg = c.fg, style = { 'underline' } },
          ]]
          ["@module"] = { fg = c.yellow },
          ["@none"] = { fg = c.fg },
          ["@number"] = { fg = c.orange },
          ["@number.float"] = { fg = c.orange },
          ["@operator"] = { fg = c.fg },
          ["@parameter.reference"] = { fg = c.fg },
          ["@property"] = { fg = c.cyan },
          ["@punctuation.delimiter"] = { fg = c.light_grey },
          ["@punctuation.bracket"] = { fg = c.light_grey },
          ["@string"] = { fg = c.green },
          ["@string.regexp"] = { fg = c.orange },
          ["@string.escape"] = { fg = c.red },
          ["@string.special.symbol"] = { fg = c.cyan },
          ["@tag"] = { fg = c.purple },
          ["@tag.attribute"] = { fg = c.yellow },
          ["@tag.delimiter"] = { fg = c.purple },
          ["@text"] = { fg = c.fg },
          ["@note"] = { fg = c.fg },
          ["@warning"] = { fg = c.fg },
          ["@danger"] = { fg = c.fg },
          ["@type"] = { fg = c.yellow },
          ["@type.builtin"] = { fg = c.orange },
          ["@variable"] = { fg = c.fg },
          ["@variable.builtin"] = { fg = c.red },
          ["@variable.member"] = { fg = c.cyan },
          ["@variable.parameter"] = { fg = c.red },
          -- Using Catppuccin's markdown heading colors instead
          --[[
          ["@markup.heading.1.markdown"] = { fg = c.red, style = { "bold" } },
          ["@markup.heading.2.markdown"] = { fg = c.purple, style = { "bold" } },
          ["@markup.heading.3.markdown"] = { fg = c.orange, style = { "bold" } },
          ["@markup.heading.4.markdown"] = { fg = c.red, style = { "bold" } },
          ["@markup.heading.5.markdown"] = { fg = c.purple, style = { "bold" } },
          ["@markup.heading.6.markdown"] = { fg = c.orange, style = { "bold" } },
          ["@markup.heading.1.marker.markdown"] = { fg = c.red, style = { "bold" } },
          ["@markup.heading.2.marker.markdown"] = { fg = c.purple, style = { "bold" } },
          ["@markup.heading.3.marker.markdown"] = { fg = c.orange, style = { "bold" } },
          ["@markup.heading.4.marker.markdown"] = { fg = c.red, style = { "bold" } },
          ["@markup.heading.5.marker.markdown"] = { fg = c.purple, style = { "bold" } },
          ["@markup.heading.6.marker.markdown"] = { fg = c.orange, style = { "bold" } },
          ]]
          -- Old configuration for nvim-treesiter@0.9.1 and below
          ["@conditional"] = { fg = c.purple },
          ["@exception"] = { fg = c.purple },
          ["@field"] = { fg = c.cyan },
          ["@float"] = { fg = c.orange },
          ["@include"] = { fg = c.purple },
          ["@method"] = { fg = c.blue },
          ["@namespace"] = { fg = c.yellow },
          ["@parameter"] = { fg = c.red },
          ["@preproc"] = { fg = c.purple },
          ["@punctuation.special"] = { fg = c.red },
          ["@repeat"] = { fg = c.purple },
          ["@string.regex"] = { fg = c.orange },
          ["@text.strong"] = { fg = c.fg, style = { 'bold' } },
          ["@text.emphasis"] = { fg = c.fg, style = { 'italic' } },
          ["@text.underline"] = { fg = c.fg, style = { 'underline' } },
          ["@text.strike"] = { fg = c.fg, style = { 'strikethrough' } },
          ["@text.title"] = { fg = c.orange, style = { 'bold' } },
          ["@text.literal"] = { fg = c.green },
          ["@text.uri"] = { fg = c.cyan, style = { 'underline' } },
          ["@text.todo"] = { fg = c.red },
          ["@text.todo.unchecked"] = { fg = c.red },
          ["@text.todo.checked"] = { fg = c.green },
          ["@text.math"] = { fg = c.fg },
          ["@text.reference"] = { fg = c.blue },
          ["@text.environment"] = { fg = c.fg },
          ["@text.environment.name"] = { fg = c.fg },
          ["@text.diff.add"] = { fg = c.green },
          ["@text.diff.delete"] = { fg = c.red },

          -- TREESITTER
          TSAnnotation = { fg = c.fg },
          TSAttribute = { fg = c.cyan },
          TSBoolean = { fg = c.orange },
          TSCharacter = { fg = c.orange },
          TSComment = { fg = c.grey },
          TSConditional = { fg = c.purple },
          TSConstant = { fg = c.orange },
          TSConstBuiltin = { fg = c.orange },
          TSConstMacro = { fg = c.orange },
          TSConstructor = { fg = c.yellow, style = { "bold" } },
          TSError = { fg = c.fg },
          TSException = { fg = c.purple },
          TSField = { fg = c.cyan },
          TSFloat = { fg = c.orange },
          TSFunction = { fg = c.blue },
          TSFuncBuiltin = { fg = c.cyan },
          TSFuncMacro = { fg = c.cyan },
          TSInclude = { fg = c.purple },
          TSKeyword = { fg = c.purple },
          TSKeywordFunction = { fg = c.purple },
          TSKeywordOperator = { fg = c.purple },
          TSLabel = { fg = c.red },
          TSMethod = { fg = c.blue },
          TSNamespace = { fg = c.yellow },
          TSNone = { fg = c.fg },
          TSNumber = { fg = c.orange },
          TSOperator = { fg = c.fg },
          TSParameter = { fg = c.red },
          TSParameterReference = { fg = c.fg },
          TSProperty = { fg = c.cyan },
          TSPunctDelimiter = { fg = c.light_grey },
          TSPunctBracket = { fg = c.light_grey },
          TSPunctSpecial = { fg = c.red },
          TSRepeat = { fg = c.purple },
          TSString = { fg = c.green },
          TSStringRegex = { fg = c.orange },
          TSStringEscape = { fg = c.red },
          TSSymbol = { fg = c.cyan },
          TSTag = { fg = c.purple },
          TSTagDelimiter = { fg = c.purple },
          TSText = { fg = c.fg },
          TSStrong = { fg = c.fg, style = { 'bold' } },
          TSEmphasis = { fg = c.fg, style = { 'italic' } },
          TSUnderline = { fg = c.fg, style = { 'underline' } },
          TSStrike = { fg = c.fg, style = { 'strikethrough' } },
          TSTitle = { fg = c.orange, style = { 'bold' } },
          TSLiteral = { fg = c.green },
          TSURI = { fg = c.cyan, style = { 'underline' } },
          TSMath = { fg = c.fg },
          TSTextReference = { fg = c.blue },
          TSEnvironment = { fg = c.fg },
          TSEnvironmentName = { fg = c.fg },
          TSNote = { fg = c.fg },
          TSWarning = { fg = c.fg },
          TSDanger = { fg = c.fg },
          TSType = { fg = c.yellow },
          TSTypeBuiltin = { fg = c.orange },
          TSVariable = { fg = c.fg },
          TSVariableBuiltin = { fg = c.red },
        }
      end,
      color_overrides = {
        mocha = {
          -- base color of: Current Line, render-markdown Heading etc.
          base = "#37383e",
          -- bg of: render-markdown Code Block
          mantle = "#242428",
          crust = "#181825",
        },
      },
    },

    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,

  },

  --[[ {
    -- OneDark with Catppuccin colors
    -- OneDark is so good at color consistency when it comes to syntax highlighting
    -- Catppuccin has nice bright colors
    -- navarasu/onedark.nvim doesn't work well with render-markdown.nvim
    -- and other plugins but catppuccin does.
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'dark',
        transparent = true,
        cmp_itemkind_reverse = false,
        colors = {
          fg = "#cdd6f4",
          light_gray = "#bac2de",
          gray = "#a6adc8",
          red = "#f38ba8",
          cyan = "#94e2d5",
          yellow = "#f9e2af",
          orange = "#fab387",
          green = "#a6e3a1",
          blue = "#89b4fa",
          purple = "#cba6f7",
        }
      }
      require('onedark').load()
    end
  }, ]]

}

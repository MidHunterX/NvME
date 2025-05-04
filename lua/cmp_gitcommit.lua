local M = {}

-- Custom CMP Source: gitcommit
local typesDict = {
  feat = {
    emoji = "✨",
    documentation =
    "Features\n" ..
    "MUST be used when a commit adds a new feature to your application or library.\n\n" ..
    "Use for:\n" ..
    "- Adding a new API endpoint.\n" ..
    "- Implementing a new UI component.\n" ..
    "- Creating a new command-line option.\n\n" ..
    "Alternatives:\n" ..
    "- Use `perf` if the change improves performance instead of adding new behavior.\n" ..
    "- Use `refactor` if restructuring existing code without adding new functionality.\n",
  },
  fix = {
    emoji = "🐛",
    documentation =
    "Bug Fixes\n" ..
    "MUST be used when a commit represents a bug fix for your application.\n\n" ..
    "Use for:\n" ..
    "- Fixing a crash or error in the application.\n" ..
    "- Resolving incorrect UI behavior.\n" ..
    "- Addressing a logic bug in business rules.\n\n" ..
    "Alternatives:\n" ..
    "- Use `revert` if rolling back a problematic commit.\n" ..
    "- Use `test` if modifying tests to prevent similar issues.\n",
  },
  docs = {
    emoji = "📝",
    documentation =
    "Documentation\n" ..
    "Changes related to documentation files only.\n\n" ..
    "Use for:\n" ..
    "- Updating the README or API documentation.\n" ..
    "- Adding inline comments in source code.\n" ..
    "- Correcting spelling errors in markdown files.\n\n" ..
    "Alternatives:\n" ..
    "- Use `chore` if updating non-code documentation such as contributor guidelines.\n",
  },
  style = {
    emoji = "💄",
    documentation =
    "Styles\n" ..
    "Changes that do not affect the meaning of the code, such as formatting or UI tweaks.\n\n" ..
    "Use for:\n" ..
    "- Fixing indentation, line breaks, or spacing.\n" ..
    "- Changing colors or typography in a UI component.\n" ..
    "- Removing extra semicolons in JavaScript.\n\n" ..
    "Alternatives:\n" ..
    "- Use `chore` for style updates related to tooling (e.g., Prettier, ESLint config).\n" ..
    "- Use `feat` if the UI change introduces new functionality.\n",
  },
  refactor = {
    emoji = "♻️",
    documentation =
    "Code Refactoring\n" ..
    "A code change that neither fixes a bug nor adds new functionality.\n\n" ..
    "Use for:\n" ..
    "- Simplifying complex code logic.\n" ..
    "- Extracting duplicated logic into a reusable function.\n" ..
    "- Improving code readability and maintainability.\n\n" ..
    "Alternatives:\n" ..
    "- Use `style` if the change is purely cosmetic (e.g., renaming variables).\n" ..
    "- Use `perf` if the refactor improves performance.\n",
  },
  perf = {
    emoji = "⚡️",
    documentation =
    "Performance Improvements\n" ..
    "A change that optimizes the speed or efficiency of the application.\n\n" ..
    "Use for:\n" ..
    "- Optimizing database queries.\n" ..
    "- Reducing the size of a bundle file.\n" ..
    "- Improving caching strategies.\n\n" ..
    "Alternatives:\n" ..
    "- Use `refactor` if the change is an internal restructuring without performance gain.\n",
  },
  test = {
    emoji = "✅",
    documentation =
    "Tests\n" ..
    "Adding, updating, or correcting tests for the application.\n\n" ..
    "Use for:\n" ..
    "- Adding unit tests for a new feature.\n" ..
    "- Fixing a failing test case.\n" ..
    "- Refactoring test logic for better coverage.\n\n" ..
    "Alternatives:\n" ..
    "- Use `fix` if modifying the test to reflect a bug fix in the code.\n",
  },
  build = {
    emoji = "🏗️",
    documentation =
    "Build System Changes\n" ..
    "Changes that affect the build system, such as dependency updates or build scripts.\n\n" ..
    "Use for:\n" ..
    "- Updating Webpack, Babel, or Rollup configurations.\n" ..
    "- Changing how the application is packaged.\n" ..
    "- Modifying Dockerfiles or build-related scripts.\n\n" ..
    "Alternatives:\n" ..
    "- Use `ci` if modifying CI/CD workflows instead of the build process.\n",
  },
  ci = {
    emoji = "👷",
    documentation =
    "Continuous Integration\n" ..
    "Changes to CI/CD pipelines, such as GitHub Actions, Jenkins, or Travis.\n\n" ..
    "Use for:\n" ..
    "- Adding or modifying GitHub Actions workflows.\n" ..
    "- Updating CI/CD environment variables.\n" ..
    "- Fixing pipeline issues that cause deployment failures.\n\n" ..
    "Alternatives:\n" ..
    "- Use `build` for changes related to the build process.\n" ..
    "- Use `chore` for general configuration updates.\n",
  },
  chore = {
    emoji = "🧹",
    documentation =
    "Chores\n" ..
    "Minor changes that don't modify application logic or user-facing behavior.\n\n" ..
    "Use for:\n" ..
    "- Updating dependencies in package.json.\n" ..
    "- Modifying `.gitignore` or `.editorconfig`.\n" ..
    "- Cleaning up old scripts or config files.\n\n" ..
    "Alternatives:\n" ..
    "- Use `build` for changes to build scripts and configurations.\n",
  },
  revert = {
    emoji = "⏪",
    documentation =
    "Reverts\n" ..
    "Undoing or rolling back a previous commit.\n\n" ..
    "Use for:\n" ..
    "- Reverting a commit that introduced a breaking change.\n" ..
    "- Undoing a merge that caused issues.\n" ..
    "- Restoring a deleted feature due to a mistake.\n\n" ..
    "Alternatives:\n" ..
    "- Use `fix` if modifying a commit instead of completely reverting it.\n",
  },
}

local function get_git_folders()
  local function is_git_repo()
    local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
    if not handle then return false end
    local result = handle:read("*a")
    handle:close()
    return result:match("true") ~= nil
  end
  -- No completion outside Git repo
  if not is_git_repo() then return {} end

  -- Get git folders and files  : {for(i=1;i<=NF;i++) print $i}
  -- Get git folders only       : {for(i=1;i<NF;i++) print $i}
  local handle = io.popen("git ls-files --cached --exclude-standard | awk -F'/' '{for(i=1;i<NF;i++) print $i}' | sort -u")

  if not handle then return {} end

  local result = {}
  for line in handle:lines() do
    if line ~= "" then table.insert(result, line) end
  end
  handle:close()
  return result
end

M.keywords_source = function()
  return setmetatable({}, {
    __index = function(_, key)
      if key == "complete" then
        return function(_, _, callback)
          local items = {}
          for k, v in pairs(typesDict) do
            table.insert(items, {
              label = v.emoji .. k,
              kind = require("cmp.types.lsp").CompletionItemKind.Keyword,
              documentation = v.documentation,
              -- insertText = k .. "(): " .. v.emoji .. " ",
              insertText = v.emoji .. " " .. k .. "(): ",
            })
          end
          callback({ items = items, isIncomplete = false })
        end
      end
    end,
  })
end

M.scope_source = function()
  return setmetatable({}, {
    __index = function(_, key)
      if key == "complete" then
        return function(_, _, callback)
          local items = {}
          for _, folder in ipairs(get_git_folders()) do
            table.insert(items, {
              label = folder,
              kind = require("cmp.types.lsp").CompletionItemKind.Folder,
            })
          end
          callback({ items = items, isIncomplete = false })
        end
      end
    end,
  })
end

return M

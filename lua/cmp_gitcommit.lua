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
  security = {
    emoji = "🔒",
    documentation =
    "Security\n" ..
    "Changes that improve the security of the application.\n\n" ..
    "Use for:\n" ..
    "- Fixing security vulnerabilities.\n" ..
    "- Adding authentication or authorization.\n" ..
    "- Updating dependencies for security patches.\n" ..
    "- Implementing input validation or sanitization.\n\n" ..
    "Alternatives:\n" ..
    "- Use `fix` if addressing a general bug that happens to be security-related.\n" ..
    "- Use `feat` if adding new security features.\n",
  },
  hotfix = {
    emoji = "🚑",
    documentation =
    "Hotfixes\n" ..
    "Critical fixes that need to be deployed immediately to production.\n\n" ..
    "Use for:\n" ..
    "- Fixing critical bugs in production.\n" ..
    "- Resolving application crashes or outages.\n" ..
    "- Emergency security patches.\n\n" ..
    "Alternatives:\n" ..
    "- Use `fix` for regular bug fixes that aren't critical.\n" ..
    "- Use `security` if the hotfix specifically addresses security issues.\n",
  },
  deps = {
    emoji = "📦",
    documentation =
    "Dependencies\n" ..
    "Adding, updating, or removing project dependencies.\n\n" ..
    "Use for:\n" ..
    "- Adding new npm/pip/gem packages.\n" ..
    "- Updating library versions.\n" ..
    "- Removing unused dependencies.\n" ..
    "- Lock file updates.\n\n" ..
    "Alternatives:\n" ..
    "- Use `chore` for general maintenance tasks.\n" ..
    "- Use `security` if updating deps for security reasons.\n",
  },
  config = {
    emoji = "🔧",
    documentation =
    "Configuration\n" ..
    "Changes to configuration files and settings.\n\n" ..
    "Use for:\n" ..
    "- Modifying environment variables.\n" ..
    "- Updating configuration files (eslint, prettier, etc.).\n" ..
    "- Changing application settings.\n" ..
    "- Database configuration updates.\n\n" ..
    "Alternatives:\n" ..
    "- Use `chore` for minor config cleanup.\n" ..
    "- Use `build` for build-specific configuration.\n",
  },
  init = {
    emoji = "🎉",
    documentation =
    "Initial Commit\n" ..
    "The very first commit of a project or major milestone.\n\n" ..
    "Use for:\n" ..
    "- Project initialization.\n" ..
    "- Setting up basic project structure.\n" ..
    "- First commit after major restructuring.\n\n" ..
    "Alternatives:\n" ..
    "- Use `feat` for adding new features after initialization.\n" ..
    "- Use `chore` for setup tasks in established projects.\n",
  },
  breaking = {
    emoji = "💥",
    documentation =
    "Breaking Changes\n" ..
    "Changes that break backward compatibility.\n\n" ..
    "Use for:\n" ..
    "- API changes that break existing clients.\n" ..
    "- Removing deprecated features.\n" ..
    "- Major refactoring that changes public interfaces.\n\n" ..
    "Alternatives:\n" ..
    "- Use `feat` with BREAKING CHANGE footer for new features that break compatibility.\n" ..
    "- Use `refactor` for internal changes that don't affect public API.\n",
  },
  wip = {
    emoji = "🚧",
    documentation =
    "Work in Progress\n" ..
    "Incomplete work that needs to be committed for backup or collaboration.\n\n" ..
    "Use for:\n" ..
    "- Saving progress on a feature branch.\n" ..
    "- Sharing incomplete work with teammates.\n" ..
    "- Checkpoint commits during long development.\n\n" ..
    "Alternatives:\n" ..
    "- Use appropriate type (feat, fix, etc.) when the work is complete.\n" ..
    "- Consider using draft PRs instead of WIP commits.\n",
  },
  analytics = {
    emoji = "📊",
    documentation =
    "Analytics and Tracking\n" ..
    "Adding or modifying analytics, metrics, or tracking code.\n\n" ..
    "Use for:\n" ..
    "- Adding Google Analytics or similar tracking.\n" ..
    "- Implementing custom metrics collection.\n" ..
    "- Adding logging for business intelligence.\n" ..
    "- Performance monitoring setup.\n\n" ..
    "Alternatives:\n" ..
    "- Use `feat` if analytics is a core feature.\n" ..
    "- Use `config` for analytics configuration changes.\n",
  },
  merge = {
    emoji = "🔀",
    documentation =
    "Merge\n" ..
    "Merging branches or resolving merge conflicts.\n\n" ..
    "Use for:\n" ..
    "- Merge commits from pull requests.\n" ..
    "- Resolving merge conflicts.\n" ..
    "- Combining feature branches.\n\n" ..
    "Alternatives:\n" ..
    "- Most git tools automatically handle merge commit messages.\n" ..
    "- Use specific types for the actual changes being merged.\n",
  },
  ui = {
    emoji = "🎨",
    documentation =
    "UI/UX Changes\n" ..
    "Changes focused on user interface and user experience improvements.\n\n" ..
    "Use for:\n" ..
    "- Updating UI components for better usability.\n" ..
    "- Redesigning layouts or visual elements.\n" ..
    "- Improving accessibility features.\n" ..
    "- Adding responsive design improvements.\n\n" ..
    "Alternatives:\n" ..
    "- Use `style` for purely cosmetic changes without UX impact.\n" ..
    "- Use `feat` if adding entirely new UI functionality.\n",
  },
  i18n = {
    emoji = "🌐",
    documentation =
    "Internationalization\n" ..
    "Adding or updating translations and locale support.\n\n" ..
    "Use for:\n" ..
    "- Adding new language translations.\n" ..
    "- Updating existing translation strings.\n" ..
    "- Adding locale-specific formatting.\n" ..
    "- Implementing RTL (right-to-left) support.\n\n" ..
    "Alternatives:\n" ..
    "- Use `feat` if adding internationalization capability for the first time.\n" ..
    "- Use `fix` if correcting translation errors.\n",
  },
  a11y = {
    emoji = "♿",
    documentation =
    "Accessibility\n" ..
    "Improving accessibility for users with disabilities.\n\n" ..
    "Use for:\n" ..
    "- Adding ARIA labels and roles.\n" ..
    "- Improving keyboard navigation.\n" ..
    "- Adding alt text to images.\n" ..
    "- Fixing color contrast issues.\n\n" ..
    "Alternatives:\n" ..
    "- Use `fix` if addressing accessibility bugs.\n" ..
    "- Use `feat` if adding new accessibility features.\n",
  },
  data = {
    emoji = "🗃️",
    documentation =
    "Data\n" ..
    "Changes related to data handling, migration, or seeding.\n\n" ..
    "Use for:\n" ..
    "- Database schema migrations.\n" ..
    "- Adding seed data or fixtures.\n" ..
    "- Data transformation scripts.\n" ..
    "- Updating static data files.\n\n" ..
    "Alternatives:\n" ..
    "- Use `feat` if adding new data-related functionality.\n" ..
    "- Use `fix` if correcting data issues.\n",
  },
  deploy = {
    emoji = "🚀",
    documentation =
    "Deployment\n" ..
    "Changes related to deployment scripts and infrastructure.\n\n" ..
    "Use for:\n" ..
    "- Updating deployment scripts.\n" ..
    "- Modifying infrastructure as code.\n" ..
    "- Adding deployment configurations.\n" ..
    "- Container orchestration changes.\n\n" ..
    "Alternatives:\n" ..
    "- Use `ci` for CI/CD pipeline changes.\n" ..
    "- Use `config` for environment-specific configurations.\n",
  },
  seed = {
    emoji = "🌱",
    documentation =
    "Database Seeding\n" ..
    "Adding or updating database seed data and fixtures.\n\n" ..
    "Use for:\n" ..
    "- Creating database seed files.\n" ..
    "- Updating test fixtures.\n" ..
    "- Adding sample data for development.\n" ..
    "- Migration seed data.\n\n" ..
    "Alternatives:\n" ..
    "- Use `data` for general data-related changes.\n" ..
    "- Use `test` if seeds are specifically for testing.\n",
  },
  license = {
    emoji = "📄",
    documentation =
    "License\n" ..
    "Changes related to project licensing and legal files.\n\n" ..
    "Use for:\n" ..
    "- Adding or updating LICENSE file.\n" ..
    "- Updating copyright notices.\n" ..
    "- Adding third-party license acknowledgments.\n" ..
    "- Legal compliance updates.\n\n" ..
    "Alternatives:\n" ..
    "- Use `docs` for general documentation updates.\n" ..
    "- Use `chore` for minor legal file maintenance.\n",
  },
  typo = {
    emoji = "✏️",
    documentation =
    "Typo Fixes\n" ..
    "Fixing typos in code, comments, or documentation.\n\n" ..
    "Use for:\n" ..
    "- Correcting spelling mistakes in comments.\n" ..
    "- Fixing typos in variable or function names.\n" ..
    "- Correcting documentation typos.\n" ..
    "- Fixing spelling in user-facing text.\n\n" ..
    "Alternatives:\n" ..
    "- Use `docs` for documentation-specific typo fixes.\n" ..
    "- Use `style` if the typo fix involves code formatting.\n",
  },
  api = {
    emoji = "🔌",
    documentation =
    "API Changes\n" ..
    "Changes specifically related to API endpoints and integrations.\n\n" ..
    "Use for:\n" ..
    "- Adding new API endpoints.\n" ..
    "- Modifying existing API responses.\n" ..
    "- Adding third-party API integrations.\n" ..
    "- API versioning changes.\n\n" ..
    "Alternatives:\n" ..
    "- Use `feat` for new API features.\n" ..
    "- Use `fix` for API bug fixes.\n" ..
    "- Use `breaking` for API changes that break compatibility.\n",
  },
  mock = {
    emoji = "🎭",
    documentation =
    "Mock Data\n" ..
    "Adding or updating mock data for testing and development.\n\n" ..
    "Use for:\n" ..
    "- Creating mock API responses.\n" ..
    "- Adding test data generators.\n" ..
    "- Updating development fixtures.\n" ..
    "- Adding placeholder content.\n\n" ..
    "Alternatives:\n" ..
    "- Use `test` if mocks are specifically for unit testing.\n" ..
    "- Use `seed` for database seeding.\n",
  },
  experiment = {
    emoji = "🧪",
    documentation =
    "Experiments\n" ..
    "Experimental features or A/B testing implementations.\n\n" ..
    "Use for:\n" ..
    "- Adding feature flags for experiments.\n" ..
    "- Implementing A/B test variants.\n" ..
    "- Adding experimental features.\n" ..
    "- Research and development code.\n\n" ..
    "Alternatives:\n" ..
    "- Use `feat` when experimental features become stable.\n" ..
    "- Use `wip` for incomplete experimental work.\n",
  },
  cleanup = {
    emoji = "🧽",
    documentation =
    "Code Cleanup\n" ..
    "Cleaning up code without changing functionality.\n\n" ..
    "Use for:\n" ..
    "- Removing commented-out code.\n" ..
    "- Cleaning up unused imports.\n" ..
    "- Removing deprecated code.\n" ..
    "- General code housekeeping.\n\n" ..
    "Alternatives:\n" ..
    "- Use `refactor` for structural improvements.\n" ..
    "- Use `chore` for maintenance tasks.\n",
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
              -- AUTOCOMPLETION LIST ENTRIES
              label = v.emoji .. " " .. k,
              kind = require("cmp.types.lsp").CompletionItemKind.Keyword,
              documentation = v.documentation,
              -- AUTOCOMPLETE SNIPPET
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

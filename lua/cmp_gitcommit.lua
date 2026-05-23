local M = {}

-- conventional commit types (intent)
local intentDocs = {
  feat =
      "Features\n" ..
      "MUST be used when a commit adds a new feature to your application or library.\n" ..
      "\nUse for:\n" ..
      "- Adding a new API endpoint.\n" ..
      "- Implementing a new UI component.\n" ..
      "- Creating a new command-line option.\n" ..
      "\nAlternatives:\n" ..
      "- Use `perf` if the change improves performance instead of adding new behavior.\n" ..
      "- Use `refactor` if restructuring existing code without adding new functionality.\n",
  fix =
      "Bug Fixes\n" ..
      "MUST be used when a commit represents a bug fix for your application.\n" ..
      "\nUse for:\n" ..
      "- Fixing a crash or error in the application.\n" ..
      "- Resolving incorrect UI behavior.\n" ..
      "- Addressing a logic bug in business rules.\n" ..
      "\nAlternatives:\n" ..
      "- Use `revert` if rolling back a problematic commit.\n" ..
      "- Use `test` if modifying tests to prevent similar issues.\n",
  docs =
      "Documentation\n" ..
      "Changes related to documentation files only.\n" ..
      "\nUse for:\n" ..
      "- Updating the README or API documentation.\n" ..
      "- Adding inline comments in source code.\n" ..
      "- Correcting spelling errors in markdown files.\n" ..
      "\nAlternatives:\n" ..
      "- Use `chore` if updating non-code documentation such as contributor guidelines.\n",
  style =
      "Styles\n" ..
      "Changes that do not affect the meaning of the code, such as formatting or UI tweaks.\n" ..
      "\nUse for:\n" ..
      "- Fixing indentation, line breaks, or spacing.\n" ..
      "- Changing colors or typography in a UI component.\n" ..
      "- Removing extra semicolons in JavaScript.\n" ..
      "\nAlternatives:\n" ..
      "- Use `chore` for style updates related to tooling (e.g., Prettier, ESLint config).\n" ..
      "- Use `feat` if the UI change introduces new functionality.\n",
  refactor =
      "Code Refactoring\n" ..
      "A code change that neither fixes a bug nor adds new functionality.\n" ..
      "\nUse for:\n" ..
      "- Simplifying complex code logic.\n" ..
      "- Extracting duplicated logic into a reusable function.\n" ..
      "- Improving code readability and maintainability.\n" ..
      "\nAlternatives:\n" ..
      "- Use `style` if the change is purely cosmetic (e.g., renaming variables).\n" ..
      "- Use `perf` if the refactor improves performance.\n",
  perf =
      "Performance Improvements\n" ..
      "A change that optimizes the speed or efficiency of the application.\n" ..
      "\nUse for:\n" ..
      "- Optimizing database queries.\n" ..
      "- Reducing the size of a bundle file.\n" ..
      "- Improving caching strategies.\n" ..
      "\nAlternatives:\n" ..
      "- Use `refactor` if the change is an internal restructuring without performance gain.\n",
  test =
      "Tests\n" ..
      "Adding, updating, or correcting tests for the application.\n" ..
      "\nUse for:\n" ..
      "- Adding unit tests for a new feature.\n" ..
      "- Fixing a failing test case.\n" ..
      "- Refactoring test logic for better coverage.\n" ..
      "\nAlternatives:\n" ..
      "- Use `fix` if modifying the test to reflect a bug fix in the code.\n",
  build =
      "Build System Changes\n" ..
      "Changes that affect the build system, such as dependency updates or build scripts.\n" ..
      "\nUse for:\n" ..
      "- Updating Webpack, Babel, or Rollup configurations.\n" ..
      "- Changing how the application is packaged.\n" ..
      "- Modifying Dockerfiles or build-related scripts.\n" ..
      "\nAlternatives:\n" ..
      "- Use `ci` if modifying CI/CD workflows instead of the build process.\n",
  ci =
      "Continuous Integration\n" ..
      "Changes to CI/CD pipelines, such as GitHub Actions, Jenkins, or Travis.\n" ..
      "\nUse for:\n" ..
      "- Adding or modifying GitHub Actions workflows.\n" ..
      "- Updating CI/CD environment variables.\n" ..
      "- Fixing pipeline issues that cause deployment failures.\n" ..
      "\nAlternatives:\n" ..
      "- Use `build` for changes related to the build process.\n" ..
      "- Use `chore` for general configuration updates.\n",
  chore =
      "Chores\n" ..
      "Minor changes that don't modify application logic or user-facing behavior.\n" ..
      "\nUse for:\n" ..
      "- Updating dependencies in package.json.\n" ..
      "- Modifying `.gitignore` or `.editorconfig`.\n" ..
      "- Cleaning up old scripts or config files.\n" ..
      "\nAlternatives:\n" ..
      "- Use `build` for changes to build scripts and configurations.\n",
  revert =
      "Reverts\n" ..
      "Undoing or rolling back a previous commit.\n" ..
      "\nUse for:\n" ..
      "- Reverting a commit that introduced a breaking change.\n" ..
      "- Undoing a merge that caused issues.\n" ..
      "- Restoring a deleted feature due to a mistake.\n" ..
      "\nAlternatives:\n" ..
      "- Use `fix` if modifying a commit instead of completely reverting it.\n",
  security =
      "Security\n" ..
      "Changes that improve the security of the application.\n" ..
      "\nUse for:\n" ..
      "- Fixing security vulnerabilities.\n" ..
      "- Adding authentication or authorization.\n" ..
      "- Updating dependencies for security patches.\n" ..
      "- Implementing input validation or sanitization.\n" ..
      "\nAlternatives:\n" ..
      "- Use `fix` if addressing a general bug that happens to be security-related.\n" ..
      "- Use `feat` if adding new security features.\n",
  hotfix =
      "Hotfixes\n" ..
      "Critical fixes that need to be deployed immediately to production.\n" ..
      "\nUse for:\n" ..
      "- Fixing critical bugs in production.\n" ..
      "- Resolving application crashes or outages.\n" ..
      "- Emergency security patches.\n" ..
      "\nAlternatives:\n" ..
      "- Use `fix` for regular bug fixes that aren't critical.\n" ..
      "- Use `security` if the hotfix specifically addresses security issues.\n",
  deps =
      "Dependencies\n" ..
      "Adding, updating, or removing project dependencies.\n" ..
      "\nUse for:\n" ..
      "- Adding new npm/pip/gem packages.\n" ..
      "- Updating library versions.\n" ..
      "- Removing unused dependencies.\n" ..
      "- Lock file updates.\n" ..
      "\nAlternatives:\n" ..
      "- Use `chore` for general maintenance tasks.\n" ..
      "- Use `security` if updating deps for security reasons.\n",
  config =
      "Configuration\n" ..
      "Changes to configuration files and settings.\n" ..
      "\nUse for:\n" ..
      "- Modifying environment variables.\n" ..
      "- Updating configuration files (eslint, prettier, etc.).\n" ..
      "- Changing application settings.\n" ..
      "- Database configuration updates.\n" ..
      "\nAlternatives:\n" ..
      "- Use `chore` for minor config cleanup.\n" ..
      "- Use `build` for build-specific configuration.\n",
  init =
      "Initial Commit\n" ..
      "The very first commit of a project or major milestone.\n" ..
      "\nUse for:\n" ..
      "- Project initialization.\n" ..
      "- Setting up basic project structure.\n" ..
      "- First commit after major restructuring.\n" ..
      "\nAlternatives:\n" ..
      "- Use `feat` for adding new features after initialization.\n" ..
      "- Use `chore` for setup tasks in established projects.\n",
  breaking =
      "Breaking Changes\n" ..
      "Changes that break backward compatibility.\n" ..
      "\nUse for:\n" ..
      "- API changes that break existing clients.\n" ..
      "- Removing deprecated features.\n" ..
      "- Major refactoring that changes public interfaces.\n" ..
      "\nAlternatives:\n" ..
      "- Use `feat` with BREAKING CHANGE footer for new features that break compatibility.\n" ..
      "- Use `refactor` for internal changes that don't affect public API.\n",
  wip =
      "Work in Progress\n" ..
      "Incomplete work that needs to be committed for backup or collaboration.\n" ..
      "\nUse for:\n" ..
      "- Saving progress on a feature branch.\n" ..
      "- Sharing incomplete work with teammates.\n" ..
      "- Checkpoint commits during long development.\n" ..
      "\nAlternatives:\n" ..
      "- Use appropriate type (feat, fix, etc.) when the work is complete.\n" ..
      "- Consider using draft PRs instead of WIP commits.\n",
  analytics =
      "Analytics and Tracking\n" ..
      "Adding or modifying analytics, metrics, or tracking code.\n" ..
      "\nUse for:\n" ..
      "- Adding Google Analytics or similar tracking.\n" ..
      "- Implementing custom metrics collection.\n" ..
      "- Adding logging for business intelligence.\n" ..
      "- Performance monitoring setup.\n" ..
      "\nAlternatives:\n" ..
      "- Use `feat` if analytics is a core feature.\n" ..
      "- Use `config` for analytics configuration changes.\n",
  merge =
      "Merge\n" ..
      "Merging branches or resolving merge conflicts.\n" ..
      "\nUse for:\n" ..
      "- Merge commits from pull requests.\n" ..
      "- Resolving merge conflicts.\n" ..
      "- Combining feature branches.\n" ..
      "\nAlternatives:\n" ..
      "- Most git tools automatically handle merge commit messages.\n" ..
      "- Use specific types for the actual changes being merged.\n",
  ui =
      "UI/UX Changes\n" ..
      "Changes focused on user interface and user experience improvements.\n" ..
      "\nUse for:\n" ..
      "- Updating UI components for better usability.\n" ..
      "- Redesigning layouts or visual elements.\n" ..
      "- Improving accessibility features.\n" ..
      "- Adding responsive design improvements.\n" ..
      "\nAlternatives:\n" ..
      "- Use `style` for purely cosmetic changes without UX impact.\n" ..
      "- Use `feat` if adding entirely new UI functionality.\n",
  i18n =
      "Internationalization\n" ..
      "Adding or updating translations and locale support.\n" ..
      "\nUse for:\n" ..
      "- Adding new language translations.\n" ..
      "- Updating existing translation strings.\n" ..
      "- Adding locale-specific formatting.\n" ..
      "- Implementing RTL (right-to-left) support.\n" ..
      "\nAlternatives:\n" ..
      "- Use `feat` if adding internationalization capability for the first time.\n" ..
      "- Use `fix` if correcting translation errors.\n",
  a11y =
      "Accessibility\n" ..
      "Improving accessibility for users with disabilities.\n" ..
      "\nUse for:\n" ..
      "- Adding ARIA labels and roles.\n" ..
      "- Improving keyboard navigation.\n" ..
      "- Adding alt text to images.\n" ..
      "- Fixing color contrast issues.\n" ..
      "\nAlternatives:\n" ..
      "- Use `fix` if addressing accessibility bugs.\n" ..
      "- Use `feat` if adding new accessibility features.\n",
  data =
      "Data\n" ..
      "Changes related to data handling, migration, or seeding.\n" ..
      "\nUse for:\n" ..
      "- Database schema migrations.\n" ..
      "- Adding seed data or fixtures.\n" ..
      "- Data transformation scripts.\n" ..
      "- Updating static data files.\n" ..
      "\nAlternatives:\n" ..
      "- Use `feat` if adding new data-related functionality.\n" ..
      "- Use `fix` if correcting data issues.\n",
  deploy =
      "Deployment\n" ..
      "Changes related to deployment scripts and infrastructure.\n" ..
      "\nUse for:\n" ..
      "- Updating deployment scripts.\n" ..
      "- Modifying infrastructure as code.\n" ..
      "- Adding deployment configurations.\n" ..
      "- Container orchestration changes.\n" ..
      "\nAlternatives:\n" ..
      "- Use `ci` for CI/CD pipeline changes.\n" ..
      "- Use `config` for environment-specific configurations.\n",
  seed =
      "Database Seeding\n" ..
      "Adding or updating database seed data and fixtures.\n" ..
      "\nUse for:\n" ..
      "- Creating database seed files.\n" ..
      "- Updating test fixtures.\n" ..
      "- Adding sample data for development.\n" ..
      "- Migration seed data.\n" ..
      "\nAlternatives:\n" ..
      "- Use `data` for general data-related changes.\n" ..
      "- Use `test` if seeds are specifically for testing.\n",
  license =
      "License\n" ..
      "Changes related to project licensing and legal files.\n" ..
      "\nUse for:\n" ..
      "- Adding or updating LICENSE file.\n" ..
      "- Updating copyright notices.\n" ..
      "- Adding third-party license acknowledgments.\n" ..
      "- Legal compliance updates.\n" ..
      "\nAlternatives:\n" ..
      "- Use `docs` for general documentation updates.\n" ..
      "- Use `chore` for minor legal file maintenance.\n",
  typo =
      "Typo Fixes\n" ..
      "Fixing typos in code, comments, or documentation.\n" ..
      "\nUse for:\n" ..
      "- Correcting spelling mistakes in comments.\n" ..
      "- Fixing typos in variable or function names.\n" ..
      "- Correcting documentation typos.\n" ..
      "- Fixing spelling in user-facing text.\n" ..
      "\nAlternatives:\n" ..
      "- Use `docs` for documentation-specific typo fixes.\n" ..
      "- Use `style` if the typo fix involves code formatting.\n",
  api =
      "API Changes\n" ..
      "Changes specifically related to API endpoints and integrations.\n" ..
      "\nUse for:\n" ..
      "- Adding new API endpoints.\n" ..
      "- Modifying existing API responses.\n" ..
      "- Adding third-party API integrations.\n" ..
      "- API versioning changes.\n" ..
      "\nAlternatives:\n" ..
      "- Use `feat` for new API features.\n" ..
      "- Use `fix` for API bug fixes.\n" ..
      "- Use `breaking` for API changes that break compatibility.\n",
  mock =
      "Mock Data\n" ..
      "Adding or updating mock data for testing and development.\n" ..
      "\nUse for:\n" ..
      "- Creating mock API responses.\n" ..
      "- Adding test data generators.\n" ..
      "- Updating development fixtures.\n" ..
      "- Adding placeholder content.\n" ..
      "\nAlternatives:\n" ..
      "- Use `test` if mocks are specifically for unit testing.\n" ..
      "- Use `seed` for database seeding.\n",
  experiment =
      "Experiments\n" ..
      "Experimental features or A/B testing implementations.\n" ..
      "\nUse for:\n" ..
      "- Adding feature flags for experiments.\n" ..
      "- Implementing A/B test variants.\n" ..
      "- Adding experimental features.\n" ..
      "- Research and development code.\n" ..
      "\nAlternatives:\n" ..
      "- Use `feat` when experimental features become stable.\n" ..
      "- Use `wip` for incomplete experimental work.\n",
  cleanup =
      "Code Cleanup\n" ..
      "Cleaning up code without changing functionality.\n" ..
      "\nUse for:\n" ..
      "- Removing commented-out code.\n" ..
      "- Cleaning up unused imports.\n" ..
      "- Removing deprecated code.\n" ..
      "- General code housekeeping.\n" ..
      "\nAlternatives:\n" ..
      "- Use `refactor` for structural improvements.\n" ..
      "- Use `chore` for maintenance tasks.\n",
  release =
      "Releases\n" ..
      "Commits that release a new version or tag.\n" ..
      "\nUse for:\n" ..
      "- Version bumps.\n" ..
      "- Changelog generation commits.\n" ..
      "- Git tags formatting.\n",
  seo =
      "SEO Improvements\n" ..
      "Changes aiming to improve search engine optimization.\n" ..
      "\nUse for:\n" ..
      "- Modifying meta tags.\n" ..
      "- Fixing sitemaps or robots.txt.\n" ..
      "- Adding structured data.\n",
  types =
      "Types & Typings\n" ..
      "Changes to type definitions.\n" ..
      "\nUse for:\n" ..
      "- Adding or updating TypeScript/Flow types.\n" ..
      "- Fixing type warnings.\n",
}

-- Gitmoji + conventional commit
local gitmojis = {
  art = { emoji = "🎨", intent = "style", description = "Improve structure / format of the code." },
  zap = { emoji = "⚡️", intent = "perf", description = "Improve performance." },
  fire = { emoji = "🔥", intent = "cleanup", description = "Remove code or files." },
  bug = { emoji = "🐛", intent = "fix", description = "Fix a bug." },
  ambulance = { emoji = "🚑️", intent = "hotfix", description = "Critical hotfix." },
  sparkles = { emoji = "✨", intent = "feat", description = "Introduce new features." },
  memo = { emoji = "📝", intent = "docs", description = "Add or update documentation." },
  rocket = { emoji = "🚀", intent = "deploy", description = "Deploy stuff." },
  lipstick = { emoji = "💄", intent = "ui", description = "Add or update the UI and style files." },
  tada = { emoji = "🎉", intent = "init", description = "Begin a project." },
  white_check_mark = { emoji = "✅", intent = "test", description = "Add, update, or pass tests." },
  lock = { emoji = "🔒️", intent = "security", description = "Fix security or privacy issues." },
  closed_lock_with_key = { emoji = "🔐", intent = "security", description = "Add or update secrets." },
  bookmark = { emoji = "🔖", intent = "release", description = "Release / Version tags." },
  rotating_light = { emoji = "🚨", intent = "fix", description = "Fix compiler / linter warnings." },
  construction = { emoji = "🚧", intent = "wip", description = "Work in progress." },
  green_heart = { emoji = "💚", intent = "ci", description = "Fix CI Build." },
  arrow_down = { emoji = "⬇️", intent = "deps", description = "Downgrade dependencies." },
  arrow_up = { emoji = "⬆️", intent = "deps", description = "Upgrade dependencies." },
  pushpin = { emoji = "📌", intent = "deps", description = "Pin dependencies to specific versions." },
  construction_worker = { emoji = "👷", intent = "ci", description = "Add or update CI build system." },
  chart_with_upwards_trend = { emoji = "📈", intent = "analytics", description = "Add or update analytics or track code." },
  recycle = { emoji = "♻️", intent = "refactor", description = "Refactor code." },
  heavy_plus_sign = { emoji = "➕", intent = "deps", description = "Add a dependency." },
  heavy_minus_sign = { emoji = "➖", intent = "deps", description = "Remove a dependency." },
  wrench = { emoji = "🔧", intent = "config", description = "Add or update configuration files." },
  hammer = { emoji = "🔨", intent = "build", description = "Add or update development scripts." },
  globe_with_meridians = { emoji = "🌐", intent = "i18n", description = "Internationalization and localization." },
  pencil2 = { emoji = "✏️", intent = "typo", description = "Fix typos." },
  poop = { emoji = "💩", intent = "cleanup", description = "Write bad code that needs to be improved." },
  rewind = { emoji = "⏪️", intent = "revert", description = "Revert changes." },
  twisted_rightwards_arrows = { emoji = "🔀", intent = "merge", description = "Merge branches." },
  package = { emoji = "📦️", intent = "build", description = "Add or update compiled files or packages." },
  alien = { emoji = "👽️", intent = "api", description = "Update code due to external API changes." },
  truck = { emoji = "🚚", intent = "refactor", description = "Move or rename resources (e.g.: files, paths, routes)." },
  page_facing_up = { emoji = "📄", intent = "license", description = "Add or update license." },
  boom = { emoji = "💥", intent = "breaking", description = "Introduce breaking changes." },
  bento = { emoji = "🍱", intent = "ui", description = "Add or update assets." },
  wheelchair = { emoji = "♿️", intent = "a11y", description = "Improve accessibility." },
  bulb = { emoji = "💡", intent = "docs", description = "Add or update comments in source code." },
  beers = { emoji = "🍻", intent = "wip", description = "Write code drunkenly." },
  speech_balloon = { emoji = "💬", intent = "docs", description = "Add or update text and literals." },
  card_file_box = { emoji = "🗃️", intent = "data", description = "Perform database related changes." },
  loud_sound = { emoji = "🔊", intent = "config", description = "Add or update logs." },
  mute = { emoji = "🔇", intent = "cleanup", description = "Remove logs." },
  busts_in_silhouette = { emoji = "👥", intent = "chore", description = "Add or update contributor(s)." },
  children_crossing = { emoji = "🚸", intent = "ui", description = "Improve user experience / usability." },
  building_construction = { emoji = "🏗️", intent = "build", description = "Make architectural changes." },
  iphone = { emoji = "📱", intent = "ui", description = "Work on responsive design." },
  clown_face = { emoji = "🤡", intent = "mock", description = "Mock things." },
  egg = { emoji = "🥚", intent = "experiment", description = "Add or update an easter egg." },
  see_no_evil = { emoji = "🙈", intent = "config", description = "Add or update a .gitignore file." },
  camera_flash = { emoji = "📸", intent = "test", description = "Add or update snapshots." },
  alembic = { emoji = "⚗️", intent = "experiment", description = "Perform experiments." },
  mag = { emoji = "🔍️", intent = "seo", description = "Improve SEO." },
  label = { emoji = "🏷️", intent = "types", description = "Add or update types." },
  seedling = { emoji = "🌱", intent = "seed", description = "Add or update seed files." },
  triangular_flag_on_post = { emoji = "🚩", intent = "experiment", description = "Add, update, or remove feature flags." },
  goal_net = { emoji = "🥅", intent = "fix", description = "Catch errors." },
  dizzy = { emoji = "💫", intent = "ui", description = "Add or update animations and transitions." },
  wastebasket = { emoji = "🗑️", intent = "cleanup", description = "Deprecate code that needs to be cleaned up." },
  passport_control = { emoji = "🛂", intent = "security", description = "Work on code related to authorization, roles and permissions." },
  adhesive_bandage = { emoji = "🩹", intent = "fix", description = "Simple fix for a non-critical issue." },
  monocle_face = { emoji = "🧐", intent = "analytics", description = "Data exploration/inspection." },
  coffin = { emoji = "⚰️", intent = "cleanup", description = "Remove dead code." },
  test_tube = { emoji = "🧪", intent = "test", description = "Add a failing test." },
  necktie = { emoji = "👔", intent = "feat", description = "Add or update business logic." },
  stethoscope = { emoji = "🩺", intent = "config", description = "Add or update healthcheck." },
  bricks = { emoji = "🧱", intent = "deploy", description = "Infrastructure related changes." },
  technologist = { emoji = "🧑‍💻", intent = "chore", description = "Improve developer experience." },
  money_with_wings = { emoji = "💸", intent = "feat", description = "Add money related/sponsorships." },
  thread = { emoji = "🧵", intent = "perf", description = "Add or update code related to multithreading or concurrency." },
  safety_vest = { emoji = "🦺", intent = "security", description = "Add or update code related to validation." },
  airplane = { emoji = "✈️", intent = "feat", description = "Improve offline support." },
  t_rex = { emoji = "🦖", intent = "fix", description = "Code that adds backwards compatibility." }
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
  local handle = io.popen(
    "git ls-files --cached --exclude-standard | awk -F'/' '{for(i=1;i<NF;i++) print $i}' | sort -u"
  )

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
          for k, v in pairs(gitmojis) do
            local conventional_doc = intentDocs[v.intent] or ""

            local detailed_doc = string.format(
              "**Intent:** `%s`\n**Description:** %s\n\n---\n\n%s",
              v.intent:upper(),
              v.description,
              conventional_doc
            )

            table.insert(items, {
              -- AUTOCOMPLETION LIST ENTRIES
              label = v.emoji .. " " .. v.intent .. " - " .. v.description,
              kind = require("cmp.types.lsp").CompletionItemKind.Keyword,
              detail = v.intent .. " - " .. v.description,
              documentation = {
                kind = "markdown",
                value = detailed_doc
              },
              -- AUTOCOMPLETE SNIPPET
              insertText = v.emoji .. " " .. v.intent .. "(): ",
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

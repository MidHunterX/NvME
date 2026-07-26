local M = {}

-- conventional commit types (intent)
local intentDocs = {
    feat =
        "Features\n" ..
        "MUST be used when a commit adds a new feature to your application or library.\n" ..
        "\nUse for:\n" ..
        "- Adding a new API endpoint (scope: api).\n" ..
        "- Implementing a new UI component or user-facing behavior (scope: ui).\n" ..
        "- Creating a new command-line option.\n" ..
        "\nBreaking Changes:\n" ..
        "- If the feature breaks backward compatibility, append `!` after the type/scope.\n" ..
        "- Example: `feat(api)!: change response format`\n" ..
        "- Always include a `BREAKING CHANGE:` footer in the commit body.\n" ..
        "\nAlternatives:\n" ..
        "- Use `perf` if the change improves performance instead of adding behavior.\n" ..
        "- Use `refactor` if restructuring existing code without new functionality.\n",
    fix =
        "Bug Fixes\n" ..
        "MUST be used when a commit represents a bug fix for your application.\n" ..
        "\nUse for:\n" ..
        "- Fixing a crash or error in the application.\n" ..
        "- Resolving incorrect UI behavior (scope: ui).\n" ..
        "- Addressing a logic bug in business rules.\n" ..
        "- Patching security vulnerabilities (scope: security).\n" ..
        "\nBreaking Changes:\n" ..
        "- If the fix changes behavior that existing clients rely on, append `!`.\n" ..
        "- Example: `fix(api)!: remove deprecated field`\n" ..
        "\nAlternatives:\n" ..
        "- Use `revert` if rolling back a problematic commit entirely.\n" ..
        "- Use `test` if only modifying tests to prevent similar issues.\n",
    docs =
        "Documentation\n" ..
        "Changes related to documentation files only.\n" ..
        "\nUse for:\n" ..
        "- Updating the README, API docs, or inline comments.\n" ..
        "- Correcting spelling or typos in documentation (scope: typo).\n" ..
        "- Updating project license or legal files (scope: license).\n" ..
        "\nAlternatives:\n" ..
        "- Use `chore` if updating non-code contributor guidelines or templates.\n",
    style =
        "Code Formatting & Linting\n" ..
        "Changes that affect code formatting, whitespace, or linting rules ONLY.\n" ..
        "MUST NOT change any logic, UI behavior, or user-facing appearance.\n" ..
        "\nUse for:\n" ..
        "- Fixing indentation, line breaks, or spacing.\n" ..
        "- Removing extra semicolons or trailing commas.\n" ..
        "- Applying auto-formatter (Prettier) or lint fixes (ESLint).\n" ..
        "\nAlternatives:\n" ..
        "- Use `chore` for style updates related to tooling configuration (e.g., ESLint config).\n" ..
        "- Use `feat` or `fix` for UI/UX visual changes (e.g., colors, typography, layouts).\n",
    refactor =
        "Code Refactoring\n" ..
        "A code change that neither fixes a bug nor adds new functionality.\n" ..
        "\nUse for:\n" ..
        "- Simplifying complex code logic.\n" ..
        "- Extracting duplicated logic into a reusable function.\n" ..
        "- Renaming variables/methods for clarity (scope: naming).\n" ..
        "- Updating TypeScript/Flow type definitions (scope: types).\n" ..
        "\nAlternatives:\n" ..
        "- Use `style` if the change is purely cosmetic formatting.\n" ..
        "- Use `perf` if the refactor explicitly improves performance.\n",
    perf =
        "Performance Improvements\n" ..
        "A change that optimizes the speed, memory, or efficiency of the application.\n" ..
        "\nUse for:\n" ..
        "- Optimizing database queries.\n" ..
        "- Reducing bundle size or improving caching strategies.\n" ..
        "- Profiling and optimizing hot code paths.\n" ..
        "\nAlternatives:\n" ..
        "- Use `refactor` if the internal restructuring does NOT yield a measurable performance gain.\n",
    test =
        "Tests\n" ..
        "Adding, updating, or correcting tests for the application.\n" ..
        "\nUse for:\n" ..
        "- Adding unit/integration tests for a new feature.\n" ..
        "- Fixing a failing test case.\n" ..
        "- Adding mock data or fixtures (scope: mocks).\n" ..
        "\nAlternatives:\n" ..
        "- Use `fix` if modifying the production code itself to make a test pass.\n" ..
        "- Use `chore` for setting up or updating test tooling (e.g., Jest config).\n",
    build =
        "Build System & Dependencies\n" ..
        "Changes that affect the build system, external dependencies, or packaging.\n" ..
        "\nUse for:\n" ..
        "- Updating Webpack, Babel, Rollup, or Vite configurations.\n" ..
        "- Adding/updating/removing npm, pip, or gem packages (scope: deps).\n" ..
        "- Modifying Dockerfiles or packaging scripts.\n" ..
        "\nAlternatives:\n" ..
        "- Use `ci` if modifying CI/CD workflows instead of the local build process.\n" ..
        "- Use `chore` for general config updates that don't affect the build output.\n",
    ci =
        "Continuous Integration\n" ..
        "Changes to CI/CD pipelines, such as GitHub Actions, Jenkins, or Travis.\n" ..
        "\nUse for:\n" ..
        "- Adding or modifying GitHub Actions workflows.\n" ..
        "- Updating deployment scripts or infrastructure-as-code (scope: deploy).\n" ..
        "- Fixing pipeline issues that cause deployment failures.\n" ..
        "\nAlternatives:\n" ..
        "- Use `build` for changes strictly related to the local build process.\n" ..
        "- Use `chore` for general repository configuration updates (e.g., Dependabot).\n",
    chore =
        "Chores & Maintenance\n" ..
        "Routine tasks that do not modify application logic, UI, or tests.\n" ..
        "\nUse for:\n" ..
        "- Modifying `.gitignore`, `.editorconfig`, or environment files (scope: config).\n" ..
        "- General code cleanup (removing dead code, unused imports) (scope: cleanup).\n" ..
        "- Updating non-build tooling configurations.\n" ..
        "- Initial project setup (scope: init).\n" ..
        "\nAlternatives:\n" ..
        "- Use `build` for dependency updates or build script changes.\n" ..
        "- Use `ci` for CI/CD pipeline changes.\n",
    revert =
        "Reverts\n" ..
        "Undoing or rolling back a previous commit.\n" ..
        "\nUse for:\n" ..
        "- Reverting a commit that introduced a breaking change.\n" ..
        "- Undoing a merge that caused critical issues.\n" ..
        "- Restoring a deleted feature due to a mistake.\n" ..
        "\nNote:\n" ..
        "- The commit message should include the hash of the commit being reverted.\n" ..
        "\nAlternatives:\n" ..
        "- Use `fix` if applying a corrective patch instead of a full revert.\n",
}

-- Gitmoji + conventional commit
---@type table<string, {
    ---emoji: string,
    ---intent: "feat" | "fix" | "docs" | "style" | "refactor" | "perf" | "test" | "build" | "ci" | "chore" | "revert",
    ---priority: number,
    ---description: string
    ---}>
local gitmojis = {
    -- TIER 1: CORE DAILY ACTIVITIES (Most Common)
    sparkles = { emoji = "✨", intent = "feat", priority = 1, description = "Introduce new features." },
    bug = { emoji = "🐛", intent = "fix", priority = 1, description = "Fix a bug." },
    memo = { emoji = "📝", intent = "docs", priority = 1, description = "Add or update documentation." },
    recycle = { emoji = "♻️", intent = "refactor", priority = 1, description = "Refactor code." },
    art = { emoji = "🎨", intent = "style", priority = 1, description = "Improve structure / format of the code." },
    white_check_mark = { emoji = "✅", intent = "test", priority = 1, description = "Add, update, or pass tests." },
    pencil2 = { emoji = "✏️", intent = "docs", priority = 1, description = "Fix typos." },

    -- TIER 2: MAINTENANCE & DEPENDENCIES
    wrench = { emoji = "🔧", intent = "chore", priority = 2, description = "Add or update configuration files." },
    arrow_up = { emoji = "⬆️", intent = "build", priority = 2, description = "Upgrade dependencies." },
    heavy_plus_sign = { emoji = "➕", intent = "build", priority = 2, description = "Add a dependency." },
    fire = { emoji = "🔥", intent = "chore", priority = 2, description = "Remove code or files." },
    construction = { emoji = "🚧", intent = "chore", priority = 2, description = "Work in progress." },
    label = { emoji = "🏷️", intent = "refactor", priority = 2, description = "Add or update types." },

    -- TIER 3: UI, UX & ASSETS
    lipstick = { emoji = "💄", intent = "feat", priority = 3, description = "Add or update the UI and style files." },
    children_crossing = { emoji = "🚸", intent = "feat", priority = 3, description = "Improve user experience / usability." },
    bento = { emoji = "🍱", intent = "feat", priority = 3, description = "Add or update assets." },
    iphone = { emoji = "📱", intent = "feat", priority = 3, description = "Work on responsive design." },
    dizzy = { emoji = "💫", intent = "feat", priority = 3, description = "Add or update animations and transitions." },

    -- TIER 4: CI/CD & RELEASES
    green_heart = { emoji = "💚", intent = "ci", priority = 4, description = "Fix CI Build." },
    construction_worker = { emoji = "👷", intent = "ci", priority = 4, description = "Add or update CI build system." },
    bookmark = { emoji = "🔖", intent = "chore", priority = 4, description = "Release / Version tags." },
    rocket = { emoji = "🚀", intent = "ci", priority = 4, description = "Deploy stuff." },
    tada = { emoji = "🎉", intent = "chore", priority = 4, description = "Begin a project." },

    -- TIER 5: PERFORMANCE, SECURITY & ARCHITECTURE
    zap = { emoji = "⚡️", intent = "perf", priority = 5, description = "Improve performance." },
    lock = { emoji = "🔒️", intent = "fix", priority = 5, description = "Fix security or privacy issues." },
    ambulance = { emoji = "🚑️", intent = "fix", priority = 5, description = "Critical hotfix." },
    rotating_light = { emoji = "🚨", intent = "style", priority = 5, description = "Fix compiler / linter warnings." },
    building_construction = { emoji = "🏗️", intent = "refactor", priority = 5, description = "Make architectural changes." },
    boom = { emoji = "💥", intent = "feat", priority = 5, description = "Introduce breaking changes." },

    -- TIER 6: REFACTORING & FILE OPS
    truck = { emoji = "🚚", intent = "refactor", priority = 6, description = "Move or rename resources (e.g.: files, paths, routes)." },
    hammer = { emoji = "🔨", intent = "build", priority = 6, description = "Add or update development scripts." },
    package = { emoji = "📦️", intent = "build", priority = 6, description = "Add or update compiled files or packages." },
    rewind = { emoji = "⏪️", intent = "revert", priority = 6, description = "Revert changes." },

    -- TIER 7: SPECIALIZED DOMAINS (Data, API, SEO, i18n)
    card_file_box = { emoji = "🗃️", intent = "chore", priority = 7, description = "Perform database related changes." },
    alien = { emoji = "👽️", intent = "fix", priority = 7, description = "Update code due to external API changes." },
    globe_with_meridians = { emoji = "🌐", intent = "feat", priority = 7, description = "Internationalization and localization." },
    mag = { emoji = "🔍️", intent = "feat", priority = 7, description = "Improve SEO." },
    wheelchair = { emoji = "♿️", intent = "feat", priority = 7, description = "Improve accessibility." },
    chart_with_upwards_trend = { emoji = "📈", intent = "feat", priority = 7, description = "Add or update analytics or track code." },

    -- TIER 8: EXPERIMENTATION & LOGS
    alembic = { emoji = "⚗️", intent = "chore", priority = 8, description = "Perform experiments." },
    bulb = { emoji = "💡", intent = "docs", priority = 8, description = "Add or update comments in source code." },
    loud_sound = { emoji = "🔊", intent = "chore", priority = 8, description = "Add or update logs." },
    mute = { emoji = "🔇", intent = "chore", priority = 8, description = "Remove logs." },

    -- TIER 9: NICHE FIXES & TOOLS
    adhesive_bandage = { emoji = "🩹", intent = "fix", priority = 9, description = "Simple fix for a non-critical issue." },
    goal_net = { emoji = "🥅", intent = "fix", priority = 9, description = "Catch errors." },
    clown_face = { emoji = "🤡", intent = "test", priority = 9, description = "Mock things." },
    camera_flash = { emoji = "📸", intent = "test", priority = 9, description = "Add or update snapshots." },
    test_tube = { emoji = "🧪", intent = "test", priority = 9, description = "Add a failing test." },
    see_no_evil = { emoji = "🙈", intent = "chore", priority = 9, description = "Add or update a .gitignore file." },

    -- TIER 10: ADVANCED / SPECIFIC USE CASES
    passport_control = { emoji = "🛂", intent = "feat", priority = 10, description = "Work on code related to authorization, roles and permissions." },
    closed_lock_with_key = { emoji = "🔐", intent = "chore", priority = 10, description = "Add or update secrets." },
    safety_vest = { emoji = "🦺", intent = "fix", priority = 10, description = "Add or update code related to validation." },
    bricks = { emoji = "🧱", intent = "ci", priority = 10, description = "Infrastructure related changes." },
    technologist = { emoji = "🧑‍💻", intent = "chore", priority = 10, description = "Improve developer experience." },
    thread = { emoji = "🧵", intent = "perf", priority = 10, description = "Add or update code related to multithreading or concurrency." },
    necktie = { emoji = "👔", intent = "feat", priority = 10, description = "Add or update business logic." },
    page_facing_up = { emoji = "📄", intent = "docs", priority = 10, description = "Add or update license." },

    -- TIER 11: RARE OR MISC (Least Common)
    heavy_minus_sign = { emoji = "➖", intent = "build", priority = 11, description = "Remove a dependency." },
    pushpin = { emoji = "📌", intent = "build", priority = 11, description = "Pin dependencies to specific versions." },
    arrow_down = { emoji = "⬇️", intent = "build", priority = 11, description = "Downgrade dependencies." },
    monocle_face = { emoji = "🧐", intent = "chore", priority = 11, description = "Data exploration/inspection." },
    coffin = { emoji = "⚰️", intent = "chore", priority = 11, description = "Remove dead code." },
    wastebasket = { emoji = "🗑️", intent = "chore", priority = 11, description = "Deprecate code that needs to be cleaned up." },
    seedling = { emoji = "🌱", intent = "chore", priority = 11, description = "Add or update seed files." },
    stethoscope = { emoji = "🩺", intent = "chore", priority = 11, description = "Add or update healthcheck." },
    airplane = { emoji = "✈️", intent = "feat", priority = 11, description = "Improve offline support." },
    t_rex = { emoji = "🦖", intent = "fix", priority = 11, description = "Code that adds backwards compatibility." },
    busts_in_silhouette = { emoji = "👥", intent = "chore", priority = 11, description = "Add or update contributor(s)." },
    money_with_wings = { emoji = "💸", intent = "feat", priority = 11, description = "Add money related/sponsorships." },
    egg = { emoji = "🥚", intent = "feat", priority = 11, description = "Add or update an easter egg." },
    poop = { emoji = "💩", intent = "chore", priority = 11, description = "Write bad code that needs to be improved." },
    beers = { emoji = "🍻", intent = "chore", priority = 11, description = "Write code drunkenly." },
    twisted_rightwards_arrows = { emoji = "🔀", intent = "chore", priority = 11, description = "Merge branches." },
    speech_balloon = { emoji = "💬", intent = "docs", priority = 11, description = "Add or update text and literals." },
    triangular_flag_on_post = { emoji = "🚩", intent = "chore", priority = 11, description = "Add, update, or remove feature flags." },
}

M.keywords_source = function()
    local types = require("cmp.types.lsp")
    return setmetatable({}, {
        __index = function(_, key)
            if key == "complete" then
                return function(_, _, callback)
                    local items = {}
                    for _, v in pairs(gitmojis) do
                        local conventional_doc = intentDocs[v.intent] or ""
                        local sort_text_tag = string.format("%02d", v.priority)
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
                            sortText = sort_text_tag,
                            -- AUTOCOMPLETE SNIPPET
                            -- insertText = v.emoji .. " " .. v.intent .. "(): ",
                            insertText = v.emoji .. " " .. v.intent .. "($0): ",
                            insertTextFormat = types.InsertTextFormat.Snippet, -- enables $0, $1 support
                        })
                    end
                    callback({ items = items, isIncomplete = false })
                end
            end
        end,
    })
end

-- ============================[ SCOPE SECTION ]============================ --

local common_scopes = {
    "api", "ui", "ux", "deps", "config", "security", "a11y", "i18n",
    "types", "cleanup", "init", "deploy", "seed", "data", "mock",
    "analytics", "seo", "license", "typo", "experiment", "merge",
    "release", "migration", "schema", "frontend", "backend", "auth",
    "logging", "monitoring", "cache", "queue", "db", "docker",
    "k8s", "terraform", "ansible", "scripts", "assets", "images",
    "fonts", "styles", "hooks", "middleware", "routes", "controllers",
    "models", "views", "templates", "helpers", "utils", "lib", "vendor",
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

M.scope_source = function()
    return setmetatable({}, {
        __index = function(_, key)
            if key == "complete" then
                return function(_, _, callback)
                    local items = {}

                    for _, scope in ipairs(common_scopes) do
                        table.insert(items, {
                            label = scope,
                            kind = require("cmp.types.lsp").CompletionItemKind.Keyword,
                        })
                    end

                    for _, folder in ipairs(get_git_folders()) do
                        table.insert(items, {
                            label = folder,
                            kind = require("cmp.types.lsp").CompletionItemKind.Folder,
                        })
                    end

                    -- table.sort(items, function(a, b) return a.label < b.label end)
                    callback({ items = items, isIncomplete = false })
                end
            end
        end,
    })
end

return M

local M = {}

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

-- ========================[ GITMOJI -> CC ADAPTER ]======================== --

-- Gitmoji + conventional commit
---@type table<string, {
    ---emoji: string,
    ---intent: "feat" | "fix" | "docs" | "style" | "refactor" | "perf" | "test" | "build" | "ci" | "chore" | "revert",
    ---priority: number,
    ---description: string,
    ---scope?: string,
    ---}>
local gitmojis = {
    -- TIER 1: CORE DAILY ACTIVITIES (Most Common)
    sparkles = { emoji = "✨", intent = "feat", priority = 1, description = "New features" },
    bug = { emoji = "🐛", intent = "fix", priority = 1, description = "Fix bug" },
    memo = { emoji = "📝", intent = "docs", priority = 1, description = "Docs" },
    recycle = { emoji = "♻️", intent = "refactor", priority = 1, description = "Refactor" },
    art = { emoji = "🎨", intent = "style", priority = 1, description = "Format/Structure" },
    white_check_mark = { emoji = "✅", intent = "test", priority = 1, description = "Add/update tests" },
    pencil2 = { emoji = "✏️", intent = "docs", priority = 1, description = "Typos" },

    -- TIER 2: MAINTENANCE & DEPENDENCIES
    wrench = { emoji = "🔧", intent = "chore", priority = 2, description = "Config", scope = "config" },
    arrow_up = { emoji = "⬆️", intent = "build", priority = 2, description = "Upgrade deps", scope = "deps" },
    heavy_plus_sign = { emoji = "➕", intent = "build", priority = 2, description = "Add dep", scope = "deps" },
    label = { emoji = "🏷️", intent = "refactor", priority = 2, description = "Types", scope = "types" },
    fire = { emoji = "🔥", intent = "chore", priority = 2, description = "Remove code/files", scope = "cleanup" },
    construction = { emoji = "🚧", intent = "chore", priority = 2, description = "WIP" },

    -- TIER 3: UI, UX & ASSETS
    lipstick = { emoji = "💄", intent = "feat", priority = 3, description = "UI/Styles", scope = "ui" },
    children_crossing = { emoji = "🚸", intent = "feat", priority = 3, description = "UX", scope = "ux" },
    bento = { emoji = "🍱", intent = "feat", priority = 3, description = "Assets", scope = "assets" },
    iphone = { emoji = "📱", intent = "feat", priority = 3, description = "Responsive", scope = "ui" },
    dizzy = { emoji = "💫", intent = "feat", priority = 3, description = "Animations", scope = "ui" },

    -- TIER 4: CI/CD & RELEASES
    green_heart = { emoji = "💚", intent = "ci", priority = 4, description = "CI fix", scope = "ci" },
    construction_worker = { emoji = "👷", intent = "ci", priority = 4, description = "CI system", scope = "ci" },
    bookmark = { emoji = "🔖", intent = "chore", priority = 4, description = "Release tags", scope = "release" },
    rocket = { emoji = "🚀", intent = "ci", priority = 4, description = "Deploy", scope = "deploy" },
    tada = { emoji = "🎉", intent = "chore", priority = 4, description = "Init project", scope = "init" },

    -- TIER 5: PERFORMANCE, SECURITY & ARCHITECTURE
    lock = { emoji = "🔒️", intent = "fix", priority = 5, description = "Security fix", scope = "security" },
    zap = { emoji = "⚡️", intent = "perf", priority = 5, description = "Performance" },
    ambulance = { emoji = "🚑️", intent = "fix", priority = 5, description = "Hotfix" },
    rotating_light = { emoji = "🚨", intent = "style", priority = 5, description = "Fix warnings" },
    building_construction = { emoji = "🏗️", intent = "refactor", priority = 5, description = "Architecture" },
    boom = { emoji = "💥", intent = "feat", priority = 5, description = "Breaking changes" },

    -- TIER 6: REFACTORING & FILE OPS
    truck = { emoji = "🚚", intent = "refactor", priority = 6, description = "Move/Rename", scope = "cleanup" },
    hammer = { emoji = "🔨", intent = "build", priority = 6, description = "Dev scripts", scope = "scripts" },
    package = { emoji = "📦️", intent = "build", priority = 6, description = "Packages", scope = "scripts" },
    rewind = { emoji = "⏪️", intent = "revert", priority = 6, description = "Revert" },

    -- TIER 7: SPECIALIZED DOMAINS (Data, API, SEO, i18n)
    card_file_box = { emoji = "🗃️", intent = "chore", priority = 7, description = "DB changes", scope = "db" },
    alien = { emoji = "👽️", intent = "fix", priority = 7, description = "API fixes", scope = "api" },
    globe_with_meridians = { emoji = "🌐", intent = "feat", priority = 7, description = "i18n/l10n", scope = "i18n" },
    mag = { emoji = "🔍️", intent = "feat", priority = 7, description = "SEO", scope = "seo" },
    wheelchair = { emoji = "♿️", intent = "feat", priority = 7, description = "Accessibility", scope = "a11y" },
    chart_with_upwards_trend = { emoji = "📈", intent = "feat", priority = 7, description = "Analytics", scope = "analytics" },

    -- TIER 8: EXPERIMENTATION & LOGS
    alembic = { emoji = "⚗️", intent = "chore", priority = 8, description = "Experiments", scope = "experiment" },
    loud_sound = { emoji = "🔊", intent = "chore", priority = 8, description = "Logs", scope = "logging" },
    mute = { emoji = "🔇", intent = "chore", priority = 8, description = "Remove logs", scope = "logging" },
    bulb = { emoji = "💡", intent = "docs", priority = 8, description = "Comments" },

    -- TIER 9: NICHE FIXES & TOOLS
    clown_face = { emoji = "🤡", intent = "test", priority = 9, description = "Mocks", scope = "mock" },
    see_no_evil = { emoji = "🙈", intent = "chore", priority = 9, description = "Gitignore", scope = "config" },
    adhesive_bandage = { emoji = "🩹", intent = "fix", priority = 9, description = "Minor fix" },
    goal_net = { emoji = "🥅", intent = "fix", priority = 9, description = "Catch errors" },
    camera_flash = { emoji = "📸", intent = "test", priority = 9, description = "Snapshots" },
    test_tube = { emoji = "🧪", intent = "test", priority = 9, description = "Failing test" },

    -- TIER 10: ADVANCED / SPECIFIC USE CASES
    passport_control = { emoji = "🛂", intent = "feat", priority = 10, description = "Auth/RBAC", scope = "auth" },
    closed_lock_with_key = { emoji = "🔐", intent = "chore", priority = 10, description = "Secrets", scope = "security" },
    safety_vest = { emoji = "🦺", intent = "fix", priority = 10, description = "Validation", scope = "schema" },
    bricks = { emoji = "🧱", intent = "ci", priority = 10, description = "Infra", scope = "ci" },
    necktie = { emoji = "👔", intent = "feat", priority = 10, description = "Business logic", scope = "backend" },
    page_facing_up = { emoji = "📄", intent = "docs", priority = 10, description = "License", scope = "license" },
    technologist = { emoji = "🧑‍💻", intent = "chore", priority = 10, description = "DevEx" },
    thread = { emoji = "🧵", intent = "perf", priority = 10, description = "Concurrency" },

    -- TIER 11: RARE OR MISC (Least Common)
    heavy_minus_sign = { emoji = "➖", intent = "build", priority = 11, description = "Remove dep", scope = "deps" },
    pushpin = { emoji = "📌", intent = "build", priority = 11, description = "Pin deps", scope = "deps" },
    arrow_down = { emoji = "⬇️", intent = "build", priority = 11, description = "Downgrade deps", scope = "deps" },
    monocle_face = { emoji = "🧐", intent = "chore", priority = 11, description = "Data inspection", scope = "data" },
    coffin = { emoji = "⚰️", intent = "chore", priority = 11, description = "Remove dead code", scope = "cleanup" },
    wastebasket = { emoji = "🗑️", intent = "chore", priority = 11, description = "Deprecate", scope = "cleanup" },
    seedling = { emoji = "🌱", intent = "chore", priority = 11, description = "Seed files", scope = "seed" },
    stethoscope = { emoji = "🩺", intent = "chore", priority = 11, description = "Healthcheck", scope = "monitoring" },
    twisted_rightwards_arrows = { emoji = "🔀", intent = "chore", priority = 11, description = "Merge", scope = "merge" },
    triangular_flag_on_post = { emoji = "🚩", intent = "chore", priority = 11, description = "Feature flags", scope = "config" },
    airplane = { emoji = "✈️", intent = "feat", priority = 11, description = "Offline support" },
    t_rex = { emoji = "🦖", intent = "fix", priority = 11, description = "BackCompat" },
    busts_in_silhouette = { emoji = "👥", intent = "chore", priority = 11, description = "Contributors" },
    money_with_wings = { emoji = "💸", intent = "feat", priority = 11, description = "Money/Sponsors" },
    egg = { emoji = "🥚", intent = "feat", priority = 11, description = "Easter egg" },
    poop = { emoji = "💩", intent = "chore", priority = 11, description = "Bad code" },
    beers = { emoji = "🍻", intent = "chore", priority = 11, description = "Drunk code" },
    speech_balloon = { emoji = "💬", intent = "docs", priority = 11, description = "Text/Literals" },
}

-- ==========================[ KEYWORDS SECTION ]========================== --

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

                        local scope_part = v.scope and "(" .. v.scope .. ")" or "($0)"
                        local insert_text = v.emoji .. " " .. v.intent .. scope_part .. ": "

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
                            insertText = insert_text,
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

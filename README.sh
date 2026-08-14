#!/usr/bin/env bash
set -euo pipefail

# Directories
PLUGIN_DIR="lua/plugins"
README_FILE="README.adoc"

# Collect actual plugin files
plugin_files=$(ls "${PLUGIN_DIR}"/*.lua | xargs -n1 basename | sort)
core_cmp_files=$(ls "lua/core/cmp"/*.lua | xargs -n1 basename | sort)
plugin_files=$(printf "%s\n%s" "$plugin_files" "$core_cmp_files" | sort -u)

# Collect referenced files from README (pattern: something.lua)
readme_refs=$(grep -oE '[a-zA-Z0-9_-]+\.lua' "${README_FILE}" | sort -u)

echo "=== Checking Lua plugin references ==="
echo

RED='\033[1;31m'
GRN='\033[1;32m'
YLO='\033[1;33m'
RST='\033[0;0m'

# Compare sets
missing_in_readme=$(comm -23 <(echo "$plugin_files") <(echo "$readme_refs"))
unknown_in_readme=$(comm -13 <(echo "$plugin_files") <(echo "$readme_refs"))
correct_refs=$(comm -12 <(echo "$plugin_files") <(echo "$readme_refs"))

exit_code=0

if [[ -n "$missing_in_readme" ]]; then
    echo -e "❌ Files in ${GRN}${PLUGIN_DIR}${RST} but NOT in ${RED}README${RST}:"
    echo "=========================================="
    echo -e "$RED$missing_in_readme$RST"
    echo
    exit_code=1
fi

if [[ -n "$unknown_in_readme" ]]; then
    echo -e "❌ Files in ${YLO}README${RST} but NOT found in ${RED}${PLUGIN_DIR}${RST}:"
    echo "================================================"
    echo -e "$YLO$unknown_in_readme$RST"
    echo
    exit_code=1
fi

if [[ -n "$correct_refs" ]]; then
    echo -e "✅ Files in BOTH ${GRN}${PLUGIN_DIR}${RST} and ${GRN}README${RST}:"
    echo "========================================"
    echo -e "$GRN$correct_refs$RST"
    echo
fi

if [[ $exit_code -eq 0 ]]; then
    echo -e "🎉 ${GRN}All plugin files are correctly referenced in README.${RST}"
fi

exit $exit_code

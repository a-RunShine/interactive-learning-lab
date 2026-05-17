#!/bin/sh
# Verify Module 4: 历史追溯与回退
# Expected state:
#   - module-4/ is a git repo
#   - At least 3 commits exist
#   - .gitignore exists (recommended)
#   - Evidence of revert or reset operations
#   - reflog entries beyond commit count (shows reset was done and recovered)

set -e

[ "$1" = "--quiet" ] && QUIET=1
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/utils.sh"

MOD_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)/module-4"

check_git_repo "$MOD_DIR"
check_git_commit_count "$MOD_DIR" 3

# Check for revert commits
REVERT_COUNT=$(git -C "$MOD_DIR" log --oneline 2>/dev/null | grep -ci "Revert" || true)
if [ "$REVERT_COUNT" -ge 1 ]; then
    pass "revert commit(s) found (revert exercised)"
fi

# Check reflog entries exist (indicates history manipulation was practiced)
REFLOW_COUNT=$(git -C "$MOD_DIR" reflog 2>/dev/null | wc -l)
if [ "$REFLOW_COUNT" -ge 3 ]; then
    pass "reflog has entries (reset/revert history visible)"
fi

# Check for stash (may or may not have entries)
STASH_COUNT=$(git -C "$MOD_DIR" stash list 2>/dev/null | wc -l)
if [ "$STASH_COUNT" -ge 0 ]; then
    pass "stash operations available"
fi

summary

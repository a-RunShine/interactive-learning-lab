#!/bin/sh
# Verify Module 6: 进阶技巧
# Expected state:
#   - module-6/ is a git repo
#   - >=5 commits (from all topics combined)
#   - At least 2 branches created during exercises
#   - Evidence of rebase/cherry-pick/bisect

set -e

[ "$1" = "--quiet" ] && QUIET=1
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/utils.sh"

MOD_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)/module-6"

check_git_repo "$MOD_DIR"
check_git_commit_count "$MOD_DIR" 5

# Branch count
BRANCH_COUNT=$(git -C "$MOD_DIR" branch 2>/dev/null | wc -l)
if [ "$BRANCH_COUNT" -ge 2 ]; then
    pass "at least 2 branches (found: $BRANCH_COUNT)"
else
    fail "expected >=2 branches for cherry-pick/rebase exercises"
fi

check_git_branch "$MOD_DIR" "main"

# Evidence of rebase (reflog should show rebase entries)
if git -C "$MOD_DIR" reflog 2>/dev/null | grep -qi "rebase"; then
    pass "rebase evidence found in reflog"
fi

# Cherry-pick evidence
if git -C "$MOD_DIR" reflog 2>/dev/null | grep -qi "cherry-pick"; then
    pass "cherry-pick evidence found in reflog"
fi

summary

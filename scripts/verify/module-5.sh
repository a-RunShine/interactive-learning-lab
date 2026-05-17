#!/bin/sh
# Verify Module 5: 综合实战
# Expected state:
#   - module-5/ is a git repo
#   - >=5 commits
#   - >=2 branches (main + at least 1 feature)
#   - At least 1 merge
#   - Evidence of stash usage (optional: stash list or reflog)

set -e

[ "$1" = "--quiet" ] && QUIET=1
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/utils.sh"

MOD_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)/module-5"

check_git_repo "$MOD_DIR"
check_git_commit_count "$MOD_DIR" 5

# Branch count
BRANCH_COUNT=$(git -C "$MOD_DIR" branch 2>/dev/null | wc -l)
if [ "$BRANCH_COUNT" -ge 2 ]; then
    pass "at least 2 branches (found: $BRANCH_COUNT)"
else
    fail "expected >=2 branches (found: $BRANCH_COUNT)"
fi

check_git_branch "$MOD_DIR" "main"

# Merge operations
MERGE_COUNT=$(git -C "$MOD_DIR" log --oneline --merges 2>/dev/null | wc -l)
if [ "$MERGE_COUNT" -ge 1 ]; then
    pass "at least 1 merge commit (found: $MERGE_COUNT)"
else
    fail "expected >=1 merge; merge a feature branch into main"
fi

# Reflog — indicates non-trivial history (reset, merge, etc.)
REFLOW_COUNT=$(git -C "$MOD_DIR" reflog 2>/dev/null | wc -l)
if [ "$REFLOW_COUNT" -ge 5 ]; then
    pass "reflog shows rich history (found: $REFLOW_COUNT entries)"
fi

summary

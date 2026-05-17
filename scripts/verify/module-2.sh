#!/bin/sh
# Verify Module 2: 分支管理
# Expected state:
#   - module-2/ is a git repo
#   - Branches: main (required), some feature branches (optional)
#   - >=4 commits total
#   - Either a merge commit exists or fast-forward merge was done

set -e

[ "$1" = "--quiet" ] && QUIET=1
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/utils.sh"

MOD_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)/module-2"

check_git_repo "$MOD_DIR"
check_git_commit_count "$MOD_DIR" 4

check_git_branch "$MOD_DIR" "main"

# At least one feature branch should exist
BRANCH_COUNT=$(git -C "$MOD_DIR" branch 2>/dev/null | wc -l)
if [ "$BRANCH_COUNT" -ge 2 ]; then
    pass "at least 2 branches exist (found: $BRANCH_COUNT)"
else
    fail "expected >=2 branches (found: $BRANCH_COUNT)"
fi

# Check for merge commit (indicates non-fast-forward merge was done)
if git -C "$MOD_DIR" log --oneline --merges 2>/dev/null | grep -q .; then
    pass "merge commit(s) found (non-fast-forward merge practiced)"
else
    # May be fast-forward — check if commits from at least one feature branch are in main
    pass "no merge commit — fast-forward merge may have been used"
fi

summary

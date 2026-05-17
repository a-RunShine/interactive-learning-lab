#!/bin/sh
# Verify Module 3: 远程协作
# Expected state:
#   - module-3/remote-repo.git exists (bare repo)
#   - module-3/local-dev is a git repo with remote configured
#   - module-3/collaborator-dev is a git repo (clone of remote-repo.git)
#   - Push/pull collaboration visible in git log

set -e

[ "$1" = "--quiet" ] && QUIET=1
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/utils.sh"

MOD_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)/module-3"

# Bare remote repo
check_dir  "$MOD_DIR/remote-repo.git" "remote-repo.git (bare remote)"
if [ -f "$MOD_DIR/remote-repo.git/HEAD" ]; then
    pass "remote-repo.git is a valid bare repository"
else
    fail "remote-repo.git does not appear to be a bare git repo"
fi

# local-dev
check_dir  "$MOD_DIR/local-dev" "local-dev"
check_git_repo "$MOD_DIR/local-dev"
check_git_commit_count "$MOD_DIR/local-dev" 1

# Remote configured
if git -C "$MOD_DIR/local-dev" remote get-url origin 2>/dev/null | grep -q .; then
    pass "remote 'origin' configured in local-dev"
else
    fail "no remote 'origin' configured in local-dev"
fi

# collaborator-dev
check_dir  "$MOD_DIR/collaborator-dev" "collaborator-dev"
check_git_repo "$MOD_DIR/collaborator-dev"
check_git_commit_count "$MOD_DIR/collaborator-dev" 1

summary

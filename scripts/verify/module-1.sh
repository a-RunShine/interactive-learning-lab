#!/bin/sh
# Verify Module 1: Git 起步
# Expected state:
#   - module-1/ is a git repo
#   - At least 2 commits exist
#   - .gitignore exists and ignores *.class, target/, .idea/, *.log
#   - java-app/ has correct structure

set -e

[ "$1" = "--quiet" ] && QUIET=1
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/utils.sh"

MOD_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)/module-1"

check_git_repo "$MOD_DIR"
check_git_commit_count "$MOD_DIR" 2

check_file "$MOD_DIR/.gitignore" ".gitignore"
check_file_contains "$MOD_DIR/.gitignore" "*.class"
check_file_contains "$MOD_DIR/.gitignore" "target/"
check_file_contains "$MOD_DIR/.gitignore" ".idea/"

# Check commit message conventions
if git -C "$MOD_DIR" log --oneline -1 2>/dev/null | grep -qE "^(feat|fix|docs|chore|refactor):"; then
    pass "commit messages use conventional commits format"
else
    fail "commit messages should use conventional commits (feat:/fix:/docs:/chore:)"
fi

# java-app structure (quiz section)
if [ -d "$MOD_DIR/java-app" ]; then
    check_dir  "$MOD_DIR/java-app/src"   "java-app/src/"
    check_file "$MOD_DIR/java-app/src/Main.java" "java-app/src/Main.java"
    check_not_exists "$MOD_DIR/java-app/target/app.jar" "java-app/target/app.jar (ignored)"
    check_not_exists "$MOD_DIR/java-app/.idea/workspace.xml" "java-app/.idea/workspace.xml (ignored)"
fi

summary

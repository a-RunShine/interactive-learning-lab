#!/bin/sh
# Verify Utils — shared functions for all module verification scripts
# Usage: . "$(dirname "$0")/utils.sh"

QUIET="${QUIET:-0}"
PASSED=0
FAILED=0
CHECKS=""

# Colors (optional)
GREEN=''
RED=''
NC=''
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NC='\033[0m'
fi

pass() {
    PASSED=$((PASSED + 1))
    if [ "$QUIET" -eq 0 ]; then
        printf "${GREEN}  ✓${NC} %s\n" "$1"
    fi
}

fail() {
    FAILED=$((FAILED + 1))
    if [ "$QUIET" -eq 0 ]; then
        printf "${RED}  ✗${NC} %s\n" "$1"
    fi
}

summary() {
    TOTAL=$((PASSED + FAILED))
    if [ "$QUIET" -eq 0 ]; then
        echo ""
        if [ "$FAILED" -eq 0 ]; then
            printf "${GREEN}✓ All %d checks passed${NC}\n" "$TOTAL"
        else
            printf "${RED}✗ %d/%d checks failed${NC}\n" "$FAILED" "$TOTAL"
        fi
    fi
    return "$FAILED"
}

check_dir() {
    _label="${3:-directory $1}"
    if [ -d "$1" ]; then
        pass "$_label exists"
    else
        fail "$_label missing (expected: $1)"
    fi
}

check_file() {
    _label="${3:-file $1}"
    if [ -f "$1" ]; then
        pass "$_label exists"
    else
        fail "$_label missing (expected: $1)"
    fi
}

check_not_exists() {
    _label="${3:-$1}"
    if [ ! -e "$1" ]; then
        pass "$_label absent (as expected)"
    else
        fail "$_label should not exist"
    fi
}

check_git_repo() {
    if git -C "$1" rev-parse --git-dir >/dev/null 2>&1; then
        pass "git repo initialized in $1"
    else
        fail "not a git repository: $1"
    fi
}

check_git_commit_count() {
    _count=$(git -C "$1" rev-list --count HEAD 2>/dev/null || echo "0")
    if [ "$_count" -ge "$2" ]; then
        pass "at least $2 commits in $1 (found: $_count)"
    else
        fail "expected >=$2 commits in $1 (found: $_count)"
    fi
}

check_git_branch() {
    if git -C "$1" rev-parse --verify "$2" >/dev/null 2>&1; then
        pass "branch '$2' exists in $1"
    else
        fail "branch '$2' missing in $1"
    fi
}

check_file_contains() {
    if [ -f "$1" ] && grep -q "$2" "$1" 2>/dev/null; then
        pass "file $(basename "$1") contains expected content"
    else
        fail "file $(basename "$1") missing expected content"
    fi
}

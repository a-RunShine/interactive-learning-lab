#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

red()   { printf '\033[31m%s\033[0m\n' "$@"; }
green() { printf '\033[32m%s\033[0m\n' "$@"; }

failures=0

# ── Check 1: .opencode ↔ .claude sync ────────────────────
echo "== 1. .opencode ↔ .claude sync"

SKILL_DIR=".opencode/skills/teach-anything"
CLAUDE_DIR=".claude/skills/teach-anything"

if ! diff -rq "$ROOT_DIR/$SKILL_DIR" "$ROOT_DIR/$CLAUDE_DIR" > /dev/null 2>&1; then
    red "FAIL: $SKILL_DIR and $CLAUDE_DIR differ"
    diff -rq "$ROOT_DIR/$SKILL_DIR" "$ROOT_DIR/$CLAUDE_DIR" | sed 's/^/  /'
    failures=$((failures + 1))
else
    green "PASS"
fi

# ── Check 2: referenced paths exist ──────────────────────
echo "== 2. referenced paths exist"

SKILL_MD="$ROOT_DIR/$SKILL_DIR/SKILL.md"
while IFS= read -r path; do
    if [ ! -f "$ROOT_DIR/$path" ]; then
        red "FAIL: $path not found"
        failures=$((failures + 1))
    fi
done < <(grep -oP '\.opencode/skills/teach-anything/scripts/teach-\w+\.py' "$SKILL_MD" | sort -u)

green "PASS"

# ── Check 3: exit code scheme ────────────────────────────
echo "== 3. exit code consistency"
# SKILL.md: 0=成功, 1=文件不存在, 2=参数不合法, 3=JSON损坏, 4=检查点已存在

for script in teach-state.py teach-data.py; do
    script_file="$ROOT_DIR/$SKILL_DIR/scripts/$script"
    used_codes=$(grep -oP 'sys\.exit\((\d+)\)' "$script_file" | grep -oP '\d+' | sort -u)

    for code in $used_codes; do
        if [ "$code" -lt 1 ] || [ "$code" -gt 4 ]; then
            red "FAIL: $script uses exit code $code (only 1-4 declared)"
            failures=$((failures + 1))
        fi
    done
done

green "PASS"

# ── Summary ──────────────────────────────────────────────
echo
if [ $failures -eq 0 ]; then
    green "ALL CHECKS PASSED"
    exit 0
else
    red "$failures check(s) FAILED"
    exit 1
fi

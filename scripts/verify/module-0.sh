#!/bin/sh
# Verify Module 0: 命令行生存手册
# Expected state:
#   - module-0/quiz/src/Main.java exists
#   - module-0/quiz/out/ contains no .class files (cleaned by wildcard)

set -e

[ "$1" = "--quiet" ] && QUIET=1
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/utils.sh"

MOD_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)/module-0"

[ -f "$MOD_DIR/.gitkeep" ] || { fail ".gitkeep missing"; summary; exit 1; }

check_dir  "$MOD_DIR/quiz"      "module-0/quiz/ directory"
check_dir  "$MOD_DIR/quiz/src"  "module-0/quiz/src/ directory"
check_dir  "$MOD_DIR/quiz/out"  "module-0/quiz/out/ directory"
check_file "$MOD_DIR/quiz/src/Main.java" "module-0/quiz/src/Main.java"

# Check no .class files in out/ (wildcard deletion exercise)
if [ -d "$MOD_DIR/quiz/out" ] && [ -z "$(find "$MOD_DIR/quiz/out" -name '*.class' 2>/dev/null)" ]; then
    pass "no .class files in out/ (wildcard cleanup verified)"
else
    fail ".class files still present in out/ — use 'rm *.class'"
fi

summary

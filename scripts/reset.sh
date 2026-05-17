#!/bin/sh
# Reset — 重置练习环境
# Usage:
#   scripts/reset.sh                重置全部模块
#   scripts/reset.sh --module N     重置指定模块
#   scripts/reset.sh --yes          跳过确认提示

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

YES=0
TARGET=""

# Parse args
while [ $# -gt 0 ]; do
    case "$1" in
        --yes|-y) YES=1; shift ;;
        --module|-m) TARGET="$2"; shift 2 ;;
        [0-9]) TARGET="$1"; shift ;;
        *) shift ;;
    esac
done

if [ -n "$TARGET" ]; then
    MODULES="module-${TARGET}"
else
    MODULES="module-0 module-1 module-2 module-3 module-4 module-5 module-6"
fi

if [ "$YES" -eq 0 ]; then
    echo "⚠️  即将重置以下模块目录："
    for m in $MODULES; do
        if [ -d "$REPO_DIR/$m" ]; then
            echo "  · $m/"
        fi
    done
    echo ""
    echo "这将删除所有练习中产生的文件，恢复为仓库初始状态。"
    printf "确认重置？[y/N] "
    read -r ans
    case "$ans" in
        [Yy]|[Yy][Ee][Ss]) ;;
        *) echo "已取消。"; exit 0 ;;
    esac
fi

for m in $MODULES; do
    MOD_DIR="$REPO_DIR/$m"
    echo "重置 $m/ ..."

    # Ensure directory exists
    mkdir -p "$MOD_DIR"

    # Restore tracked files from git
    git -C "$REPO_DIR" checkout HEAD -- "$m/" 2>/dev/null || true

    # Remove untracked files (learner exercises, inner .git repos, etc.)
    git -C "$REPO_DIR" clean -fd "$m/" 2>/dev/null || true

    # Ensure directory exists and has at least .gitkeep
    mkdir -p "$MOD_DIR"
    if [ -z "$(ls -A "$MOD_DIR" 2>/dev/null)" ]; then
        touch "$MOD_DIR/.gitkeep"
    fi
done

echo ""
echo "✓ 重置完成。所有模块已恢复为初始状态。"

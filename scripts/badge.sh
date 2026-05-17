#!/bin/sh
# Badge — 成就与进度追踪
# Usage:
#   scripts/badge.sh status      查看进度
#   scripts/badge.sh claim <N>   领取模块 N 成就（自动验证）
#   scripts/badge.sh list        列出所有模块

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PROGRESS_FILE="$REPO_DIR/PROGRESS.md"

BADGES="
M0:🖥️ 终端驯兽师:命令行生存手册
M1:📦 版本管理者:Git 起步
M2:🌿 分支大师:分支管理
M3:🌐 协作者:远程协作
M4:⏰ 时间旅人:历史追溯与回退
M5:🏆 全栈 Git 忍者:综合实战
"

# Module display names
module_name() {
    case "$1" in
        0) echo "M0 — 命令行生存手册" ;;
        1) echo "M1 — Git 起步" ;;
        2) echo "M2 — 分支管理" ;;
        3) echo "M3 — 远程协作" ;;
        4) echo "M4 — 历史追溯与回退" ;;
        5) echo "M5 — 综合实战" ;;
        *) echo "M$1" ;;
    esac
}

badge_info() {
    echo "$BADGES" | grep "M$1:" | cut -d: -f2-3
}

is_claimed() {
    grep -q "M$1 .* ✓" "$PROGRESS_FILE" 2>/dev/null
}

cmd_status() {
    echo "📊 学习进度"
    echo "━━━━━━━━━━━━━━━━━━━━"
    COMPLETED=0
    for i in 0 1 2 3 4 5; do
        if is_claimed "$i"; then
            INFO=$(badge_info "$i")
            EMOJI=$(echo "$INFO" | cut -d: -f1)
            NAME=$(echo "$INFO" | cut -d: -f2)
            echo "  ✓ ${EMOJI} ${NAME}"
            COMPLETED=$((COMPLETED + 1))
        else
            echo "  ☐ $(module_name "$i")"
        fi
    done
    echo "━━━━━━━━━━━━━━━━━━━━"
    echo "  完成: $COMPLETED/6 模块"
    if [ "$COMPLETED" -eq 6 ]; then
        echo ""
        echo "🎓 恭喜毕业！你已经掌握了日常 80% 的 Git 场景。"
        echo ""
        echo "  进阶学习推荐："
        echo "  · Pro Git 免费书: https://git-scm.com/book/zh/v2"
        echo "  · Learn Git Branching: https://learngitbranching.js.org/"
        echo "  · 本仓库 Module 6: 进阶技巧 (rebase, cherry-pick, bisect)"
    fi
}

cmd_list() {
    for i in 0 1 2 3 4 5; do
        if is_claimed "$i"; then
            INFO=$(badge_info "$i")
            echo "  ✓ M$i — ${INFO}"
        else
            echo "  ☐ $(module_name "$i")"
        fi
    done
}

cmd_claim() {
    MOD="$1"
    if [ -z "$MOD" ]; then
        echo "用法: badge.sh claim <N>"
        echo "例如: badge.sh claim 0"
        exit 1
    fi

    # Validate module number
    case "$MOD" in
        [0-5]) ;;
        *) echo "错误: 无效的模块编号 $MOD (允许: 0-5)"; exit 1 ;;
    esac

    # Check if already claimed
    if is_claimed "$MOD"; then
        echo "✓ $(module_name "$MOD") 已经完成，无需重复领取。"
        return
    fi

    # Run verification
    VERIFY_SCRIPT="$SCRIPT_DIR/verify/module-${MOD}.sh"
    if [ ! -f "$VERIFY_SCRIPT" ]; then
        echo "✗ 验证脚本不存在: $VERIFY_SCRIPT"
        exit 1
    fi

    echo "🔍 验证 $(module_name "$MOD")..."
    if sh "$VERIFY_SCRIPT" --quiet 2>/dev/null; then
        echo "✓ 验证通过！领取成就..."

        # Update PROGRESS.md
        TODAY=$(date +%Y-%m-%d)
        INFO=$(badge_info "$MOD")
        BADGE_NAME=$(echo "$INFO" | cut -d: -f2)

        # Mark module as done
        sed -i "s/| M$MOD — .* | ☐ |.*/| M$MOD — $(module_name "$MOD" | sed 's/M[0-9] — //') | ✓ | $TODAY |/" "$PROGRESS_FILE"

        # Mark badge as unlocked
        BADGE_LINE=$(echo "$INFO" | cut -d: -f1)
        sed -i "s/| ${BADGE_LINE} .* | .* | ☐/| ${BADGE_LINE} ${BADGE_NAME} | 完成 M$MOD | ✓/" "$PROGRESS_FILE"

        echo "🎉 成就解锁: $(badge_info "$MOD" | cut -d: -f1-2 | sed 's/:/ /')"

        # Check if all done
        ALL_DONE=true
        for i in 0 1 2 3 4 5; do
            is_claimed "$i" || ALL_DONE=false
        done

        if $ALL_DONE; then
            echo ""
            echo "🎓🎓🎓 全部模块完成！恭喜毕业！🎓🎓🎓"
            echo ""
            echo "  你现在可以："
            echo "  · 在日常工作中自信使用 Git"
            echo "  · 继续 Module 6 进阶模块"
            echo "  · 阅读 Pro Git: https://git-scm.com/book/zh/v2"
        fi
    else
        echo "✗ 验证失败！请完成 $(module_name "$MOD") 的所有练习后再试。"
        echo "  运行验证脚本查看详情: $VERIFY_SCRIPT"
        exit 1
    fi
}

# Main
case "${1:-status}" in
    status)  cmd_status ;;
    list)    cmd_list ;;
    claim)   cmd_claim "$2" ;;
    *)
        echo "用法: badge.sh {status|list|claim <N>}"
        echo ""
        echo "  status  查看学习进度"
        echo "  list    列出所有模块状态"
        echo "  claim N 验证并领取模块 N 成就"
        exit 1
        ;;
esac

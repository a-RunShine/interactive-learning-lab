#!/usr/bin/env python3
"""teach-anything 检查点管理。

高频操作：init → step(每步1次) → next(每模块1次) → get(恢复时)
"""
import argparse
import json
import sys
from pathlib import Path


def cmd_init(args):
    path = Path(args.path) / ".teaching-state.json"
    if path.exists() and not args.force:
        print("检查点文件已存在，使用 'step' 继续或手动删除后重新初始化", file=sys.stderr)
        sys.exit(4)
    modules = [m.strip() for m in args.modules.split(",")]
    state = {
        "topic": args.topic,
        "plan": [{"name": m, "completed": False, "stepsDone": 0} for m in modules],
        "currentModuleIndex": 0,
        "currentStep": 0,
    }
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(state, ensure_ascii=False, indent=2))
    print(f"检查点已初始化: {path}")


def cmd_step(args):
    path = Path(args.path) / ".teaching-state.json"
    if not path.exists():
        print("未找到检查点", file=sys.stderr)
        sys.exit(1)
    step = args.step
    if step < 1 or step > 7:
        print("step_number 必须在 1-7 之间", file=sys.stderr)
        sys.exit(2)
    try:
        raw = path.read_text()
        state = json.loads(raw)
    except json.JSONDecodeError:
        print("检查点文件损坏，请手动检查", file=sys.stderr)
        sys.exit(3)
    idx = state["currentModuleIndex"]
    state["currentStep"] = step
    state["plan"][idx]["stepsDone"] = step
    if step == 7:
        state["plan"][idx]["completed"] = True
    path.write_text(json.dumps(state, ensure_ascii=False, indent=2))


def cmd_next(args):
    path = Path(args.path) / ".teaching-state.json"
    if not path.exists():
        print("未找到检查点", file=sys.stderr)
        sys.exit(1)
    try:
        state = json.loads(path.read_text())
    except json.JSONDecodeError:
        print("检查点文件损坏，请手动检查", file=sys.stderr)
        sys.exit(3)
    if state["currentModuleIndex"] >= len(state["plan"]) - 1:
        print("已是最后一个模块，教学已完成，使用 'teach-data.py save' 保存记录", file=sys.stderr)
        sys.exit(2)
    state["currentModuleIndex"] += 1
    state["currentStep"] = 0
    path.write_text(json.dumps(state, ensure_ascii=False, indent=2))


def cmd_get(args):
    path = Path(args.path) / ".teaching-state.json"
    if not path.exists():
        print("未找到检查点", file=sys.stderr)
        sys.exit(1)
    try:
        state = json.loads(path.read_text())
    except json.JSONDecodeError:
        print("检查点文件损坏，请手动检查", file=sys.stderr)
        sys.exit(3)
    print(json.dumps(state, ensure_ascii=False))


def main():
    parser = argparse.ArgumentParser(
        description="teach-anything 检查点管理",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    sub = parser.add_subparsers(dest="command", required=True)

    p = sub.add_parser("init", help="初始化检查点")
    p.add_argument("path", help="learn-<topic>/ 目录路径")
    p.add_argument("--topic", required=True)
    p.add_argument("--modules", required=True, help="逗号分隔的模块名")
    p.add_argument("--force", action="store_true", help="覆盖已有检查点")

    p = sub.add_parser("step", help="推进步骤（高频，每步1次）")
    p.add_argument("path")
    p.add_argument("step", type=int, help="步骤号 1-7")

    p = sub.add_parser("next", help="切换到下一模块（低频，每模块1次）")
    p.add_argument("path")

    p = sub.add_parser("get", help="读取检查点（JSON stdout）")
    p.add_argument("path")

    args = parser.parse_args()

    if args.command == "init":
        cmd_init(args)
    elif args.command == "step":
        cmd_step(args)
    elif args.command == "next":
        cmd_next(args)
    elif args.command == "get":
        cmd_get(args)


if __name__ == "__main__":
    main()

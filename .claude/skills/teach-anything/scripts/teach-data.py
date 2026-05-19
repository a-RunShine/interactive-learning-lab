#!/usr/bin/env python3
"""teach-anything 会话数据持久化。

将完整 session 记录通过 stdin 原子追加到 dashboard-data.json。
"""
import argparse
import json
import sys
from pathlib import Path

DATA_FILE = Path("dashboard-data.json")


def cmd_save():
    raw = sys.stdin.read()
    if not raw:
        print("缺少输入：通过 stdin 传入 session JSON", file=sys.stderr)
        sys.exit(1)

    try:
        record = json.loads(raw)
    except json.JSONDecodeError as e:
        print(f"JSON 格式无效: {e}", file=sys.stderr)
        sys.exit(2)

    required = ("topic", "date", "modules")
    missing = [f for f in required if f not in record]
    if missing:
        print(f"缺少必填字段: {', '.join(missing)}", file=sys.stderr)
        sys.exit(2)

    # 原子追加：读 → 追加 → 写临时文件 → 原子重命名
    if DATA_FILE.exists():
        try:
            data = json.loads(DATA_FILE.read_text())
        except json.JSONDecodeError:
            data = {"sessions": []}
    else:
        data = {"sessions": []}

    data.setdefault("sessions", []).append(record)

    # 写临时文件后原子替换（避免写入过程中被其他进程读半成品）
    tmp = DATA_FILE.with_suffix(".json.tmp")
    tmp.write_text(json.dumps(data, ensure_ascii=False, indent=2))
    tmp.replace(DATA_FILE)

    print("学习记录已保存，打开 dashboard.html 查看学习仪表盘。")


def main():
    parser = argparse.ArgumentParser(description="teach-anything 数据持久化")
    parser.add_argument("command", nargs="?", default="save",
                        help="命令（当前仅支持 save）")
    args = parser.parse_args()
    if args.command == "save" or args.command is None:
        cmd_save()
    else:
        print(f"未知命令: {args.command}", file=sys.stderr)
        sys.exit(2)


if __name__ == "__main__":
    main()

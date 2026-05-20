#!/usr/bin/env python3
"""teach-anything 会话数据持久化。

将完整 session 记录通过 stdin 原子追加到 dashboard-data.json。
"""
import argparse
import json
import sys
import time
from pathlib import Path

DATA_FILE = Path("dashboard-data.json")
TMP_FILE = DATA_FILE.with_suffix(".tmp")
MAX_RETRIES = 3
RETRY_DELAY = 0.1


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

    for attempt in range(MAX_RETRIES):
        try:
            if DATA_FILE.exists():
                mtime_before = DATA_FILE.stat().st_mtime_ns
                with open(DATA_FILE, "r") as f:
                    try:
                        data = json.load(f)
                    except json.JSONDecodeError:
                        data = {"sessions": []}
                data.setdefault("sessions", []).append(record)
            else:
                mtime_before = 0
                data = {"sessions": [record]}
        except OSError as e:
            print(f"读取 dashboard-data.json 失败: {e}", file=sys.stderr)
            sys.exit(3)

        if DATA_FILE.exists():
            current_mtime = DATA_FILE.stat().st_mtime_ns
            if current_mtime != mtime_before:
                time.sleep(RETRY_DELAY)
                continue

        try:
            TMP_FILE.write_text(json.dumps(data, ensure_ascii=False, indent=2))
            TMP_FILE.replace(DATA_FILE)
        except OSError as e:
            print(f"写入 dashboard-data.json 失败: {e}", file=sys.stderr)
            sys.exit(3)
        break
    else:
        print("写入 dashboard-data.json 失败：并发重试超限，请手动检查", file=sys.stderr)
        sys.exit(3)

    print("学习记录已保存，打开 dashboard.html 查看学习仪表盘。", file=sys.stderr)


def main():
    parser = argparse.ArgumentParser(description="teach-anything 数据持久化")
    parser.add_argument("command", nargs="?", default="save",
                        help="命令（当前仅支持 save）")
    args = parser.parse_args()
    if args.command != "save":
        print(f"未知命令: {args.command}", file=sys.stderr)
        sys.exit(2)
    cmd_save()


if __name__ == "__main__":
    main()

# SDK Layer Design

> 将教学中高频、机械、易出错的操作脚本化。

## Motivation

当前教学中 Agent 手工读写 `.teaching-state.json`（每步 1 次，高频）、手工追加 `dashboard-data.json`（并发安全手工保障）、手工创建目录骨架。这些操作有固定的结构和边界，适合脚本化以减少 token 消耗和人为错误。

## File Structure

```
.opencode/skills/teach-anything/
├── SKILL.md
├── workflows/
└── scripts/
    ├── teach-state.py          ← T0: 检查点读写
    └── teach-data.py           ← T0: 数据持久化
```

Python 标准库，零额外依赖。

### Execution Context

所有脚本**必须在项目根目录执行**。脚本中的相对路径（如 `teach-data.py` 操作的 `dashboard-data.json`）基于 CWD 解析。Agent 在调用前应切换到项目根目录。

## Script: teach-state.py

### Interface

```bash
teach-state.py init <path> --topic <topic> --modules "<name1>,<name2>,..."
teach-state.py step <path> <step_number>
teach-state.py next <path>
teach-state.py get <path>
```

`<path>` 是 `learn-<topic>/` 目录路径。脚本在该目录下读写 `.teaching-state.json`。

### Commands

**`init`** — 创建检查点文件
```
teach-state.py init learn-python \
  --topic "Python" \
  --modules "变量与类型,控制流,函数与作用域"
```
- 拆 `modules` 为 plan 数组，每项 `{ name, completed: false, stepsDone: 0 }`
- 写入 `currentModuleIndex: 0, currentStep: 0`
- 若文件已存在则拒绝执行，exit code 4，stderr "检查点文件已存在，使用 'step' 继续或手动删除后重新初始化"
- 强制覆盖加 `--force` 标志

**`step`** — 推进步骤（高频，每步 1 次）
```
teach-state.py step learn-python 3
```
- 读取 `.teaching-state.json`
- 更新 `currentStep = <step_number>`
- 更新 `plan[currentModuleIndex].stepsDone = <step_number>`
**Validation**: `<step_number>` 有效范围 1-7。超出则 exit code 2，stderr "step_number 必须在 1-7 之间"
- 若 `<step_number> == 7`，自动标记 `plan[currentModuleIndex].completed = true`
- 写回文件

**`next`** — 切换到下一模块（低频，每模块 1 次）
```
teach-state.py next learn-python
```
- `currentModuleIndex += 1`
- `currentStep = 0`
- 若已超出最后一个模块：exit code 2，stderr "已是最后一个模块，教学已完成，使用 'teach-data.py save' 保存记录"

**`get`** — 读取检查点
```
teach-state.py get learn-python
# → stdout: {"topic":"Python","plan":[...],"currentModuleIndex":1,"currentStep":3}
```
- 若文件不存在，exit code 1，stderr "未找到检查点"
- `--summary` 标志（后续优化）：输出人类可读进度摘要如"上次学到模块 2「控制流」的第 3 步"

### Error Handling

| 场景 | exit code | stderr |
|------|-----------|--------|
| 文件不存在 | 1 | 原因描述 |
| 参数不合法 / 超出范围 | 2 | 用法提示 |
| JSON 损坏 | 3 | "检查点文件损坏，请手动检查" |
| 文件已存在（init 拒绝） | 4 | "检查点文件已存在，使用 'step' 继续或手动删除后重新初始化" |
| 超出最后模块（next 拒绝） | 2 | "已是最后一个模块，教学已完成，使用 'teach-data.py save' 保存记录" |

## Script: teach-data.py

### Interface

```bash
cat record.json | teach-data.py save
```

### Input Format (stdin)

```json
{
  "topic": "Python",
  "date": "2026-05-19",
  "modules": [
    { "name": "变量与类型", "completed": true },
    { "name": "控制流", "completed": false }
  ],
  "errors": [
    { "error": "IndentationError", "module": "控制流", "rootCause": "混用tab和空格", "resolution": "统一用4空格" }
  ]
}
```

### Behavior

`save` 命令：
1. 读取 stdin 完整 JSON
2. 验证必填字段（`topic`, `date`, `modules`）
3. 读取 `dashboard-data.json`（不存在则创建 `{ "sessions": [] }`）
4. 记录当前文件 `mtime`
5. 追加 session 记录到 `sessions` 数组
6. 写回文件前检查 `mtime`，若已变更则重读重试（防并发覆盖）
7. 成功退出 exit code 0

### Concurrency Safety

写回前二次读取原文件并与记录的 `mtime` 对比：
- mtime 未变 → 直接写回
- mtime 已变 → 重新读取 → 重新追加 → 尝试写回（最多重试 3 次）

### Error Handling

- 无 stdin 输入：exit code 1
- JSON 格式无效：exit code 2
- 数据字段缺失：exit code 2
- 写回重试超限：exit code 3

## Integration into SKILL.md

SKILL.md 中对应的操作改为调用脚本：

| 原行为 | 替换为 |
|--------|--------|
| 手动 Write `.teaching-state.json` | `teach-state.py step <path> N` |
| 手动推进模块 | `teach-state.py next <path>` |
| 读取检查点恢复 | `teach-state.py get <path>` |
| 手动 Write `dashboard-data.json` | `cat record.json \| teach-data.py save` |

## Future (T1/T2)

- `teach-env.py init` — 目录骨架生成
- `teach-env.py cleanup` — 清理
- `teach-rca.py format` — RCA 归档结构化输出

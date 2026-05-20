## Context

当前 teach-state.py 支持 4 个子命令（init/step/next/get），均以 `learn-<topic>` 目录为参数。检查点文件 `.teaching-state.json` 按 topic 独立存放在各自目录下。Agent 在做"继续学习"时假设单主题，缺少发现已有主题的能力。

## Goals / Non-Goals

**Goals:**
- Agent 能在不扫描文件系统的情况下获知"有哪些主题可学"及各主题进度
- SKILL.md 的恢复流程按主题数量（0/1/N）正确分支
- `list` 输出精确的进度字段，agent 无需做字符串解析

**Non-Goals:**
- 不修改 dashboard-data.json 的 schema
- 不实现 dashboard.html 的多主题聚合视图
- 不修改 teach-data.py

## Decisions

### 1. list 扫描策略：glob `learn-*/.teaching-state.json`

- 使用 `pathlib.Path.cwd().glob("learn-*/.teaching-state.json")` 扫描
- 不读 `dashboard-data.json`，保持 list 轻量、零依赖
- 要求脚本在项目根目录执行（与现有约定一致）

### 2. 输出字段：JSON 数组，module 拆为 current/total，含完成标记

```json
[
  {
    "topic": "python",
    "currentModule": 3,
    "totalModules": 5,
    "currentStep": 4,
    "completed": false,
    "updated": "2026-05-20"
  },
  {
    "topic": "docker",
    "currentModule": 5,
    "totalModules": 5,
    "currentStep": 7,
    "completed": true,
    "updated": "2026-05-19"
  }
]
```

- `topic` 来自检查点的 `topic` 字段（而非目录名，因为 init 时 `--topic` 可能不同于目录名）
- `currentModule` / `totalModules` 从 `plan` 数组计算（`currentModuleIndex + 1` / `len(plan)`）
- `completed` 由 `all(m["completed"] for m in plan)` 计算，Agent 据此决定展示文案
- `updated` 取检查点文件的 mtime，仅取日期部分

### 3. 损坏文件处理：报告错误条目而非跳过

```json
{
  "topic": "(损坏)",
  "path": "learn-python/.teaching-state.json",
  "error": "JSON 解析失败"
}
```

- 保留文件名信息，方便用户/Agent 手动修复
- 不阻塞其他正常文件的扫描

### 4. 恢复流程分支（SKILL.md L181-186 调整）

```
list 输出
  │
  ├── 0 条 → Phase 1 新方案协商
  ├── 1 条 → 直接恢复（当前行为不变）
  └── N 条 → 列出选项让用户选
                │
                └── 用户选择后 → get 对应 topic 恢复
```

- N 条时展示: "你有 N 个主题正在学习中：1. Python（模块 3/5）✅ 已学完  2. Java（模块 1/4）想继续学哪个？"
- 展示规则：`completed == true` → `"✅ 已学完"`；否则 `"模块 {currentModule}/{totalModules} 第 {currentStep} 步"`；若 `currentStep == 0` → `"尚未开始"`
- "学 Python"精确匹配 → 跳过 list，直接 get learn-python

### 5. 空数组退出码

- `teach-state.py list` 在扫描到 0 个检查点时 `exit 0` + 输出 `[]`
- 空结果不是错误状态，是正常的初始状态；Agent 看到 `[]` 走 Phase 1 新方案协商

## Risks / Trade-offs

- **损坏文件名泄露**：`path` 字段暴露本地路径。权衡：Agent 需要路径执行后续的 `get learn-<topic>`，利大于弊
- **Agent 不按约定在根目录执行**：glob 会找不到任何文件。与现有 `init/step/next/get` 的行为一致，维持 exit code 1 提示
- **updated 只有日期粒度**：同一天多次写入无法区分。够用——教学会话一般日级粒度

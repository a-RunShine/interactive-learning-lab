## Why

当前 teach-state.py 缺少 `list` 子命令，Agent 无法回答"有什么可学的"。恢复流程也只支持单主题场景，多主题时「继续学习」出现歧义。这两个缺口阻碍了用户在仓库中学习多个独立主题。

## What Changes

- **teach-state.py 新增 `list` 子命令**：扫描 `learn-*/` 目录下的 `.teaching-state.json`，返回所有活跃主题的名称和进度
- **SKILL.md 恢复流程补充多主题消解逻辑**：根据活跃主题数量（0/1/N）分支处理
- **dashboard-data.json / dashboard.html 不变**：展示层增强留到后续

## Capabilities

### New Capabilities
- `topic-discovery`: Agent 通过命令行发现仓库中已有的学习主题及其进度，支持多主题间的选择与切换

### Modified Capabilities

（无）

## Impact

- `.opencode/skills/teach-anything/scripts/teach-state.py` — 新增约 30 行 `list` 子命令
- `.opencode/skills/teach-anything/SKILL.md` — 检查点恢复流程 L181-186 扩展为多主题分支
- `.claude/skills/teach-anything/SKILL.md` — 同步更新
- 行为变化：`list` 命令遇到损坏的检查点文件时报告错误而非静默跳过

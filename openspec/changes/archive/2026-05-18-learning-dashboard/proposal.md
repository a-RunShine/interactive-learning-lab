## Why

当前 teach-anything skill 教学过程中产生的学习记录仅在对话记忆中，会话结束后丢失。用户无法回顾"我学过什么、犯过哪些错误"。需要一个持久化的学习仪表盘记录每次教学会话的学习轨迹和错误历史。

## What Changes

1. 新增 `dashboard.html` — 独立前端页面，展示学习历史、模块完成情况和错误记录
2. 教学 skill 中新增数据落盘指令 — 每次教学会话结束时将学习记录写入 `dashboard-data.json`
3. `dashboard-data.json` 记录：教学主题、模块列表、每个模块的完成状态、记录的错题

## Capabilities

### New Capabilities
- `learning-dashboard`: 学习仪表盘，提供可视化学习历史回顾和错误追踪

### Modified Capabilities
<!-- 无现有 spec 需要修改 -->

## Impact

- 新增文件：`dashboard.html`（前端页面，含 CSS + JS，单文件）
- 新增文件：`dashboard-data.json`（数据文件，由 skill 写入）
- 修改文件：`.opencode/skills/teach-anything/SKILL.md`（新增教学完成后的数据写入指令）

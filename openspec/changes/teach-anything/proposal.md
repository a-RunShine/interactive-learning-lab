## Why

当前教学仓库完全绑定 Git 领域知识（模块 0-6），无法复用教学框架教其他技能。用户希望将教学引擎与教学内容解耦，实现"想学什么就教什么"的通用交互式教学能力。

## What Changes

1. 新增 `teach-anything` opencode skill，实现通用教学协议
2. 将现有 7 步教学流程抽象为领域无关的教学引擎（不依赖 Git 模块结构）
3. 教学内容（即具体科目）作为可插拔数据源，由 skill 在对话中动态协商生成
4. 保留现有 Git 教学模块的兼容性（skill 加载时可选用 Git 内容或动态内容）
5. 新增学习方案协商流程：用户诉求 → 初定方案 → 讨论 → 确认 → 教学

## Capabilities

### New Capabilities
- `teach-anything`: 通用教学 skill，支持用户输入任意学习诉求，动态生成教学方案并执行 7 步教学流程

### Modified Capabilities
<!-- 无现有 spec 需要修改 -->

## Impact

- 新增文件：`.opencode/skills/teach-anything/SKILL.md` — skill 主文件
- 新增文件：`docs/superpowers/specs/generic-teaching-protocol.md` — 教学协议（领域无关版本）
- 现有 Git 教学模块（module-0 至 module-6）、TEACHING_PROTOCOL.md、TEACHING_PROTOCOL.md 不受影响（保留作为 Git 领域内容源）
- AGENTS.md 需更新，说明 teach-anything skill 的加载条件

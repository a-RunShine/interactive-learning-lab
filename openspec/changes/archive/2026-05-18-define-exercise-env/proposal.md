## Why

当前 SKILL.md 定义了 Phase 2 的 7 步教学流程，但未规定 agent 在教每个模块时是否创建物理目录和练习文件。不同 agent 行为不一致（纯对话 vs 创建临时文件 vs 创建完整目录），导致教学体验不可控。

## What Changes

1. 在 `.opencode/skills/teach-anything/SKILL.md` 中新增「教学环境管理」章节
2. 规定 agent 进入每个模块时，创建 `learn-<topic>/module-N-<name>/` 目录
3. 原子任务产生的练习文件写入该目录
4. 全部模块完成后询问用户保留或清理

## Capabilities

### New Capabilities
- `exercise-env`: 定义 agent 在教学中如何创建和管理练习文件目录

### Modified Capabilities
<!-- 无现有 spec 需要修改 -->

## Impact

- 修改文件：`.opencode/skills/teach-anything/SKILL.md`（新增教学环境管理章节）

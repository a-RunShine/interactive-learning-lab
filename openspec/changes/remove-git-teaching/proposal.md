## Why

仓库已实现 `teach-anything` 通用教学 skill，将教学能力从 Git 解耦。原有 Git 教学文件（module-N、verify 脚本、badge 系统等）不再需要，反而混淆仓库定位。删除它们使仓库彻底变为 teach-anything 通用教学平台。

## What Changes

1. **删除所有 module-N/ 目录**（module-0 至 module-6）及内部 STEPS.md、练习文件
2. **删除 scripts/verify/、scripts/badge.sh** 等 Git 教学脚本
3. **删除 scripts/reset.sh**（无模块可重置）
4. **删除 TEACHING_PROTOCOL.md**（已由 `.opencode/skills/teach-anything/SKILL.md` 和 `docs/superpowers/specs/generic-teaching-protocol.md` 替代）
5. **重写 AGENTS.md**：从"Git 教学实验室"改为"通用教学平台"，唯一入口为 teach-anything skill
6. **更新 README.md**：反映新定位
7. **标记 CLAUDE.md**：如存在则删除或替换引用
8. **清理 openspec/specs/ 中已无效的 spec**：module-scripts、verify-engine、gamification、advanced-module 标记 REMOVED
9. **更新 agent-protocol spec**：不再引用 module 依赖顺序
10. **更新 open-source-infra spec**：README、CI 等反映新定位

## Capabilities

### New Capabilities
<!-- 无新增 capability -->

### Modified Capabilities
- `agent-protocol`: 不再要求 module 依赖顺序和 TEACHING_PROTOCOL.md 引用
- `open-source-infra`: 需要重写 README 反映新定位；CONTRIBUTING.md 需更新；CI 脚本可能简化

### Removed Capabilities
- `module-scripts`: 模块 STEPS.md 体系已被删除
- `verify-engine`: verify 脚本体系已被删除
- `gamification`: badge 成就体系已被删除
- `advanced-module`: module-6 进阶内容已被删除

## Impact

- 删除文件：module-0/ 至 module-6/、scripts/verify/、scripts/badge.sh、scripts/reset.sh、TEACHING_PROTOCOL.md
- 修改文件：AGENTS.md、README.md、openspec/specs/ 中 6 个 spec 文件
- 保留文件：`.opencode/skills/teach-anything/SKILL.md`、`docs/superpowers/specs/generic-teaching-protocol.md`、openspec 框架本身
- branch: main

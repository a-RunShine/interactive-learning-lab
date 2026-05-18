## Context

当前仓库存在两套教学体系：
1. 旧体系：module-0~6 + TEACHING_PROTOCOL.md + verify/badge/reset 脚本（Git 专用）
2. 新体系：`.opencode/skills/teach-anything/SKILL.md` + `docs/superpowers/specs/generic-teaching-protocol.md`（领域无关）

旧体系已完全被新体系覆盖。保留旧文件会让仓库定位混乱、维护成本翻倍。删除旧体系使仓库整洁、专注，降低 Agent 选择成本。

## Goals / Non-Goals

**Goals:**
- 删除所有 Git 教学模块文件（module-0/ 至 module-6/）
- 删除 Git 专用脚本（verify/、badge.sh、reset.sh）
- 删除 TEACHING_PROTOCOL.md（被通用协议替代）
- 重写 AGENTS.md 定位为通用教学平台
- 更新 README.md
- 更新 openspec/specs/ 中对应 spec 标记 REMOVED 或 MODIFIED

**Non-Goals:**
- 不修改 `.opencode/skills/teach-anything/SKILL.md`（刚建好）
- 不删除 `openspec/` 框架本身
- 不删除 `docs/superpowers/` 下的通用协议文档
- 不修改 CLAUDE.md（skill 不依赖项目级 agent 指引文件）

## Decisions

| 决策 | 选项 | 选择 | 理由 |
|------|------|------|------|
| 旧模块处理 | 保留 vs 删除 vs 归档 | **删除** | 用户明确要求删除；Git 历史可恢复 |
| TEACHING_PROTOCOL.md | 保留 vs 删除 | **删除** | 内容已合并到 generic-teaching-protocol.md |
| 删除方式 | 一次提交 vs 逐步 | **一次提交** | 删除操作无中间状态，一次完成 |
| 提交范围 | 单 commit vs 多 commit | **单 commit** | 删除操作应原子化 |
| AGENTS.md 定位 | Git 教学 + 通用 skill vs 纯通用 | **纯通用** | 用户要求唯一 skill，入口单一化 |

## Migration Plan

1. 删除所有 module-N/ 目录（`rm -rf module-*`）
2. 删除 scripts 中的 verify/badge/reset（`rm -rf scripts/verify scripts/badge.sh scripts/reset.sh`）
3. 删除 TEACHING_PROTOCOL.md
4. 重写 AGENTS.md
5. 更新 README.md
6. 更新 openspec/specs/ 中对应 spec

## Risks / Trade-offs

| 风险 | 缓解措施 |
|------|----------|
| 删除后 Git 历史中存在旧文件，clone 仍可见 | 这是预期行为；新 clone 用户只看当前 HEAD |
| 外部链接指向旧 module-N/ 路径会 404 | 仓库定位已变，404 可接受 |
| 旧 Agent（未更新 AGENTS.md）首次加载可能混淆 | 删除 TEACHING_PROTOCOL.md 后旧 Agent 无法引用，会自然 fallback 到 teach-anything |

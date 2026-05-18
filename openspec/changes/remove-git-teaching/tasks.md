## 1. 删除 Git 教学模块

- [ ] 1.1 删除 `module-0/` 至 `module-6/` 目录
- [ ] 1.2 删除 `scripts/verify/` 目录
- [ ] 1.3 删除 `scripts/badge.sh`
- [ ] 1.4 删除 `scripts/reset.sh`
- [ ] 1.5 删除 `TEACHING_PROTOCOL.md`

## 2. 更新核心文档

- [ ] 2.1 重写 `AGENTS.md`：定位为通用教学平台，唯一入口为 teach-anything skill
- [ ] 2.2 更新 `README.md`：反映新定位

## 3. 更新 openspec specs

- [ ] 3.1 更新 `openspec/specs/agent-protocol/spec.md`：移除 module 依赖顺序和 TEACHING_PROTOCOL.md 引用
- [ ] 3.2 更新 `openspec/specs/open-source-infra/spec.md`：READ 更新、移除 reset.sh 等引用
- [ ] 3.3 更新 `openspec/specs/module-scripts/spec.md`：标记 REMOVED
- [ ] 3.4 更新 `openspec/specs/verify-engine/spec.md`：标记 REMOVED
- [ ] 3.5 更新 `openspec/specs/gamification/spec.md`：标记 REMOVED
- [ ] 3.6 更新 `openspec/specs/advanced-module/spec.md`：标记 REMOVED

## 4. 清理与验证

- [ ] 4.1 确认 `module-*` 目录已全部删除
- [ ] 4.2 确认 `scripts/` 下只剩 scripts/ 或空
- [ ] 4.3 确认 TEACHING_PROTOCOL.md 已删除
- [ ] 4.4 确认 AGENTS.md 不再引用 module-N/
- [ ] 4.5 执行 `openspec status --json` 确认变更一致性

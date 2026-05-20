## Context

SKILL.md 当前 331 行，承载三层职责：教学编排（Phase 1 协商、Phase 2 7 步流程、检查点管理、环境管理）、RCA 引导协议、数据持久化。其中 RCA 协议（约 30 行）仅在学生出错时使用——估算约 30% 的教学环节触发 RCA，但每次加载 SKILL.md 都带入工作内存。

之前讨论过 workflow isolation（将子流程拆为独立文件、按事件触发），结论是 Agent 执行模型不支持——workflow 需要条件触发，但 skill 只有"加载"一个事件。当前方案走轻量路径：不引入 trigger 机制，只把参考协议拆到单独文件，Agent 在需要时显式读取。

## Goals / Non-Goals

**Goals:**
- 提取 RCA 协议到 `references/rca-protocol.md`，SKILL.md 内仅保留引用
- SKILL.md 行数减少 ~12%（331 → ~290）
- Agent 正常教学时不加载 RCA 协议，仅在遇到学生错误或步骤 6 全错时按需读取
- RCA 协议可独立维护、独立审阅

**Non-Goals:**
- 不改变 RCA 协议的 4 步流程内容（定位锚点 → 线索追问 → 原理补漏 → 归档学习）
- 不更改步骤 6 的分支逻辑
- 不引入新的 trigger/workflow 机制
- 不修改 `teach-state.py` 或 `teach-data.py`
- 不改动 AGENTS.md（项目结构图中已隐含 references/ 但未列出，本次不碰）

## Decisions

| 决策 | 选项 | 选择 | 理由 |
|------|------|------|------|
| 存储位置 | `.opencode/skills/teach-anything/references/rca-protocol.md` | ✅ | 与 scripts/ 同级，归属 skill 私有，不污染项目级目录 |
| 文件命名 | `rca-protocol.md` | ✅ | 见名知意，protocol 强调是行为规范而非配置/模板 |
| SKILL.md 引用方式 | `（详见 references/rca-protocol.md）` | ✅ | 一行内联引用，Agent 读取路径清晰 |
| 步骤 6 全错分支 | 保持当前"走 RCA → 允许跳过"逻辑 | ✅ | 行为不变，仅引用路径变化 |
| .claude 同步 | `cp -r .opencode/skills/teach-anything .claude/skills/teach-anything` | ✅ | 沿用已有同步策略，不需引入新机制 |

**备选方案**：考虑过拆分为独立 skill（`teach-rca`），但 Agent 在执行步骤 6 时需要同时加载两个 skill，增加了跨 skill 协调复杂度。当前 skill 内 reference 文件方案更轻。

**备选方案**：考虑过使用 `include::` 语法或 symlink，但 markdown 没有标准 include，symlink 跨平台不确定。手动读取 + 显式引用是最可靠的。

## Risks / Trade-offs

| 风险 | 等级 | 缓解 |
|------|------|------|
| Agent 在出错时忘记读取 rca-protocol.md，直接给出答案 | 中 | SKILL.md 步骤 6 分支中引用路径写明确，且 SKILL.md 首部仍保留"禁止直接给答案"原则性声明 |
| SKILL.md 和 rca-protocol.md 内容不一致（一方改了另一方没改） | 低 | 两个文件在同一目录，改 SKILL.md 时自然会看到 references/；提交时 code review 可发现 |
| 步骤 6 全错时多一次文件读取，增加响应延迟 | 低 | rca-protocol.md 约 50 行，Agent 读取成本可忽略 |
| 历史 archive 中的 spec 引用旧结构，归档后不影响 | 无 | 归档 spec 是静态快照，不需更新 |

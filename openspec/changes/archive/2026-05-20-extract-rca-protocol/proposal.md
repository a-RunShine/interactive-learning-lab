## Why

SKILL.md 当前 331 行承载三层职责：教学编排（Phase 1/2、检查点、环境管理）、RCA 引导协议、数据持久化。RCA 协议（约 30 行）仅在学生出错时使用（约 30% 的教学环节），但每次加载 SKILL.md 都会带入工作内存。分离后 SKILL.md 减负 12%，RCA 协议可独立维护、按需读取，且不会影响核心教学流程的加载速度。

## What Changes

- 新建 `references/rca-protocol.md`：从 SKILL.md 提取 RCA 引导协议（定位锚点 → 线索追问 → 原理补漏 → 归档学习 + 步骤 6 联动 + 用户执意跳过处理）
- 修改 `SKILL.md`：删除 L264-291 完整 RCA 协议内容，改为一行引用 `（详见 references/rca-protocol.md）`
- 修改 `SKILL.md` 步骤 6 分支的 RCA 引用，指向外部文件
- `.claude/skills/teach-anything/` 同步两份文件

## Capabilities

### New Capabilities
- （无。RCA 协议不是新能力要求，只是现有行为指引从内联改为引用）

### Modified Capabilities
- `teach-anything`：RCA 引导协议从内联改为外部引用文件。行为要求不变，交付形式变化。SKILL.md 不再自包含 RCA 协议，agent 需在出错时按需读取 `references/rca-protocol.md`。

## Impact

- 文件变动的路径：`.opencode/skills/teach-anything/SKILL.md`、新建 `.opencode/skills/teach-anything/references/rca-protocol.md`
- `.claude/skills/teach-anything/` 需同步
- `AGENTS.md` 项目结构图可能需更新 references/ 目录
- 无运行时影响（纯文档重组，不影响脚本逻辑）

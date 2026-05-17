## Why

Git 教学资源大多是被动阅读式（文档、视频），缺乏一个**AI Agent 驱动的交互式教学仓库**。本项目已有优秀的教学方案设计（85/100 评分），但尚未包装为开源项目：缺少自动化验证引擎、Agent 引导协议、贡献者生态和 CI/CD。现在将其实体化为高质量开源项目，让任何 AI 编码 Agent（Claude Code、OpenCode、Codex 等）都能直接 clone 后开始教学。

## What Changes

- 新增 `scripts/verify/` 自动化验证脚本引擎（Shell + Python），自动检查用户命令执行结果
- 新增 `AGENTS.md` 和 `CLAUDE.md` 精化版本，兼容多 Agent 平台的引导协议
- 新增开源基础设施：`README.md`、`LICENSE`、`CONTRIBUTING.md`、`CODE_OF_CONDUCT.md`
- 新增 `tests/` 验证教学脚本自身的可重复性
- 新增 GitHub CI 工作流（lint + verify test）
- 新增 `scripts/reset.sh` 重置脚本，支持重复练习
- 将每个模块的教学计划（plan）转化为可执行的 Shell 教学脚本
- 新增 `module-6/` 进阶模块（rebase 交互式、cherry-pick、GitHub Flow）

## Capabilities

### New Capabilities
- `agent-protocol`: Agent 引导协议 —— 定义 AI Agent 与本仓库交互的标准接口（CLAUDE.md、AGENTS.md、模块入口脚本）
- `verify-engine`: 自动化验证引擎 —— Shell/Python 脚本，检查用户每次命令的结果是否符合期望
- `module-scripts`: 模块教学脚本 —— 将 6 个模块的教学计划转化为可执行的 step-by-step 脚本，含自动验证点
- `gamification`: 成就与进度系统 —— 徽章/里程碑/进度追踪，激励学习者持续前进
- `open-source-infra`: 开源基础设施 —— README、LICENSE、CONTRIBUTING、CI/CD、Issue/PR 模板
- `advanced-module`: module-6 进阶 —— rebase 交互式、cherry-pick、bisect、GitHub Flow 实战

### Modified Capabilities

- `<doc-specs>`: 现有教学方案文档迁移为 OpenSpec 规范格式，纳入版本管理的 spec 体系

## Impact

- 新增 `scripts/`、`tests/`、`.github/` 顶层目录
- 新增 `module-6/` 教学目录
- 修改 `CLAUDE.md`、`AGENTS.md` 使其兼容多 Agent 平台
- 影响范围：全部教学模块（module-0 ~ module-5）增加自动验证入口
- 现有 `docs/superpowers/` 中的设计文档迁移为 spec 格式

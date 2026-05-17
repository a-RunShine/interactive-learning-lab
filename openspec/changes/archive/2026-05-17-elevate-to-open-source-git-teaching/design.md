## Context

本项目已有完整的教学方案设计（`docs/superpowers/specs/` 和 `docs/superpowers/plans/`）和模块目录结构（`module-0/` ~ `module-5/`），但存在关键缺口：

1. **交付形式未固化**：教学计划是 Markdown 文档，依赖 Agent 自主理解执行，缺少标准化的引导协议
2. **无自动化验证**：无法自动检查用户命令执行结果，教学反馈依赖 Agent 手动运行 `ls`/`git log`
3. **无开源基础设施**：缺少 README、LICENSE、CONTRIBUTING，外部贡献者无法参与
4. **不可重复**：`module-N/` 目录被用户操作后无法一键重置
5. **单 Agent 绑定**：CLAUDE.md 专为 Claude Code 设计，OpenCode/Codex 等 Agent 缺少同等引导

项目目标：**任何 AI 编码 Agent clone 此仓库后，无需额外配置即可开始交互式 Git 教学。**

## Goals / Non-Goals

**Goals:**
- 标准化多 Agent 引导协议（AGENTS.md + CLAUDE.md + 模块入口约定）
- 自动化验证引擎（Shell 脚本），验证用户每一步操作的正确性
- 各模块教学脚本化，将教学计划转为可执行的 step 文件
- 开源基础设施：README、LICENSE、CONTRIBUTING、CI、Issue/PR 模板
- 可重复练习：reset 脚本，支持学习者多次从头开始
- 进度追踪与激励：徽章系统，记录学习里程碑
- module-6 进阶内容：rebase 交互式、cherry-pick、GitHub Flow

**Non-Goals:**
- 不做独立的 CLI 教学工具（保持"AI Agent 驱动"的轻量模式）
- 不做 Web UI 或图形界面
- 不翻译整个项目为英文（保留中文为主要教学语言，英文 README 作为补充）
- 不覆盖 Git 全部功能（聚焦日常 80% 场景）

## Decisions

### 1. 绑定中立的 Agent 引导协议 (agent-protocol)
- **方案**：定义 `TEACHING_PROTOCOL.md` 作为协议规范，`AGENTS.md` 和 `CLAUDE.md` 分别引用它
- **理由**：避免为每个 Agent 平台重复编写引导内容。OpenCode 读 AGENTS.md，Claude Code 读 CLAUDE.md，两者都指向同一份协议
- **替代方案**：只维护 CLAUDE.md → 排除非 Claude 用户。被否决。

### 2. 验证引擎用纯 Shell 实现 (verify-engine)
- **方案**：POSIX Shell 脚本，零依赖。`scripts/verify/` 下每个模块一个验证脚本
- **理由**：Git 教学的前提就是用户有 Shell 环境，无需额外安装 Python 或 Node
- **替代方案**：Python 脚本 → 需要 Python 3，增加入门门槛。被否决。

### 3. 模块教学脚本格式 (module-scripts)
- **方案**：每个模块 `module-N/` 下增加 `STEPS.md`，按顺序列出教学步骤，每步注明预期结果和验证命令
- **理由**：Agent 可直接读取 `STEPS.md` 按序执行，无需解析教学计划文档
- **替代方案**：Shell 脚本中的交互式教学 → 过于僵化，失去 Agent 灵活引导的优势。被否决。

### 4. 成就系统形式 (gamification)
- **方案**：`PROGRESS.md` 文件，学习者在完成模块后运行 `scripts/badge.sh claim module-N` 来解锁徽章
- **理由**：纯文件系统实现，无需数据库或网络；Git 本身可追踪进度变化
- **替代方案**：GitHub Wiki / GitHub Discussions → 依赖网络，违背本地优先原则。被否决。

### 5. 项目许可证选择 (open-source-infra)
- **方案**：MIT License
- **理由**：教学项目应最大化开放，MIT 允许商业和非商业使用、修改和再分发

## Risks / Trade-offs

- **[教学脚本与 Agent 灵活性冲突]** → STEPS.md 提供结构化指引但不强制顺序，Agent 可根据学习者情况调整节奏
- **[Shell 脚本跨平台兼容性]** → 使用 POSIX 子集，避免 bashism；在 CI 中测试 Linux (Ubuntu) 和 macOS
- **[中文受众限制]** → 初期专注于中文用户（本项目核心受众），英文版本作为 roadmap 项
- **[Module 内容过时]** → Git 命令很少变化，但建议每个 major Git 版本发布时检查 compatibility

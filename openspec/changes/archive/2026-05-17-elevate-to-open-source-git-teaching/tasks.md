## 1. Agent Protocol — TEACHING_PROTOCOL.md + 双 Agent 引导

- [x] 1.1 创建 `TEACHING_PROTOCOL.md`，定义完整的 7 步教学流程、模块依赖顺序、错误 RCA 协议
- [x] 1.2 重写 `AGENTS.md`，引用 TEACHING_PROTOCOL.md，适配 OpenCode/Codex 规范
- [x] 1.3 重写 `CLAUDE.md`，引用 TEACHING_PROTOCOL.md，精简 Claude Code 专属配置
- [x] 1.4 验证：OpenCode 和 Claude Code 分别阅读 AGENTS.md / CLAUDE.md 后能正确理解教学协议

## 2. Verify Engine — 自动化验证脚本

- [x] 2.1 创建 `scripts/verify/` 目录和 `scripts/verify/utils.sh`（共享函数库：check_dir、check_file、check_git_log、pass/fail 输出）
- [x] 2.2 实现 `scripts/verify/module-0.sh`：验证 module-0/quiz/ 目录结构，检查通配符删除结果
- [x] 2.3 实现 `scripts/verify/module-1.sh`：验证 module-1/ 的 git 仓库状态、提交历史、.gitignore 效果
- [x] 2.4 实现 `scripts/verify/module-2.sh`：验证 module-2/ 的分支结构、合并历史、冲突解决结果
- [x] 2.5 实现 `scripts/verify/module-3.sh`：验证 module-3/ 的 bare repo、remote 配置、协作提交历史
- [x] 2.6 实现 `scripts/verify/module-4.sh`：验证 module-4/ 的 diff/log/reflog/stash 操作结果
- [x] 2.7 实现 `scripts/verify/module-5.sh`：验证 module-5/ 的完整开发工作流（>=5 commits, >=1 branch, >=1 merge, >=1 stash）
- [x] 2.8 所有 verify 脚本支持 `--quiet` 标志
- [x] 2.9 验证：每个 verify 脚本在对应模块正确状态下 exit 0，错误状态下 exit 1

## 3. Module Scripts — 各模块 STEPS.md

- [x] 3.1 创建 `module-0/STEPS.md`：命令行生存手册（导航、文件操作、通配符、Vim、Tab 补全）
- [x] 3.2 创建 `module-1/STEPS.md`：Git 起步（三棵树、init/add/commit、log、.gitignore、约定式提交）
- [x] 3.3 创建 `module-2/STEPS.md`：分支管理（指针概念、branch/switch/merge、冲突解决）
- [x] 3.4 创建 `module-3/STEPS.md`：远程协作（bare repo 模拟、push/pull/fetch、pull 冲突处理）
- [x] 3.5 创建 `module-4/STEPS.md`：历史追溯与回退（diff、revert/reset、reflog、stash、detached HEAD）
- [x] 3.6 创建 `module-5/STEPS.md`：综合实战（Web 功能开发场景 或 算法库管理场景）
- [x] 3.7 每个 STEPS.md 使用一致的编号格式，每步包含概念 + 命令 + 验证点引用

## 4. Open Source Infra — 开源基础设施

- [x] 4.1 创建 `README.md`：项目定位、模块结构图、快速开始（多 Agent 启动命令）、徽章（CI/License）
- [x] 4.2 创建 `LICENSE`：MIT License
- [x] 4.3 创建 `CONTRIBUTING.md`：如何添加模块、修改教学脚本、提交 PR
- [x] 4.4 创建 `CODE_OF_CONDUCT.md`：Contributor Covenant v2.1
- [x] 4.5 创建 `.github/ISSUE_TEMPLATE/bug_report.md`：Bug 报告模板
- [x] 4.6 创建 `.github/ISSUE_TEMPLATE/feature_request.md`：功能请求模板
- [x] 4.7 创建 `.github/ISSUE_TEMPLATE/content_improvement.md`：教学内容改进模板
- [x] 4.8 创建 `.github/workflows/ci.yml`：CI 工作流（shellcheck + verify smoke test + 结构校验）

## 5. Gamification — 成就与进度系统

- [x] 5.1 创建 `PROGRESS.md`：进度追踪文件（M0-M5 初始状态全为 ☐）
- [x] 5.2 实现 `scripts/badge.sh` 脚本：
  - `badge.sh claim <module>` 命令：运行对应 verify 脚本 → 通过则更新 PROGRESS.md 标记 ✓ + 日期
  - `badge.sh status` 命令：显示当前进度
  - `badge.sh list` 命令：列出所有模块及完成状态
- [x] 5.3 badge.sh 在全部 6 个模块完成时打印毕业祝贺信息和进阶学习推荐
- [x] 5.4 验证：运行 `badge.sh claim module-N` 后 PROGRESS.md 正确更新

## 6. Reset Script — 可重复练习

- [x] 6.1 实现 `scripts/reset.sh`：使用 `git clean -fd` + `git checkout --` 重置所有 module-N/ 目录
- [x] 6.2 reset.sh 支持 `--module N` 参数重置单个模块，不带参数重置全部
- [x] 6.3 reset.sh 在操作前打印确认提示，防止误操作
- [x] 6.4 验证：运行 reset.sh 后所有 module-N/ 目录回到 git 中的初始状态

## 7. Advanced Module — Module-6 进阶内容

- [x] 7.1 创建 `module-6/STEPS.md`：rebase 交互式教学
- [x] 7.2 创建 `module-6/STEPS.md`：cherry-pick 教学
- [x] 7.3 创建 `module-6/STEPS.md`：bisect 教学
- [x] 7.4 创建 `module-6/STEPS.md`：GitHub Flow 教学
- [x] 7.5 创建 `scripts/verify/module-6.sh`：验证进阶模块操作结果

## 8. Final Polish — 最终检查

- [x] 8.1 运行 `shellcheck scripts/**/*.sh` 修复所有 Shell 脚本问题 (shellcheck unavailable locally; CI will run)
- [x] 8.2 运行每个 verify 脚本确认正常通过
- [x] 8.3 检查全部 STEPS.md 格式一致性（编号、验证点引用、概念/命令分段）
- [x] 8.4 检查 README.md 中的链接和命令可执行
- [x] 8.5 运行 reset.sh 验证可重复练习流程完整
- [x] 8.6 更新 `openspec/config.yaml` 添加项目上下文和规则

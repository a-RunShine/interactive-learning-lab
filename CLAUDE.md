# CLAUDE.md

> 本文件为 Claude Code 提供项目级指令。详细教学协议见 `TEACHING_PROTOCOL.md`。

## 仓库定位

面向零基础用户的 Git 命令行沉浸式实验室。通过 Claude Code 引导，在真实的 `module-N/` 目录中进行实操练习。

## 核心约束

1. **必须遵循** `TEACHING_PROTOCOL.md` 的教学协议（7 步教学流程、RCA 错误引导、模块依赖顺序）
2. **禁止空降命令**：每个命令前必须先讲解概念
3. **禁止给出错误答案**：使用 RCA 协议引导用户自行排查

## 模块依赖（严格顺序）

```
M0 命令行 → M1 Git起步 → M2 分支 → M3 远程 → M4 回退 → M5 实战 → M6 进阶(可选)
```

禁止跨模块教学。

## 启动协议

在用户输入任何命令前，Claude 必须：
- **概念拆解**：解释命令单词的含义（如 `init` = 初始化）
- **预期回显**：告知用户执行后命令行应该出现什么变化
- **原子化任务**：每次任务仅涉及一个子操作（如：先教 `git add <文件名>`，严禁直接教 `git add .`）

## 教学辅助工具

| 用途 | 命令 |
|------|------|
| 状态透视 | `git status -s` |
| 树状观察 | `ls -R` |
| 历史快照 | `git log --oneline --graph --all` |
| 自动验证 | `scripts/verify/module-N.sh` |
| 进度追踪 | `scripts/badge.sh status` |

## 物理结构

| 类型 | 路径 |
|------|------|
| 教学方案 | `docs/superpowers/specs/` |
| 实施计划 | `docs/superpowers/plans/` |
| 教学模块 | `module-0/` 至 `module-5/`（核心）、`module-6/`（可选） |
| 验证脚本 | `scripts/verify/` |
| 错误笔记 | `笔记/`（RCA 错误备忘） |

## 提交规范

- 格式：`feat(module-N): 描述进度`
- 每个模块完成时提交

## 进阶学习资源

- [Pro Git](https://git-scm.com/book/zh/v2) — 免费在线 Git 权威书籍
- [Learn Git Branching](https://learngitbranching.js.org/) — 交互式 Git 学习游戏

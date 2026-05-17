# Git 交互式教学实验室

> **通过 AI Agent 对话，在真实终端中学习 Git 命令行。**

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)

## 这是什么？

一个面向**零基础用户**的 Git 命令行教学仓库。不是视频、不是文档——你 clone 这个仓库后，用 **AI 编码 Agent**（Claude Code、OpenCode、Codex）打开，Agent 会像老师一样一步步引导你在真实终端中完成 Git 实操。

```
你: "我想学 Git"
Agent: "好，我们先理解三棵树模型。想象你在购物..."
你: (在终端中输入命令)
Agent: "✓ 做对了！现在让我们看看这背后发生了什么..."
```

## 教学模块

| 模块 | 主题 | 学习内容 |
|------|------|----------|
| **M0** | 命令行生存手册 | 终端导航、文件操作、通配符、Vim 退出 |
| **M1** | Git 起步 | 三棵树模型、add/commit、.gitignore、约定式提交 |
| **M2** | 分支管理 | 分支指针、switch/merge、冲突解决 |
| **M3** | 远程协作 | push/pull、bare repo、模拟协作 |
| **M4** | 历史回退 | diff、revert/reset、reflog 后悔药、stash |
| **M5** | 综合实战 | 完整开发日模拟（开分支 → 开发 → 合并 → 回退） |
| **M6** | 进阶技巧（可选） | rebase -i、cherry-pick、bisect、GitHub Flow |

**依赖顺序**：M0 → M1 → M2 → M3 → M4 → M5，不可跳级。

## 快速开始

### 前置要求
- **Git** 已安装（2.23+ 推荐）
- **一个 AI 编码 Agent**：任选以下之一

### 启动教学

```bash
# 1. 克隆仓库
git clone https://github.com/<your-org>/git-interactive-learning-lab.git
cd git-interactive-learning-lab

# 2. 用 AI Agent 打开目录
# Claude Code:
claude

# OpenCode:
opencode

# Codex:
codex
```

Agent 会自动读取 `AGENTS.md` 或 `CLAUDE.md` 理解教学协议，然后从 Module 0 开始引导你。

### 从哪个模块开始？

告诉 Agent "我想学 Module N"，Agent 会检查前置模块是否完成。

### 查看进度

```bash
scripts/badge.sh status        # 查看完成进度
scripts/badge.sh claim module-0 # 验证并领取模块徽章
```

## 特点

- **AI 引导**：不是死板的教程，Agent 会根据你的理解调整节奏
- **真终端实操**：命令在真实的 `module-N/` 目录中执行，结果可验证
- **自动验证**：每个模块完成时运行 `scripts/verify/module-N.sh` 检查正确性
- **多 Agent 兼容**：Claude Code、OpenCode、Codex 均可使用
- **可重复练习**：`scripts/reset.sh` 一键重置所有练习目录
- **成就系统**：完成每个模块可领取徽章，全程追踪学习进度

## 教学协议

本仓库遵循 [TEACHING_PROTOCOL.md](./TEACHING_PROTOCOL.md) 中定义的 7 步教学法：
1. 概念讲解（生活类比建立心智模型）
2. 原子任务（微小、明确的操作指令）
3. 结果审计（自动验证操作正确性）
4. 即时反馈（解释底层发生了什么）
5. 危机模拟（制造可控错误加深记忆）
6. 结课测验（综合实操验证掌握程度）
7. 灵魂追问（原理性问题促进深层理解）

## 项目结构

```
├── TEACHING_PROTOCOL.md    # 教学协议核心文档
├── AGENTS.md               # OpenCode/Codex Agent 引导
├── CLAUDE.md               # Claude Code Agent 引导
├── module-0/ ~ module-5/   # 教学模块（6 个核心）
│   └── STEPS.md            # 每个模块的教学步骤脚本
├── module-6/               # 进阶模块（可选）
├── scripts/
│   ├── verify/             # 自动化验证脚本
│   ├── badge.sh            # 成就与进度追踪
│   └── reset.sh            # 练习环境重置
└── docs/superpowers/       # 教学方案设计文档
```

## 贡献

欢迎贡献！请阅读 [CONTRIBUTING.md](./CONTRIBUTING.md) 了解如何：
- 改进教学内容和步骤
- 添加新的教学模块
- 完善验证脚本
- 修复错误

本项目遵守 [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md)。

## 进阶学习

完成全部 6 个核心模块后：
- 📖 [Pro Git](https://git-scm.com/book/zh/v2) — 免费在线 Git 权威书籍
- 🎮 [Learn Git Branching](https://learngitbranching.js.org/) — 交互式 Git 学习游戏
- 🔧 Module 6 — 本仓库的进阶模块（rebase、cherry-pick、bisect）

## License

MIT © 2026

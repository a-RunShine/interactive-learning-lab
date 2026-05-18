# 通用交互式教学平台

> **想学什么？告诉 AI Agent，它会像老师一样一步步教你。**

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)

## 这是什么？

一个领域无关的 AI Agent 引导式教学仓库。不是视频、不是文档——你 clone 这个仓库后，用 **AI 编码 Agent**（OpenCode、Claude Code、Codex）打开，告诉 Agent "我想学 X"，Agent 会自动生成教学方案、与你协商调整、然后一步步引导你学习。

```
你: "我想学 Python"
Agent: "好的，我设计了以下学习方案：[模块1: 变量与类型, 模块2: 控制流, ...]
       你觉得怎么样？要不要加一些关于面向对象的内容？"
你: "加上 OOP"
Agent: "已更新方案。准备好了吗？我们从模块1开始。"
```

## 快速开始

### 前置要求
- **一个 AI 编码 Agent**：任选以下之一

### 启动教学

```bash
# 1. 克隆仓库
git clone https://github.com/<your-org>/<repo-name>.git
cd <repo-name>

# 2. 用 AI Agent 打开目录
# OpenCode:
opencode

# Claude Code:
claude

# Codex:
codex
```

Agent 会自动加载 `teach-anything` skill，然后你只需要说出"我想学 X"。

### 想学什么？

任何主题都可以：
- "我想学 Python 基础"
- "教我写 Dockerfile"
- "我想了解数据库索引原理"
- "我想学 Git 分支管理"

## 特点

- **领域无关**：不限 Git，不限编程——想学什么都可以
- **智能协商**：AI 自动生成教学方案，你可以调整后确认
- **7 步教学法**：每个知识点经历讲解→实操→验证→反馈→模拟→测验→追问
- **多 Agent 兼容**：OpenCode、Claude Code、Codex 均可使用
- **动态适应**：模糊诉求自动追问缩小范围，确保教学精准

## 教学协议

本仓库遵循 `docs/superpowers/specs/generic-teaching-protocol.md` 中定义的 7 步教学法，由 `teach-anything` skill 驱动：

1. 概念讲解 — 生活类比建立心智模型
2. 原子任务 — 微小、明确的操作指令
3. 结果审计 — 验证操作正确性
4. 即时反馈 — 解释底层发生了什么
5. 危机模拟 — 制造可控错误加深记忆
6. 结课测验 — 综合实操验证掌握程度
7. 灵魂追问 — 原理性问题促进深层理解

## 项目结构

```
├── AGENTS.md               # OpenCode/Codex Agent 引导
├── CLAUDE.md               # Claude Code Agent 引导
├── .opencode/skills/
│   └── teach-anything/
│       └── SKILL.md        # 通用教学 skill（核心）
├── docs/superpowers/
│   └── specs/
│       └── generic-teaching-protocol.md  # 通用教学协议
├── scripts/                # 工具脚本
└── openspec/               # 变更管理与 spec 系统
```

## 贡献

欢迎贡献！请阅读 [CONTRIBUTING.md](./CONTRIBUTING.md) 了解如何改进教学 skill 或添加新的教学能力。

本项目遵守 [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md)。

## License

MIT © 2026

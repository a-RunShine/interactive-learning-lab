# 通用交互式教学平台

> **告诉 AI Agent 你想学什么，它会像老师一样一步步教你。**

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)]()
[![中文](https://img.shields.io/badge/语言-中文-blue.svg)]()
[![OpenCode](https://img.shields.io/badge/OpenCode-ready-purple.svg)]()
[![Claude Code](https://img.shields.io/badge/Claude%20Code-ready-orange.svg)]()
[![Codex](https://img.shields.io/badge/Codex-ready-blue.svg)]()

## 这是什么？

不是视频教程，不是文档，不是打字练习机。

这是一个 **AI Agent 引导式教学仓库**。你 clone 后用 AI 编码 Agent 打开，说一句"我想学 X"，Agent 就会自动生成教学方案、与你协商调整、然后一步步引导你学习。

```
你: "我想学 Python"
Agent: "好的，我设计了以下方案：
        [模块1: 变量与类型, 模块2: 控制流, 模块3: 函数, ...]
        你觉得怎么样？要不要加面向对象？"
你: "加上 OOP"
Agent: "已更新方案。准备好了吗？从模块1开始。"
│
├── 概念讲解 → 原子任务 → 结果审计 → 即时反馈
├── 危机模拟 → 结课测验 → 灵魂追问
│
└── 学完了？打开 dashboard.html 回顾学习记录
```

## 快速开始

```bash
# 1. 克隆
git clone <repo-url>
cd <repo-name>

# 2. 用 AI Agent 打开
opencode       # 或 claude / codex

# 3. 说一句
# "我想学 Python 基础"
# "教我写 Dockerfile"
# "我想了解数据库索引原理"
```

Agent 会自动加载 `teach-anything` skill，全程引导你学习。

## 教学流程

每个模块经历 7 个步骤：

| 步骤 | 做什么 | 为什么 |
|------|--------|--------|
| 1. 概念讲解 | 生活类比建立心智模型 | 先理解"是什么"和"为什么" |
| 2. 原子任务 | 一个微小、明确的操作 | 动手做，一次只学一个 |
| 3. 结果审计 | 检查操作结果 | 我怎么知道我做对了？ |
| 4. 即时反馈 | 解释底层发生了什么 | 刚才发生了什么？ |
| 5. 危机模拟 | 制造可控错误一起修复 | 犯错才能记得牢 |
| 6. 结课测验 | 综合实操验证 | 我真的学会了吗？ |
| 7. 灵魂追问 | 原理级开放问题 | 换个场景还会吗？ |

## 适合学什么

**适合**需要建立心智模型、能动手操作的知识：

```
适合                   不适合
────────────────────────────────
编程语言 / 框架         单词表 / 定义记忆
Git / Docker / SQL      事实性知识（年号人名）
架构 / 协议 / 设计      纯机械操作
工作流 / 方法论         "记住就行"的内容
```

判断标准：一个主题能不能自然地经历"理解→实操→犯错→反思"？能就上车。

## 特色功能

### 学习仪表盘

教学结束后，Agent 自动记录你的学习数据。打开 `dashboard.html`：

- **学习历史**：按时间排列的教学会话
- **进度追踪**：每个模块的完成情况
- **错误记录**：犯过的错、根因、修复方案

纯 HTML + CSS + JS，零依赖，离线可用（需 HTTP 服务器）。

### 跨会话恢复

学了一半想休息？下次说"继续学习"，Agent 接上断点：

```
你: "继续学习"
Agent: "上次学到模块2「控制流」第3步，继续还是先回顾一下？"
```

### 错误 RCA 引导

遇到错误时，Agent 不直接给答案，而是引导你思考：

```
Agent: "看最后一行——TypeError 说类型不匹配，你觉得是哪个变量的问题？"
你: "...是不是 age 是字符串？"
Agent: "对了！input() 返回字符串，需要 int() 转换。"
```

然后自动记入错误日志。

### 多 Agent 兼容

OpenCode / Claude Code / Codex 均可使用，行为一致。

## 项目结构

```
├── AGENTS.md                   Agent 引导
├── .opencode/skills/
│   └── teach-anything/
│       └── SKILL.md            通用教学 skill（核心）
├── dashboard.html               学习仪表盘
├── dashboard-data.json          学习数据
├── docs/superpowers/specs/
│   └── generic-teaching-protocol.md  教学协议参考
└── openspec/                   变更管理
```

## 贡献

欢迎 PR。历史变更记录在 `openspec/changes/` 下。

遵守 [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md)。

## License

MIT © 2026

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

## 前置要求

| 依赖 | 版本 | 说明 |
|------|------|------|
| AI 编码 Agent | OpenCode ≥ 1.0 / Claude Code / Codex | 教学引导引擎 |
| Python | ≥ 3.10 | 检查点管理、数据持久化（标准库，零 pip 依赖） |
| Git | ≥ 2.30 | 克隆仓库、版本管理 |

教学脚本无需安装——直接通过 Agent 调用，不依赖任何第三方包。

## 快速开始

```bash
# 1. 克隆
git clone https://github.com/a-RunShine/interactive-learning-lab.git
cd interactive-learning-lab

# 2. 用 AI Agent 打开
opencode       # 或 claude / codex

# 3. 说一句
# "我想学 Python 基础"
# "教我写 Dockerfile"
# "我想了解数据库索引原理"

# 4. （可选）检查仓库一致性
bash scripts/check-consistency.sh
```

Agent 会自动加载 `teach-anything` skill，全程引导你学习。无需手动安装任何东西。

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
适合                     不适合
─────────────────────────────────
编程语言 / 框架           单词表 / 定义记忆
Git / Docker / SQL        事实性知识（年号人名）
架构 / 协议 / 设计        纯机械操作
工作流 / 方法论           "记住就行"的内容
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
├── AGENTS.md                    Agent 行为引导（完整教学规范）
├── scripts/
│   └── check-consistency.sh     仓库一致性自检脚本
├── .opencode/skills/
│   └── teach-anything/
│       ├── SKILL.md              通用教学 skill（核心规范源）
│       ├── references/
│       │   └── rca-protocol.md   错误 RCA 引导协议
│       └── scripts/
│           ├── teach-state.py     检查点管理（init/step/next/get）
│           └── teach-data.py      数据持久化（会话记录归档）
├── .claude/skills/
│   └── teach-anything/           Claude Code 同步副本
├── dashboard.html                 学习仪表盘（零依赖）
├── dashboard-data.json            学习数据存储
├── docs/superpowers/specs/
│   └── generic-teaching-protocol.md  教学协议参考（三层索引）
├── learn-*/                       教学练习目录（gitignored）
└── openspec/                      变更管理（proposal/design/specs/tasks）
```

## 开发

### 修改教学 skill

核心文件为 `.opencode/skills/teach-anything/SKILL.md`。修改后必须同步到 `.claude/`：

```bash
cp -r .opencode/skills/teach-anything .claude/skills/teach-anything
```

### 仓库一致性检查

```bash
bash scripts/check-consistency.sh
```

检查三项：
1. `.opencode/` 和 `.claude/` 文件内容一致（防止两边不同步）
2. SKILL.md 引用的脚本路径真实存在
3. 退出码方案与脚本中的 `sys.exit()` 一致

### 贡献规范

- 分支：`main`
- 提交：`feat:` / `fix:` / `docs:` / `chore:`
- 教学数据文件（`dashboard-data.json`、`learn-*/`）由 Agent 自动操作，不要手动编辑

## 贡献

欢迎 PR。历史变更记录在 `openspec/changes/` 下。

遵守 [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md)。

## License

MIT © 2026

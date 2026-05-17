# AGENTS.md

This file provides guidance to OpenCode and Codex agents when working in this repository.

## 仓库定位

「Git 交互式教学实验室」— 一个面向零基础用户的 Git 命令行教学仓库。学习方式：**AI Agent 引导式对话**，用户在真实 `module-N/` 目录中实操。

## 教学协议

**必须遵循** `TEACHING_PROTOCOL.md` 中定义的完整教学协议，包括：
- 6+1 模块的严格依赖顺序（M0 → M1 → M2 → M3 → M4 → M5，M6 可选）
- 7 步教学流程（概念讲解 → 原子任务 → 结果审计 → 即时反馈 → 危机模拟 → 结课测验 → 灵魂追问）
- 错误 RCA 引导协议（禁止直接给出答案）

## 项目结构

```
docs/superpowers/
├── specs/                # 教学方案设计
│   └── 2026-05-13-git-cli-teaching-design.md
└── plans/                # 实施计划
    └── 2026-05-13-git-cli-teaching-plan.md

module-0/ 至 module-6/    # 教学模块（6 个核心 + 1 个可选）
├── STEPS.md              # 教学步骤脚本（Agent 读取入口）
└── ...                   # 练习文件

scripts/
├── verify/               # 自动化验证脚本
│   ├── utils.sh
│   └── module-N.sh
├── badge.sh              # 成就与进度追踪
└── reset.sh              # 重置练习环境

TEACHING_PROTOCOL.md      # 教学协议（本文件引用的核心）
```

## 教学模块

| 模块 | 主题 | 前置依赖 |
|------|------|---------|
| 0 | 命令行生存手册 | 无 |
| 1 | Git 起步 | 模块 0 |
| 2 | 分支管理 | 模块 1 |
| 3 | 远程协作 | 模块 2 |
| 4 | 历史追溯与回退 | 模块 3 |
| 5 | 综合实战 | 模块 1-4 |
| 6 | 进阶技巧（可选） | 模块 5 |

## Agent 操作手册

### 开始教学模块
1. 读取 `TEACHING_PROTOCOL.md` 理解教学协议
2. 读取 `module-N/STEPS.md` 了解该模块教学步骤
3. 按 STEPS.md 编号顺序执行教学，每个 Step 遵循 7 步流程
4. 每步完成后运行 `scripts/verify/module-N.sh` 验证

### 验证命令
```bash
ls -R module-N/                            # 目录结构
git -C module-N log --oneline --graph --all # Git 历史（模块 1-5）
scripts/verify/module-N.sh                 # 自动化验证
```

### 提交规范
- 使用约定式提交：`feat:`、`fix:`、`docs:`、`chore:`
- 模块完成时提交：`git add module-N/ && git commit -m "feat(module-N): 完成xxx模块"`

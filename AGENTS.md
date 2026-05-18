# AGENTS.md

This file provides guidance to OpenCode and Codex agents when working in this repository.

## 仓库定位

「通用交互式教学平台」— 基于 `teach-anything` skill 的 AI Agent 引导式教学仓库。用户表达"我想学 X"即可触发教学，不限定任何领域。

## 通用教学 Skill

本仓库的核心是 `teach-anything` skill（`.opencode/skills/teach-anything/SKILL.md`）。

**加载条件**：用户说"我想学 X"、"教我 X"、"学 X"等表达学习诉求时。

**教学协议**：参考 `docs/superpowers/specs/generic-teaching-protocol.md`

**教学流程**：
1. 诉求接收 → 模糊诉求追问缩小范围
2. 方案起草 → 动态生成模块列表
3. 方案协商 → 用户调整直到确认
4. 逐模块 7 步教学 → 按确认方案执行

## 项目结构

```
.opencode/skills/
└── teach-anything/
    └── SKILL.md                # teach-anything 通用教学 skill

docs/superpowers/
└── specs/
    └── generic-teaching-protocol.md  # 通用教学协议（领域无关）

openspec/                       # 变更管理与 spec 系统
├── config.yaml
├── specs/                      # 正式 spec
└── changes/                    # 进行中/已归档的变更
```

## Agent 操作手册

### 被加载为 teach-anything skill 时

当检测到用户表达学习意图，自动加载 `.opencode/skills/teach-anything/SKILL.md` 并按其中定义的 Phase 1（方案协商）→ Phase 2（7 步教学）执行。

### 常规仓库操作

- 使用约定式提交：`feat:`、`fix:`、`docs:`、`chore:`
- 分支：`main`

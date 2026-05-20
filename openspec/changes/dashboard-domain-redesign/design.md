## Context

当前仪表盘 `dashboard.html`（618 行，零依赖 HTML/CSS/JS）从单一数据源 `dashboard-data.json` 加载学习记录，展示统计卡片、session 列表和错误记录。`dashboard-data.json` 由 `teach-data.py` 在教学结束后通过 stdin 追加写入，数据结构为 `{sessions: [{topic, date, modules, errors}]}`。

活跃教学进度存储在 `learn-<topic>/.teaching-state.json` 中，由 `teach-state.py` 管理，二者当前无关联——仪表盘只能看到已归档的完成记录，看不到进行中的学习。

本设计旨在引入领域分类，并完全重设计仪表盘视觉效果。

## Goals / Non-Goals

**Goals:**
1. 领域分类数据支持：Agent 自动推断 → 固定选项兜底，`teach-state.py init --domain` 写入检查点
2. 仪表盘视觉重设计：领域分组卡片、学习时间线、连续天数
3. 双数据源合并：`teach-state.py list`（活跃进度） + `dashboard-data.json`（历史记录），前端 join

**Non-Goals:**
- 不引入第三方 JS/CSS 框架（保持零依赖）
- 不改变 `teach-data.py` 的 stdin 管道接口
- 不修改已有检查点文件的 schema（`--domain` 可选，缺省为"未分类"）
- 不引入后台或数据库

## Decisions

### D1：Domain 写入检查点（而非仅存档）

**选择：** `teach-state.py init` 新增可选 `--domain` 参数，`list` 输出包含 `domain`。

**替代方案：**
- 方案 B：domain 仅在 `dashboard-data.json` 存档时写入 → 仪表盘需 join 两份数据来补 domain，更复杂
- 方案 C：在 `.teaching-state.json` 外再建一个 `.domain` 文件 → 碎片化

**理由：** 检查点是教学全生命周期的真实来源（init → step → next），domain 跟随 init 写入后无需额外数据源。`list` 一把输出，仪表盘零 join 即获取 domain。

### D2：领域推断规则——意图优先于工具

**选择：** 按意图关键词 → 工具关键词 优先级链式匹配，命中即停。

**规则表（内置 SKILL.md）：**
```
意图关键词:
  数据分析/数据科学/ML/爬虫/统计学    → 数据与算法
  API/微服务/后端/全栈/系统设计       → 架构与设计
  CI/CD/K8s/部署/运维/命令行          → 工具与平台
  工作流/方法论/团队/项目/敏捷/scrum  → 工作流与方法论

工具关键词（兜底）:
  Python/JavaScript/Go/Rust/...       → 编程语言
  Docker/Git/Linux/Nginx/MySQL/...   → 工具与平台
  SQL/Redis/MongoDB/...               → 数据与算法
```

**理由：** "学 Python 数据分析"的核心意图是数据分析，Python 只是载体。意图关键词先匹配可避免领域归属错误。全未命中则给用户固定选项。

### D3：仪表盘双数据源合并策略

**选择：** 方案 A — Agent 在需要展示仪表盘时预生成 `active-topics.json`，dashboard 前端 fetch 两个 JSON 文件做 merge。

**数据流：**
```
Agent (SKILL.md 触发):
  teach-state.py list > active-topics.json   ← 预生成静态 JSON

dashboard.html:
  fetch active-topics.json  → activeTopics[]  {topic, domain, currentModule, totalModules, currentStep, completed, updated}
  fetch dashboard-data.json → archiveSessions[]{topic, domain, date, modules, errors}
  merge on topic:
    - topic 在 activeTopics 中存在 → 用 list 进度 + archive 的 errors 和 domain
    - topic 仅在 archive 中 → 用 archive 数据（显示为已完成）
    - domain 优先取 activeTopics 中的（init 时写入），activeTopics 无则取 archive 的
```

**触发时机：**
- 用户说"看仪表盘"时，Agent 先跑 `list > active-topics.json`，再引导打开 `dashboard.html`
- `dashboard.html` 始终 fetch 本地文件，无需 Python 运行时

**替代方案：**
- 方案 B：`dashboard.html` 内嵌提示让用户手动跑命令 → UX 差，与"成就感"目标矛盾
- 方案 C：Agent 把 list 结果拼进对话 → 不是可视化仪表盘
- 方案 D：统一数据源（全部写入 dashboard-data.json）→ dashboard-data.json 不再只是存档，需要改写逻辑

**理由：** 静态 HTML 无法执行系统命令。预生成 JSON 文件保持了零依赖架构，Agent 承担生成责任，dashboard 是纯静态消费者。

### D4：仪表盘布局架构

**选择：** 混合布局——顶部统计栏 + 领域分组 + 时间线。

```
┌─────────────────────────────────────────┐
│  🔥 连续 7 天      6 主题    15 模块完成  │  统计栏
├─────────────────────────────────────────┤
│  学习领域                                 │  筛选: [全部] [编程] [工具] [数据]
├─────────────────────────────────────────┤
│  🐍 编程语言  ■■■■□□□  57%              │
│  ┌────────────────────────────────┐     │
│  │ Python  ▓▓▓▓▓░░  3/4          │     │  领域分组卡片
│  │  基础✅ 函数▶️  类⏳  异步⏳    │     │  (per-domain accordion/grid)
│  └────────────────────────────────┘     │
│  ┌────────────────────────────────┐     │
│  │ JavaScript  ░░░░░░  0/2       │     │
│  └────────────────────────────────┘     │
├─────────────────────────────────────────┤
│  学习时间线                               │  按"今天/昨天/日期"分段
│   今天  Python-函数 第4步                 │
│   昨天  Docker-镜像 完成 ✅               │
│   5月18日  Git-暂存区 开始 🆕             │
├─────────────────────────────────────────┤
│  ⚠️ 错误记录 (2)  [展开]                  │  折叠区
└─────────────────────────────────────────┘
```

### D5：连续天数算法

**选择：** 从所有 session 的 `date` + 活跃 topic 的 `updated` 取日期集合，从当天往回数连续的天数。

```
calculateStreak(dates):
  sorted unique dates, descending
  expected = today
  streak = 0
  for date in dates:
    if date == expected → streak++, expected--
    else → break
  return streak
```

**理由：** 活跃 topic（从 list 获取）的 `updated` 日期也算入；当天无学习时从昨天开始数（此时 streak 从 0 开始但昨天有则 +1）。

### D6：领域推断时机

**选择：** 在 Phase 1 方案协商结束后、执行 `init` 前，Agent 完成推断/提问。

**流程：**
1. 方案确认 → Agent 遍历意图关键词映射表
2. 命中 → 静默使用该 domain 执行 `init learn-<topic> --topic "..." --domain "<domain>" --modules "..."`
3. 未命中 → 给用户选项 `[编程语言|工具与平台|数据与算法|架构与设计|工作流与方法论|其他]`，用户选择后执行
4. 教学结束 save 时，Agent 从检查点 `get` 读取 domain，包含在 stdin 数据中传给 `teach-data.py`

## Risks / Trade-offs

- **[R1] list 子命令依赖 CWD 和文件系统** → `list` 只在仓库根目录下有 checkpoints 时工作。仪表盘部署到其他路径时需调整 glob 路径或内嵌数据。
- **[R2] 领域推断可能错误** → 提供了"全部未命中时给用户选项"的兜底。如果用户不满意推断结果，可在 Phase 1 协商时纠正。
- **[R3] active-topics.json 可能过期** → Agent 在每次教学结束时自动刷新 `list > active-topics.json`。用户打开仪表盘时，Agent 也先刷新再引导打开。`check-consistency.sh` 可校验文件时间戳。
- **[R4] 双数据源合并可能产生不一致** → merge 策略以 `active-topics` 的进度为准、`archive` 补 errors，保证活跃数据优先。已完成 topic 仅依赖 archive。
- **[R5] 仪表盘重写后旧 dashboard-data.json 数据兼容性** → `domain` 为可选字段，缺失时显示"未分类"分组。旧 session 无 domain 不会导致崩溃。

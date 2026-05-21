## Why

当前学习仪表盘只展示平面的 session 卡片列表，缺乏领域分类、学习连续天数、时间线叙事和成就感反馈。用户完成了多个主题后看到的只是"3 个主题，4 个模块完成"——没有领域归属感，没有"连续努力"的正反馈，也没有"我学到了什么"的叙事。需要对仪表盘进行领域分类数据支持和视觉重设计。

## What Changes

- **teach-state.py**：`init` 新增可选 `--domain` 参数，`list` 输出包含 `domain` 字段。领域可选值：`编程语言` / `工具与平台` / `数据与算法` / `架构与设计` / `工作流与方法论` / `其他`
- **SKILL.md**：方案协商后、执行 `init` 前，Agent 按意图关键词→工具关键词优先级推断 domain，置信时静默使用，未命中则给用户固定选项
- **dashboard-data.json**：`teach-data.py save` 时继承检查点中的 domain，无需 schema 变更
- **dashboard.html**：完全重设计，新增领域分组卡片、学习连续天数、学习时间线。合并 `teach-state.py list`（活跃进度）和 `dashboard-data.json`（历史记录+错误）两份数据源
- **一致性同步**：`.claude/skills/` 跟 `.opencode/skills/` 保持一致

## Capabilities

### New Capabilities

- `dashboard-domain`：学习主题的领域分类能力——包含 Agent 自动推断映射表、用户手动选择兜底、检查点数据流和 dashboard-data.json 写入
- `dashboard-visual`：仪表盘视觉重设计——领域分组、学习时间线、连续天数、差错展示的 UI 和双数据源合并逻辑

### Modified Capabilities

（无现有主 spec 需修改）

## Impact

- `teach-state.py`：新增 `--domain` 参数（可选）、`list` 输出新增字段
- SKILL.md：新增领域推断规则（意图优先级映射表 + 提问流程）
- `dashboard.html`：完全重写（原 618 行）
- `teach-data.py`：无变动（`domain` 为可选字段自动透传）
- `dashboard-data.json`：数据结构不变，新增 `domain` 字段

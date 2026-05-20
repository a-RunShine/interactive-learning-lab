## ADDED Requirements

### Requirement: teach-state.py init SHALL accept optional --domain parameter
`teach-state.py init` SHALL accept an optional `--domain` argument that stores the domain value in `.teaching-state.json`.

#### Scenario: Init with domain specified
- **WHEN** Agent executes `teach-state.py init learn-python --topic "Python" --domain "编程语言" --modules "基础,函数,类"`
- **THEN** `.teaching-state.json` SHALL contain `"domain": "编程语言"`

#### Scenario: Init without domain
- **WHEN** Agent executes `teach-state.py init learn-python --topic "Python" --modules "基础,函数,类"` without `--domain`
- **THEN** `.teaching-state.json` SHALL NOT contain `domain` field, and `list` shall treat it as domain-less

### Requirement: teach-state.py list SHALL output domain field when available
`teach-state.py list` SHALL include `domain` in each topic's output when the domain field exists in `.teaching-state.json`.

#### Scenario: List with domain present
- **WHEN** a topic's `.teaching-state.json` contains `"domain": "编程语言"`
- **THEN** `list` output for that topic SHALL include `"domain": "编程语言"`

#### Scenario: List without domain
- **WHEN** a topic's `.teaching-state.json` does NOT contain a `domain` field
- **THEN** `list` output for that topic SHALL include `"domain": "未分类"`

### Requirement: Agent SHALL infer domain using intent-then-tool priority matching
The teach-anything Agent SHALL determine the domain using a priority-ordered keyword matching table in SKILL.md.

#### Scenario: Intent keyword matched
- **WHEN** user says "学 Python 数据分析"
- **THEN** Agent SHALL match "数据分析" → `数据与算法` before checking "Python" → `编程语言`

#### Scenario: Tool keyword matched as fallback
- **WHEN** user says "学 Python" with no intent keyword matched
- **THEN** Agent SHALL fall back to "Python" → `编程语言`

#### Scenario: No keyword matched
- **WHEN** domain cannot be inferred from any keyword
- **THEN** Agent SHALL prompt the user with fixed options: `[编程语言 | 工具与平台 | 数据与算法 | 架构与设计 | 工作流与方法论 | 其他]`

### Requirement: Agent SHALL pass domain from checkpoint to teach-data.py save
When saving a session to `dashboard-data.json`, the Agent SHALL read the domain from `.teaching-state.json` and include it in the stdin JSON passed to `teach-data.py save`.

#### Scenario: Domain inherited from checkpoint
- **WHEN** Agent saves a completed teaching session and `.teaching-state.json` contains `"domain": "编程语言"`
- **THEN** the stdin JSON to `teach-data.py` SHALL include `"domain": "编程语言"`

#### Scenario: Domain missing from checkpoint
- **WHEN** Agent saves a completed teaching session and `.teaching-state.json` does NOT contain `domain`
- **THEN** Agent SHALL prompt the user to select a domain from the fixed options list before saving

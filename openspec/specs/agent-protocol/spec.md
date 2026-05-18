## ADDED Requirements

### Requirement: Repository MUST include AGENTS.md for Codex/OpenCode agents
The repository SHALL include an AGENTS.md file at the root that describes the repository as a generic teaching platform powered by the `teach-anything` skill.

#### Scenario: Agent reads AGENTS.md on session start
- **WHEN** an OpenCode or Codex agent starts a session in this repository
- **THEN** the agent SHALL read AGENTS.md to understand the teach-anything skill loading conditions

### Requirement: Protocol MUST define the 7-step teaching flow
The `teach-anything` skill SHALL specify the canonical 7-step teaching flow: 概念讲解 → 原子任务 → 结果审计 → 即时反馈 → 危机模拟 → 结课测验 → 灵魂追问.

#### Scenario: Agent follows 7-step flow during teaching
- **WHEN** the agent teaches any topic via the teach-anything skill
- **THEN** it SHALL follow the 7-step flow defined in the skill

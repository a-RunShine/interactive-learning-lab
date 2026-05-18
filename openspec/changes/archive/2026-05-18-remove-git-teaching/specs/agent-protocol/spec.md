## MODIFIED Requirements

### Requirement: Repository MUST include AGENTS.md for Codex/OpenCode agents
The repository SHALL include an AGENTS.md file at the root that follows the OpenCode/Codex convention for agent guidance files. AGENTS.md SHALL describe the repository as a generic teaching platform powered by the `teach-anything` skill, not a Git-specific teaching lab.

#### Scenario: Agent reads AGENTS.md on session start
- **WHEN** an OpenCode or Codex agent starts a session in this repository
- **THEN** the agent SHALL read AGENTS.md to understand that the repository is a generic teaching platform using the `teach-anything` skill

### Requirement: Protocol MUST define the 7-step teaching flow
The `teach-anything` skill SHALL specify the canonical 7-step teaching flow used in every module: 概念讲解 → 原子任务 → 结果审计 → 即时反馈 → 危机模拟 → 结课测验 → 灵魂追问.

#### Scenario: Agent follows 7-step flow during teaching
- **WHEN** the agent teaches any topic via the teach-anything skill
- **THEN** it SHALL follow the 7-step flow defined in the skill

## REMOVED Requirements

### Requirement: Both AGENTS.md and CLAUDE.md MUST reference a shared TEACHING_PROTOCOL.md
**Reason**: TEACHING_PROTOCOL.md has been deleted. Protocol content lives in `.opencode/skills/teach-anything/SKILL.md`.
**Migration**: AGENTS.md delegates to the `teach-anything` skill. CLAUDE.md is not affected (skill does not depend on it).

### Requirement: Protocol MUST define module dependency order
**Reason**: Module-dependent teaching (M0→M1→M2→M3→M4→M5) has been removed. Teaching order is now dynamically negotiated per topic.
**Migration**: No migration needed.

### Requirement: Protocol MUST define error RCA (Root Cause Analysis) flow
**Reason**: RCA is now defined in the teach-anything skill (SKILL.md) rather than TEACHING_PROTOCOL.md.
**Migration**: Reference `.opencode/skills/teach-anything/SKILL.md` for RCA protocol.

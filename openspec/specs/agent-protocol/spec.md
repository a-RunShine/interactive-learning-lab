## ADDED Requirements

### Requirement: Repository MUST include AGENTS.md for Codex/OpenCode agents
The repository SHALL include an AGENTS.md file at the root that follows the OpenCode/Codex convention for agent guidance files.

#### Scenario: Agent reads AGENTS.md on session start
- **WHEN** an OpenCode or Codex agent starts a session in this repository
- **THEN** the agent SHALL read AGENTS.md to understand the teaching protocol and module structure

### Requirement: Repository MUST include CLAUDE.md for Claude Code agents
The repository SHALL include a CLAUDE.md file at the root that follows the Claude Code convention for project instructions.

#### Scenario: Claude Code reads CLAUDE.md on session start
- **WHEN** a Claude Code agent starts a session in this repository
- **THEN** the agent SHALL read CLAUDE.md to understand the teaching protocol and module structure

### Requirement: Both AGENTS.md and CLAUDE.md MUST reference a shared TEACHING_PROTOCOL.md
The two agent guidance files SHALL delegate detailed teaching protocol to a single source of truth: `TEACHING_PROTOCOL.md`. This avoids duplication and ensures consistency.

#### Scenario: Teaching protocol is maintained in one file
- **WHEN** a teaching rule needs to be updated
- **THEN** only TEACHING_PROTOCOL.md needs to be modified, not both AGENTS.md and CLAUDE.md

### Requirement: Protocol MUST define the 7-step teaching flow
TEACHING_PROTOCOL.md SHALL specify the canonical 7-step teaching flow used in every module: 概念讲解 → 原子任务 → 结果审计 → 即时反馈 → 危机模拟 → 结课测验 → 灵魂追问.

#### Scenario: Agent follows 7-step flow during teaching
- **WHEN** the agent teaches any module
- **THEN** it SHALL follow the 7-step flow defined in TEACHING_PROTOCOL.md

### Requirement: Protocol MUST define module dependency order
TEACHING_PROTOCOL.md SHALL document the strict sequential dependency: M0 → M1 → M2 → M3 → M4 → M5, and agents MUST NOT skip modules.

#### Scenario: Agent prevents out-of-order teaching
- **WHEN** a user requests content from module 3 before completing module 2
- **THEN** the agent SHALL redirect the user to complete prerequisite modules first

### Requirement: Protocol MUST define error RCA (Root Cause Analysis) flow
TEACHING_PROTOCOL.md SHALL document the guided error diagnosis protocol: locate error line → ask leading questions → fill knowledge gaps → archive to error log.

#### Scenario: Agent handles user error with RCA
- **WHEN** a user reports a command error
- **THEN** the agent SHALL follow RCA protocol instead of giving the answer directly

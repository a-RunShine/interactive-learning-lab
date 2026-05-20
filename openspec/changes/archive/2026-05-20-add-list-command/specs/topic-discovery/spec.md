## ADDED Requirements

### Requirement: Agent can list all active learning topics
The system SHALL provide a `list` subcommand that scans `learn-*` directories for `.teaching-state.json` files and returns a JSON array of active topics with their progress.

Each entry SHALL include a `completed` boolean field indicating whether all modules in the topic's plan are finished.

#### Scenario: Multiple active topics exist
- **WHEN** user says "继续学习" or "有什么可学的"
- **THEN** agent runs `teach-state.py list` and receives a JSON array with entries for each topic that has a valid `.teaching-state.json`

#### Scenario: No active topics
- **WHEN** user says "继续学习" and no `learn-*/.teaching-state.json` files exist
- **THEN** `teach-state.py list` returns an empty array `[]` with exit code 0

#### Scenario: Corrupted checkpoint file
- **WHEN** a `.teaching-state.json` file exists but contains invalid JSON
- **THEN** the list output includes an error entry for the corrupted file with description, and does not block other valid files from being reported

#### Scenario: Completed topic is included in list
- **WHEN** a topic's plan has all modules with `completed: true`
- **THEN** the list entry has `"completed": true`, enabling agent to display it as "✅ 已学完"

#### Scenario: In-progress topic shows progress
- **WHEN** a topic's plan has some modules not yet completed
- **THEN** the list entry has `"completed": false`, with `currentModule`, `totalModules`, `currentStep` reflecting the current position

### Requirement: Resume flow handles 0/1/N topics
The SKILL.md recovery flow SHALL branch based on the number of active topics discovered by `teach-state.py list`.

#### Scenario: Single topic (current behavior preserved)
- **WHEN** `teach-state.py list` returns exactly one entry
- **THEN** agent proceeds directly to showing progress and asking to continue

#### Scenario: Single completed topic
- **WHEN** `teach-state.py list` returns exactly one entry with `completed: true`
- **THEN** agent displays "✅ Python — 已学完" instead of "要恢复吗"

#### Scenario: Multiple topics with disambiguation
- **WHEN** `teach-state.py list` returns N entries (N > 1)
- **THEN** agent presents numbered options to user showing topic name, completion status, and progress, and waits for selection before resuming

#### Scenario: Exact topic match bypasses list
- **WHEN** user says "继续学 Python" (exact topic name)
- **THEN** agent skips `list` and directly runs `get learn-python` to resume

### Requirement: List output is scannable by agent
The `list` output SHALL include machine-parseable progress fields that do not require string splitting.

#### Scenario: Progress fields are numeric
- **WHEN** agent parses `list` JSON output
- **THEN** `currentModule` and `totalModules` are integers, enabling direct comparison and display without string manipulation

#### Scenario: currentStep of 0 indicates not started
- **WHEN** output has `"currentStep": 0`
- **THEN** agent displays "尚未开始" rather than "第 0 步"

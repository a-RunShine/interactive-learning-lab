## REMOVED Requirements

### Requirement: Module-based STEPS.md system
**Reason**: All module-N/ directories and their STEPS.md files have been deleted. Repository now uses the `teach-anything` skill for dynamic teaching content generation.
**Migration**: No migration needed.

## ADDED Requirements

### Requirement: Each module MUST include a STEPS.md file
Every `module-N/` directory SHALL contain a `STEPS.md` that lists the teaching steps for that module in order, with each step specifying: action description, expected output, and verification command.

#### Scenario: Agent reads module-0 STEPS.md
- **WHEN** the agent begins teaching module-0
- **THEN** it SHALL read `module-0/STEPS.md` to get the ordered list of teaching steps

### Requirement: STEPS.md MUST be consumable by AI agents
The STEPS.md format SHALL use clear markdown headers and code blocks that an AI agent can parse and follow sequentially. Steps SHALL be numbered.

#### Scenario: Steps are sequentially numbered
- **WHEN** an agent parses STEPS.md
- **THEN** it SHALL find sequentially numbered steps (1., 2., 3.) that form a logical progression

### Requirement: STEPS.md MUST reference verify scripts
Each module's STEPS.md SHALL reference the corresponding verify script from `scripts/verify/` as the checkpoint for step completion.

#### Scenario: Step references verification
- **WHEN** a step description mentions a checkpoint
- **THEN** it SHALL include the exact verify command to run (e.g., `scripts/verify/module-1.sh`)

### Requirement: STEPS.md MUST include concept explanations alongside commands
Each step in STEPS.md SHALL include both the "why" (concept explanation) and the "how" (command to execute), preserving the pedagogical approach from the design spec.

#### Scenario: Step has concept + command sections
- **WHEN** an agent reads a step
- **THEN** the step SHALL include both a concept explanation section and a command section

### Requirement: Module exercises SHALL be self-contained within their directories
Each module-N/ directory SHALL contain all files needed for that module's exercises. Cross-module file references are prohibited.

#### Scenario: Module-2 exercises use only module-2/
- **WHEN** a user works on module-2
- **THEN** all commands SHALL operate within `module-2/` and not reference files from other modules

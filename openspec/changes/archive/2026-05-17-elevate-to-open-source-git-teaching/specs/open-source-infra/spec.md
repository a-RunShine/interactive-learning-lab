## ADDED Requirements

### Requirement: Repository MUST include README.md
The README.md SHALL describe the project's purpose (AI-agent-driven Git interactive teaching), target audience, module structure, prerequisites, and quick start instructions.

#### Scenario: New visitor reads README
- **WHEN** a new user visits the GitHub repository
- **THEN** README.md SHALL explain what the project is, who it's for, and how to start learning

### Requirement: README MUST include badges and "Start Learning" section
README.md SHALL display CI status badge, license badge, and a "Start Learning" section with copy-paste commands to launch the experience with various AI agents.

#### Scenario: User copies quick-start command
- **WHEN** a user reads the "Start Learning" section
- **THEN** they SHALL find a one-line command to clone and launch (e.g., `git clone <repo> && cd <repo> && claude` or `opencode`)

### Requirement: Repository MUST include LICENSE file
The LICENSE file SHALL use the MIT License.

#### Scenario: License file exists
- **WHEN** a contributor checks for usage permissions
- **THEN** they SHALL find LICENSE in the repository root with MIT License text

### Requirement: Repository MUST include CONTRIBUTING.md
CONTRIBUTING.md SHALL document how to add new modules, write verification scripts, submit improvements to teaching content, and the required PR process.

#### Scenario: Contributor reads contributing guide
- **WHEN** a potential contributor wants to add a module
- **THEN** CONTRIBUTING.md SHALL provide step-by-step instructions for creating new teaching content

### Requirement: Repository MUST include CODE_OF_CONDUCT.md
CODE_OF_CONDUCT.md SHALL adopt the Contributor Covenant v2.1 to ensure a welcoming community.

#### Scenario: Code of conduct is accessible
- **WHEN** a community member needs to report a conduct issue
- **THEN** CODE_OF_CONDUCT.md SHALL provide reporting guidelines

### Requirement: Repository MUST include GitHub issue templates
The `.github/ISSUE_TEMPLATE/` directory SHALL include templates for: bug report, teaching content improvement, and feature request.

#### Scenario: User submits bug report
- **WHEN** a user opens a new issue
- **THEN** they SHALL be presented with templates for bug report, content improvement, and feature request

### Requirement: Repository MUST include CI workflow (.github/workflows/)
A CI workflow SHALL run on every PR and push to main, executing: shell script syntax check (shellcheck), verify script smoke tests, and module structure validation.

#### Scenario: CI runs on PR
- **WHEN** a PR is opened against the main branch
- **THEN** CI SHALL run shellcheck on all scripts and smoke-test verify scripts

### Requirement: Repository MUST include reset.sh
`scripts/reset.sh` SHALL reset all `module-N/` directories to their initial committed state, removing any user-generated files and commits within those directories.

#### Scenario: Learner resets all modules
- **WHEN** a user runs `scripts/reset.sh`
- **THEN** all `module-N/` directories SHALL be restored to their clean state as in the repository

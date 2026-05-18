## ADDED Requirements

### Requirement: Repository MUST include README.md
The README.md SHALL describe the project's purpose (AI-agent-driven generic interactive teaching), target audience, and quick start instructions referencing the `teach-anything` skill.

#### Scenario: New visitor reads README
- **WHEN** a new user visits the GitHub repository
- **THEN** README.md SHALL explain what the project is (generic teaching platform), who it's for, and how to start learning any topic

### Requirement: README MUST include quick start commands
README.md SHALL include a "快速开始" section with copy-paste commands to clone and launch with various AI agents.

#### Scenario: User copies quick-start command
- **WHEN** a user reads the "快速开始" section
- **THEN** they SHALL find commands to clone the repo and launch with opencode or claude

### Requirement: Repository MUST include LICENSE file
The LICENSE file SHALL use the MIT License.

#### Scenario: License file exists
- **WHEN** a contributor checks for usage permissions
- **THEN** they SHALL find LICENSE in the repository root with MIT License text

### Requirement: Repository MUST include CONTRIBUTING.md
CONTRIBUTING.md SHALL document how to contribute to the teach-anything skill and the repository's open spec system.

#### Scenario: Contributor reads contributing guide
- **WHEN** a potential contributor wants to improve the skill
- **THEN** CONTRIBUTING.md SHALL provide instructions for modifying skill content

### Requirement: Repository MUST include CODE_OF_CONDUCT.md
CODE_OF_CONDUCT.md SHALL adopt the Contributor Covenant v2.1 to ensure a welcoming community.

#### Scenario: Code of conduct is accessible
- **WHEN** a community member needs to report a conduct issue
- **THEN** CODE_OF_CONDUCT.md SHALL provide reporting guidelines

### Requirement: Repository MUST include GitHub issue templates
The `.github/ISSUE_TEMPLATE/` directory SHALL include templates for: bug report, skill improvement, and feature request.

#### Scenario: User submits bug report
- **WHEN** a user opens a new issue
- **THEN** they SHALL be presented with templates for bug report, skill improvement, and feature request

### Requirement: Repository MUST include CI workflow (.github/workflows/)
A CI workflow SHALL run on every PR and push to main, executing basic repository structure validation.

#### Scenario: CI runs on PR
- **WHEN** a PR is opened against the main branch
- **THEN** CI SHALL validate repository structure

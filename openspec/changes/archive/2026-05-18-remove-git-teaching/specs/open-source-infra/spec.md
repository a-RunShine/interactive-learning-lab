## MODIFIED Requirements

### Requirement: Repository MUST include README.md
The README.md SHALL describe the project's purpose (AI-agent-driven generic interactive teaching), how to use the `teach-anything` skill, and quick start instructions.

#### Scenario: New visitor reads README
- **WHEN** a new user visits the GitHub repository
- **THEN** README.md SHALL explain what the project is (generic teaching platform), who it's for, and how to start learning any topic

## REMOVED Requirements

### Requirement: README MUST include badges and "Start Learning" section
**Reason**: The "Start Learning" section no longer references module-based Git teaching. The primary entry is now the teach-anything skill.
**Migration**: Update README to provide a link to the `.opencode/skills/teach-anything/SKILL.md` file or its documentation.

### Requirement: Repository MUST include CONTRIBUTING.md
**Reason**: The repository no longer has module-N/ directories or verify scripts, making the existing CONTRIBUTING guide obsolete.
**Migration**: Replace CONTRIBUTING.md with a simplified guide for contributing to the teach-anything skill itself.

### Requirement: Repository MUST include reset.sh
**Reason**: No module-N/ directories remain to reset.
**Migration**: Remove scripts/reset.sh.

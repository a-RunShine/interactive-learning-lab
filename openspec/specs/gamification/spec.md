## REMOVED Requirements

### Requirement: Badge and progress tracking system
**Reason**: `scripts/badge.sh` and `PROGRESS.md` have been removed. The teach-anything skill does not use pre-defined modules or badge-based progress tracking.
**Migration**: No migration needed.

## ADDED Requirements

### Requirement: Repository MUST include a PROGRESS.md tracker
The root-level PROGRESS.md SHALL display the learner's progress: completed modules as checked items with dates, and remaining modules as unchecked items.

#### Scenario: Progress file shows module status
- **WHEN** PROGRESS.md is viewed
- **THEN** it SHALL show each module (M0-M5) as checked (✓) or unchecked (☐) with completion date

### Requirement: Each module completion SHALL claim a badge
The `scripts/badge.sh` script SHALL support `claim` command that marks a module as complete in `PROGRESS.md` and records a timestamp.

#### Scenario: Learner claims module-1 badge
- **WHEN** a user runs `scripts/badge.sh claim module-1`
- **THEN** PROGRESS.md SHALL be updated to mark module-1 as completed with the current date

### Requirement: Badge script SHALL verify before claiming
The `badge.sh claim` command SHALL first run the corresponding verify script. If verification fails, the badge SHALL NOT be claimed.

#### Scenario: Claim fails when verification fails
- **WHEN** a user runs `scripts/badge.sh claim module-1` but `scripts/verify/module-1.sh` fails
- **THEN** the badge SHALL NOT be claimed and an error message SHALL be printed

### Requirement: Full completion SHALL trigger a "graduation" ceremony
When all 6 modules (M0-M5) are claimed, `scripts/badge.sh` SHALL print a graduation message and suggest next learning resources.

#### Scenario: All modules complete
- **WHEN** a user claims the last remaining module badge
- **THEN** the script SHALL print a congratulatory message and link to advanced resources (Pro Git book, Learn Git Branching)

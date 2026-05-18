## REMOVED Requirements

### Requirement: Verify script infrastructure
**Reason**: All verify scripts at `scripts/verify/` have been deleted as part of removing module-based teaching. Verification is now ad-hoc within the teach-anything skill's 结果审计 step.
**Migration**: No migration needed.

## ADDED Requirements

### Requirement: Verification scripts MUST be POSIX Shell compatible
All verification scripts in `scripts/verify/` SHALL use POSIX Shell syntax (no bashisms) to ensure compatibility across Linux, macOS, and Git Bash on Windows.

#### Scenario: Script runs on Ubuntu
- **WHEN** a verification script is executed on Ubuntu with `/bin/sh`
- **THEN** it SHALL run without errors

#### Scenario: Script runs on macOS
- **WHEN** a verification script is executed on macOS with `/bin/sh`
- **THEN** it SHALL run without errors

#### Scenario: Script runs on Git Bash (Windows)
- **WHEN** a verification script is executed on Git Bash for Windows
- **THEN** it SHALL run without errors

### Requirement: Each module MUST have a corresponding verify script
The repository SHALL provide `scripts/verify/module-0.sh` through `scripts/verify/module-5.sh`, each validating the expected state of that module's exercise directory.

#### Scenario: Verify module-0 structure
- **WHEN** `scripts/verify/module-0.sh` is executed
- **THEN** it SHALL check that `module-0/quiz/` has the correct file structure

#### Scenario: Verify module-1 git state
- **WHEN** `scripts/verify/module-1.sh` is executed
- **THEN** it SHALL validate `module-1/` has an initialized git repo with expected commits

### Requirement: Verify scripts MUST exit with meaningful codes
Scripts SHALL exit with code 0 for pass, 1 for fail, and print clear "✓" or "✗" messages describing what was checked.

#### Scenario: Verification passes
- **WHEN** all checks in a verify script pass
- **THEN** the script SHALL print "✓ All checks passed" and exit 0

#### Scenario: Verification fails
- **WHEN** any check in a verify script fails
- **THEN** the script SHALL print "✗ [check description]" and exit 1

### Requirement: Verify scripts MUST accept a --quiet flag
Scripts SHALL support `--quiet` flag to suppress output (exit code only), suitable for CI usage.

#### Scenario: Quiet mode in CI
- **WHEN** `scripts/verify/module-0.sh --quiet` is executed in CI
- **THEN** the script SHALL produce no output and exit with appropriate code

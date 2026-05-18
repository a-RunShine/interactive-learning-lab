## REMOVED Requirements

### Requirement: Verification scripts MUST be POSIX Shell compatible
**Reason**: All verify scripts at scripts/verify/ have been deleted as part of the removal of Git-specific teaching infrastructure.
**Migration**: Verification is now performed ad-hoc by the AI agent using domain-appropriate commands during the "结果审计" step of the teach-anything skill.

### Requirement: Each module MUST have a corresponding verify script
**Reason**: Module-N/ directories and their associated verify scripts no longer exist.
**Migration**: No migration needed.

### Requirement: Verify scripts MUST exit with meaningful codes
**Reason**: Verify scripts no longer exist.
**Migration**: No migration needed.

### Requirement: Verify scripts MUST accept a --quiet flag
**Reason**: Verify scripts no longer exist.
**Migration**: No migration needed.

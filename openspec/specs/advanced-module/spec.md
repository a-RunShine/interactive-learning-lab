## REMOVED Requirements

### Requirement: Advanced module (module-6)
**Reason**: Module-6 and all other module directories have been deleted. Git advanced topics can still be taught dynamically via the teach-anything skill.
**Migration**: Use teach-anything skill to request these topics on demand.

## ADDED Requirements

### Requirement: Module-6 MUST cover interactive rebase
module-6/ SHALL teach `git rebase -i` (interactive rebase) including: squashing commits, rewording messages, reordering commits, and dropping commits.

#### Scenario: Learner squashes commits
- **WHEN** a learner works through the interactive rebase exercise
- **THEN** they SHALL use `git rebase -i` to squash multiple related commits into one

### Requirement: Module-6 MUST cover cherry-pick
module-6/ SHALL teach `git cherry-pick` for selectively applying commits from one branch to another.

#### Scenario: Learner cherry-picks a commit
- **WHEN** a learner works through the cherry-pick exercise
- **THEN** they SHALL use `git cherry-pick <hash>` to apply a specific commit to their current branch

### Requirement: Module-6 MUST cover git bisect
module-6/ SHALL teach `git bisect` for binary search through commit history to find the commit that introduced a bug.

#### Scenario: Learner bisects to find bug
- **WHEN** a learner works through the bisect exercise
- **THEN** they SHALL use `git bisect` with `start`, `bad`, `good` commands to locate the faulty commit

### Requirement: Module-6 MUST cover GitHub Flow
module-6/ SHALL teach the GitHub Flow model: feature branch → commits → PR → code review → merge to main. This SHALL be taught conceptually (PR review simulation via local workflow).

#### Scenario: Learner simulates GitHub Flow
- **WHEN** a learner works through the GitHub Flow exercise
- **THEN** they SHALL create a feature branch, make commits, simulate a "merge" via local merge, replicating the PR flow

### Requirement: Module-6 SHOULD be optional (no dependency from module-5)
module-6 SHALL NOT be a dependency for any other module. It SHALL be clearly marked as "进阶内容" (advanced content) for learners who have completed M0-M5.

#### Scenario: Learner skips module-6
- **WHEN** a learner finishes module-5
- **THEN** they can optionally proceed to module-6, but it is NOT required for "graduation"

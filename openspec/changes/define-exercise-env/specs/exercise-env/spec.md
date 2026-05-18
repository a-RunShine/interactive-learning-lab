## ADDED Requirements

### Requirement: Agent SHALL create module exercise directories
When entering a new module in Phase 2, the agent SHALL create a dedicated directory at `learn-<topic>/module-N-<name>/` for storing exercise files.

#### Scenario: Entering first module of Python learning
- **WHEN** Phase 2 begins with module-1 "变量与类型"
- **THEN** agent SHALL create `learn-python/module-1-types/` directory

#### Scenario: Entering second module
- **WHEN** module-1 completes and module-2 begins
- **THEN** agent SHALL create `learn-python/module-2-control-flow/` directory (separate from module-1)

### Requirement: Exercise files SHALL be written to the module directory
All files produced during 原子任务, 危机模拟, and 结课测验 steps SHALL be written inside the module's exercise directory.

#### Scenario: Atomic task produces a Python file
- **WHEN** agent gives an atomic task asking the user to write a variable assignment
- **THEN** agent SHALL create `learn-python/module-1-types/exercise_01.py` with the exercise content

#### Scenario: Crisis simulation writes a buggy file
- **WHEN** agent demonstrates a common error during 危机模拟
- **THEN** agent SHALL create a separate file in the module directory for the buggy version

### Requirement: Agent SHALL prompt for cleanup on completion
When all modules in the learning plan are complete, the agent SHALL ask the user whether to keep or delete the exercise directories.

#### Scenario: All modules finished
- **WHEN** the last module's 7 steps are complete
- **THEN** agent SHALL ask "练习文件在 learn-<topic>/ 目录下，要保留还是删除？"

## ADDED Requirements

### Requirement: 学习诉求接收

Skill SHALL 在加载时提示用户输入学习诉求，格式为"我想学 X"或"我想了解 X"。

#### Scenario: 用户输入学习主题

- **WHEN** 用户说"我想学 Python"
- **THEN** skill 确认主题并进入方案起草阶段

#### Scenario: 用户输入模糊诉求

- **WHEN** 用户说"我想学编程"
- **THEN** skill SHALL 追问以缩小范围，例如"你想学哪种编程语言？Web 开发还是数据科学？"

### Requirement: 学习方案自动起草

Skill SHALL 根据用户诉求自动生成学习方案，方案包含模块列表（每个模块有标题、学习目标、预计步骤数）。

#### Scenario: 生成 Python 学习方案

- **WHEN** 用户确认"我想学 Python 基础"
- **THEN** skill 生成方案，包含：变量与类型、控制流、函数、数据结构、文件操作等模块

### Requirement: 方案协商

Skill SHALL 将方案展示给用户，支持用户调整模块顺序、增减模块、修改深度，直至用户确认。

#### Scenario: 用户要求添加模块

- **WHEN** 用户说"再加一个面向对象编程"
- **THEN** skill 在方案中插入 OOP 模块并重新展示

#### Scenario: 用户确认方案

- **WHEN** 用户说"可以，开始学习"
- **THEN** skill 锁定方案并进入逐模块教学阶段

### Requirement: 逐模块 7 步教学

Skill SHALL 按确认后的方案逐模块执行 7 步教学流程。

#### Scenario: 教学模块执行

- **WHEN** 进入第一个模块"变量与类型"
- **THEN** skill 依次执行：概念讲解 → 原子任务 → 结果审计 → 即时反馈 → 危机模拟 → 结课测验 → 灵魂追问

#### Scenario: 模块完成

- **WHEN** 当前模块的 7 步流程全部完成
- **THEN** skill 询问是否进入下一模块，或回顾当前模块

### Requirement: 错误 RCA 引导

教学中遇到用户错误时，skill SHALL 遵循 RCA（根因分析）引导协议，禁止直接给出答案。

#### Scenario: 用户代码报错

- **WHEN** 用户执行练习时遇到 `TypeError`
- **THEN** skill SHALL 追问启发用户定位问题，而非直接告知错误原因

### Requirement: 领域兼容

Skill SHALL 支持复用本仓库的 Git 模块内容（module-0 至 module-6）作为教学内容源。

#### Scenario: 加载 Git 模块

- **WHEN** 用户说"我想学 Git 分支管理"
- **THEN** skill SHALL 使用现有 module-2/ 中的内容结构和脚本进行教学，而非动态生成

## MODIFIED Requirements

### Requirement: 错误 RCA 引导

教学中遇到用户错误时，skill SHALL 遵循 RCA（根因分析）引导协议，禁止直接给出答案。RCA 协议的完整内容定义在 `references/rca-protocol.md`。

#### Scenario: 用户代码报错

- **WHEN** 用户执行练习时遇到 `TypeError`
- **THEN** skill SHALL 读取 `references/rca-protocol.md` 并追问启发用户定位问题，而非直接告知错误原因

#### Scenario: 步骤 6 全错

- **WHEN** 步骤 6 结课测验用户答案完全错误
- **THEN** skill SHALL 走 RCA 引导协议（定义见 `references/rca-protocol.md`），用户执意跳过时尊重选择

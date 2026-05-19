# Workflow Isolation Design

> 将 `teach-anything` SKILL.md 的侧系统拆分为独立 workflow 文件。

## Motivation

SKILL.md 当前 326 行，混合了主线教学流程和条件触发的侧系统逻辑。侧系统（检查点恢复、RCA 引导、数据持久化、环境管理）有独立的进入条件和执行路径，与主线没有串行依赖。拆出后可降低 SKILL.md 认知负载，使每个文件职责单一。

## File Structure

```
.opencode/skills/teach-anything/
├── SKILL.md                    ← 主线 Orchestrator (~200行)
└── workflows/
    ├── resume.md               ← 检查点恢复
    ├── rca.md                  ← 错误 RCA 引导
    ├── data-persist.md         ← 会话数据持久化
    └── env-manage.md           ← 教学环境管理
```

## Workflow Definitions

### resume.md — 检查点恢复

**Trigger**: 用户说"继续学习"或"继续"

**Behavior**:
1. 检查 `learn-<topic>/` 目录是否存在
2. 读取 `.teaching-state.json`
3. 展示当前进度："上次学到模块 N「名称」的第 M 步，继续还是先回顾一下？"
4. 用户确认后从断点继续
5. 若文件不存在，走正常 Phase 1 协商

**File format**:
```json
{
  "topic": "Python",
  "plan": [
    { "name": "变量与类型", "completed": true, "stepsDone": 7 },
    { "name": "控制流", "completed": false, "stepsDone": 3 }
  ],
  "currentModuleIndex": 1,
  "currentStep": 3
}
```

### rca.md — 错误 RCA 引导

**Trigger**: 教学中用户遇到错误/步骤 6 结课测验全错

**Behavior**:
1. 定位锚点 — 指出错误输出的关键行
2. 线索追问 — 反问引导（最多 2 轮）
3. 原理补漏 — 卡壳后补充知识点
4. 归档学习 — 建议用户记录错误

**Rules**:
- 禁止直接给正确答案
- 用户坚持跳过则放行

### data-persist.md — 会话数据持久化

**Trigger**: 教学结束（全部完成或用户退出）

**Behavior**:
1. 读取 `dashboard-data.json`（不存在则创建 `{ "sessions": [] }`）
2. 构建会话记录：`{ topic, date, modules[], errors[] }`
3. 追加到 `sessions` 数组
4. 写回文件
5. 提示："学习记录已保存，打开 dashboard.html 查看"

**Rules**:
- 仅实质性交互（至少完成 1 个教学步骤）才写入
- 读→追加→写回连续执行，异常重读
- 日期格式：`YYYY-MM-DD` 本地日期

### env-manage.md — 教学环境管理

**Trigger**: 进入每个模块时 / 全部模块完成时

**Behavior**:
- 创建 `learn-<topic>/module-N-<name>/` 目录
- 写入 `exercise_01.py` / `buggy.py` / `quiz.py`
- 目录已存在时询问覆盖或新建
- 非操作型知识不创建文件

**Cleanup**:
- 全部模块完成后询问保留或删除

## No Behavioral Changes

所有 workflow 的行为、规则、边界与当前 SKILL.md 完全一致。本次变更仅为提取+引用，不改变教学逻辑。

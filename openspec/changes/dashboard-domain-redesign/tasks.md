## 1. teach-state.py: --domain 支持

- [ ] 1.1 `init` 子命令新增可选 `--domain` 参数，写入 `domain` 字段到检查点 JSON
- [ ] 1.2 `list` 输出每项包含 `domain` 字段（存在则输出，缺失则输出 "未分类"）
- [ ] 1.3 更新 argparse help 文本（其他子命令无需变更）

## 2. SKILL.md: 领域推断 + 流程集成

- [ ] 2.1 内置领域推断映射表（意图关键词优先 → 工具关键词兜底），写在 SKILL.md 的"Phase 2 逐模块教学"前的独立小节
- [ ] 2.2 方案协商结束后、`init` 执行前，Agent 执行推断流程：匹配 → 静默使用 / 未匹配 → 给用户固定选项
- [ ] 2.3 教学保存流程更新：`get` 检查点读取 domain，包含在传给 `teach-data.py save` 的 stdin JSON 中
- [ ] 2.4 恢复流程（通用扫描分支）中，`list` 输出已含 domain，无需额外处理
- [ ] 2.5 教学结束保存后及用户说"看仪表盘"时，Agent 执行 `teach-state.py list > active-topics.json` 刷新活跃数据

## 3. dashboard.html 重设计

- [ ] 3.0 Agent 在展示仪表盘前 / 教学结束时执行 `teach-state.py list > active-topics.json`，dashboard fetch 此文件
- [ ] 3.1 双数据源合并逻辑（fetch active-topics.json + dashboard-data.json，按 topic merge）
- [ ] 3.2 连续天数计算与展示（🔥 连续 N 天）
- [ ] 3.3 领域分组卡片（按 domain group，每领域显示进度总览 + per-topic 模块条）
- [ ] 3.4 领域筛选标签（全部 / 各领域动态生成）
- [ ] 3.5 学习时间线（今天 / 昨天 / 日期分组，显示 topic + 当前模块 + 步骤/完成状态）
- [ ] 3.6 错误记录区域（保留现有功能，按当前领域筛选联动）
- [ ] 3.7 CSS 视觉重设计——强调进度感与成就感（领域 emoji、填充动画、完成✓标记、含昨日学习标记）

## 4. 一致性同步

- [ ] 4.1 `.claude/skills/teach-anything/` 同步 `.opencode/` 副本（teach-state.py + SKILL.md）
- [ ] 4.2 `check-consistency.sh` 验证通过
- [ ] 4.3 `.gitignore` 追加 `active-topics.json`

## 5. 验证测试

- [ ] 5.1 `teach-state.py init --domain` 烟雾测试
- [ ] 5.2 `teach-state.py list` 含 domain 输出验证
- [ ] 5.3 `teach-state.py init` 无 domain 时 list 输出 "未分类"
- [ ] 5.4 `dashboard.html` 在浏览器中打开验证（造测试数据：多 domain、有已完成、有进行中）

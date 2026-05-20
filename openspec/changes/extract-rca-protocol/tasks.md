## 1. 创建 RCA 协议参考文件

- [ ] 1.1 创建 `.opencode/skills/teach-anything/references/` 目录
- [ ] 1.2 从 SKILL.md L264-291 提取完整 RCA 协议内容，写入 `references/rca-protocol.md`，包括：4 步引导流程（定位锚点 → 线索追问 → 原理补漏 → 归档学习）+ 步骤 6 联动说明 + 用户执意跳过处理
- [ ] 1.3 在 `rca-protocol.md` 末尾添加"本协议由 SKILL.md 引用，请勿直接在 SKILL.md 中重复维护"

## 2. 更新 SKILL.md

- [ ] 2.1 删除 SKILL.md 中"# 错误 RCA 引导协议"整节（L264-291），替换为一行 `详细指引见 references/rca-protocol.md`
- [ ] 2.2 修改步骤 6 分支中的 RCA 引用：原"走 RCA 引导协议（定位+追问+补漏）"改为"走 RCA 引导协议（详见 references/rca-protocol.md）"
- [ ] 2.3 确认 SKILL.md 首部"前置资源"部分新增声明："RCA 引导协议存放在 references/rca-protocol.md，仅在学生出错时按需读取"

## 3. 同步与验证

- [ ] 3.1 同步 `.claude/skills/teach-anything/`：`cp -r .opencode/skills/teach-anything/ .claude/skills/teach-anything/`
- [ ] 3.2 对比 `.opencode/` 和 `.claude/` 下两个文件（SKILL.md + rca-protocol.md）内容一致
- [ ] 3.3 确认 SKILL.md 中无残余 RCA 协议全文（grep 检查"定位锚点"等关键词不应出现在 SKILL.md 中）

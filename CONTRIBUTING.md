# Contributing

感谢你对 Git 交互式教学实验室的关注！

## 如何贡献

### 改进教学内容
- 修改 `module-N/STEPS.md` 中的教学步骤、概念解释或测验题目
- 确保步骤顺序逻辑清晰，每步包含「概念 + 命令 + 验证」

### 添加新模块
1. 创建 `module-N/` 目录
2. 编写 `STEPS.md`（参考现有模块格式）
3. 编写 `scripts/verify/module-N.sh` 验证脚本
4. 更新 `TEACHING_PROTOCOL.md` 中的模块依赖表
5. 更新 `README.md` 中的模块列表

### 改进验证脚本
- 验证脚本位于 `scripts/verify/`
- 共享函数在 `scripts/verify/utils.sh`
- 新脚本需支持 `--quiet` 模式
- 使用 POSIX Shell 语法（兼容 Linux/macOS/Git Bash）

### 报告问题
- Bug 报告：使用 `.github/ISSUE_TEMPLATE/bug_report.md`
- 内容改进：使用 `.github/ISSUE_TEMPLATE/content_improvement.md`
- 功能建议：使用 `.github/ISSUE_TEMPLATE/feature_request.md`

## 开发环境

```bash
# 语法检查
shellcheck scripts/**/*.sh

# 验证脚本测试
for i in scripts/verify/module-*.sh; do
    echo "Testing $i..."
    sh "$i" --quiet || echo "FAIL: $i"
done

# 重置测试环境
scripts/reset.sh
```

## 提交规范

- 使用约定式提交：`feat:`、`fix:`、`docs:`、`chore:`
- 教学模块提交：`feat(module-N): 描述`
- 文档提交：`docs: 描述`
- 脚本提交：`chore: 描述`

## PR 流程

1. Fork 仓库
2. 创建 feature 分支：`feat/your-feature`
3. 提交修改
4. 确保 shellcheck 通过
5. 提交 PR 到 `main` 分支

感谢你的贡献！

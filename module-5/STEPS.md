# Module 5: 综合实战

> **验证**：`scripts/verify/module-5.sh`

## 场景 A: Web 开发

1. git init + .gitignore
2. feat/login 分支开发 login.html/css/js
3. 多次提交 → 合并 → 发现 bug → revert → 修复

## 场景 B: 算法库

1. brute-force 分支（暴力解）
2. optimized 分支（哈希表）
3. 写到一半 git stash → 切分支参考 → stash pop
4. 合并 optimized → main

## 危机模拟

```bash
git stash && git switch main && # 修 bug
git switch - && git stash pop
```

## 测验

≥5 commits, ≥1 branch, ≥1 merge, ≥1 stash, ≥1 回退

**验证**：`scripts/verify/module-5.sh`

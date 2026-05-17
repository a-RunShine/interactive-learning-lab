# Module 4: 历史追溯与回退

> **验证**：`scripts/verify/module-4.sh`

## Step 1: git diff

```bash
cd module-4/ && git init
echo "def add(a,b): return a+b" > calc.py
git add . && git commit -m "feat: add"
echo "def sub(a,b): return a-b" >> calc.py
git diff && git add . && git diff --staged && git commit -m "feat: sub"
```

## Step 2: Detached HEAD

```bash
git log --oneline  # 记一个 hash
git checkout <hash>  # 脱离！
git switch main     # 回来
```

## Step 3: revert vs reset

```bash
echo "L1" > n.txt && git add . && git commit -m "L1"
echo "L2" >> n.txt && git add . && git commit -m "L2"
echo "L3" >> n.txt && git add . && git commit -m "L3"
git revert HEAD  # 安全撤销
git reset --hard HEAD~2  # 提交"消失"
git reflog  # 找到旧 hash
git reset --hard <hash>  # 回来！
```

## Step 4: stash

```bash
echo "WIP" > t.txt && git stash && git status  # clean
git stash pop && cat t.txt  # 回来
```

## Step 5: 测验

reset --hard 后 reflog 找回 + revert 安全撤销

**验证**：`scripts/verify/module-4.sh`

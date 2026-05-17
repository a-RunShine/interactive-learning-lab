# Module 2: 分支管理

> **验证**：`scripts/verify/module-2.sh`

## Step 1: 分支是指针

```bash
cd module-2/ && git init
echo "# M2" > README.md && git add . && git commit -m "docs: init"
```

## Step 2: 创建与切换

```bash
git branch feat/login && git switch feat/login
echo "def login(): pass" > login.py
git add . && git commit -m "feat: login"
git switch main && ls  # login.py 消失！
```

## Step 3: Fast-Forward + 三方合并

```bash
git merge feat/login  # fast-forward
git branch feat/pay && git switch feat/pay
echo "def pay(): pass" > pay.py && git add . && git commit -m "feat: pay"
git switch main
echo "def utils(): pass" > utils.py && git add . && git commit -m "feat: utils"
git merge feat/pay  # 三方合并
git log --oneline --graph --all
```

## Step 4: 冲突解决

```bash
echo "main" > c.txt && git add . && git commit -m "feat: c"
git switch -c feat/c && echo "feature" > c.txt && git add . && git commit -m "feat: c"
git switch main && echo "main v2" > c.txt && git add . && git commit -m "feat: c"
git merge feat/c  # CONFLICT!
# 手动编辑 c.txt，保留要的内容，删除 <<< === >>>
git add c.txt && git commit -m "fix: resolve conflict"
```

## Step 5: 测验

feat/dashboard 分支 → 2 次提交 → main 1 次提交 → 合并 → graph 展示

**验证**：`scripts/verify/module-2.sh`

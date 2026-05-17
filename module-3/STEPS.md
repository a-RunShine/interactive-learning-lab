# Module 3: 远程协作

> **验证**：`scripts/verify/module-3.sh`

## Step 1: 创建远程

```bash
cd module-3/ && git init --bare remote-repo.git
```

## Step 2: 推送

```bash
git init local-dev && cd local-dev
echo "# P" > README.md && git add . && git commit -m "docs: init"
git remote add origin ../remote-repo.git
git push -u origin main
```

## Step 3: 协作

```bash
cd module-3/ && git clone remote-repo.git collab-dev
cd collab-dev && echo "c" > c.txt && git add . && git commit -m "feat: c"
git push && cd ../local-dev && git pull && git log --oneline
```

## Step 4: Pull 冲突

```bash
# 协作者 push
cd collab-dev && echo "collab" > s.txt && git add . && git commit -m "feat: s" && git push
# 本地没 pull 改同一文件
cd ../local-dev && echo "local" > s.txt && git pull  # 失败！
# 解决：git add s.txt && git commit -m "feat: s" && git pull
```

## Step 5: 测验

bare repo → 克隆两个目录 → 各自提交 → push/pull → 制造冲突 → 解决

**验证**：`scripts/verify/module-3.sh`

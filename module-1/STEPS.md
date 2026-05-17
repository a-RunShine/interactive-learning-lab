# Module 1: Git 起步

> **验证**：`scripts/verify/module-1.sh`

## Step 1: 三棵树模型

| 区域 | 类比 |
|------|------|
| 工作区 | 货架前挑选商品 |
| 暂存区 | 收银台 |
| 仓库 | 付款收据 |

## Step 2: 第一次提交

```bash
cd module-1/ && git init
git config user.name "You" && git config user.email "you@x.com"
echo "# Git 学习笔记" > README.md
git status && git add README.md && git status
git commit -m "docs: init project"
```

## Step 3: 多次提交

```bash
mkdir -p src
echo 'print("hi")' > src/main.py
git add src/main.py && git commit -m "feat: add main"
git log --oneline
```

## Step 4: .gitignore

```bash
cat > .gitignore << 'EOF'
*.class
.idea/
*.log
target/
EOF
git add .gitignore && git commit -m "chore: add gitignore"
```

## Step 5: 测验

创建 `java-app/` 含 src/target/.idea，配置 .gitignore 忽略 target 和 .idea，用约定式提交。

**验证**：`scripts/verify/module-1.sh`

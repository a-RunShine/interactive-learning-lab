# Module 6: 进阶技巧（可选）

> **验证**：`scripts/verify/module-6.sh`

## Topic 1: Interactive Rebase

```bash
cd module-6/ && git init
echo "v1" > a.txt && git add . && git commit -m "v1"
echo "v2" >> a.txt && git add . && git commit -m "v2"
echo "v3" >> a.txt && git add . && git commit -m "v3"
echo "v4" >> a.txt && git add . && git commit -m "v4"
git rebase -i HEAD~3  # squash v2+v3+v4 → 1 commit
```

## Topic 2: Cherry-Pick

```bash
git checkout -b feat/a
echo "a" > a.txt && git add . && git commit -m "feat: a"
H=$(git rev-parse --short HEAD)
git checkout -b feat/b main
echo "b" > b.txt && git add . && git commit -m "feat: b"
git cherry-pick $H  # a.txt 出现！
```

## Topic 3: Bisect

```bash
echo "v1" > c.py && git add . && git commit -m "v1"
echo "v2" >> c.py && git add . && git commit -m "v2"
echo "BUG" >> c.py && git add . && git commit -m "v3"
echo "v4" >> c.py && git add . && git commit -m "v4"
git bisect start && git bisect bad && git bisect good HEAD~3
grep BUG c.py && git bisect bad || git bisect good
git bisect reset
```

## Topic 4: GitHub Flow

```bash
git checkout -b feat/x
echo "x" > x.txt && git add . && git commit -m "feat: x"
git switch main && git merge feat/x && git branch -d feat/x
```

## 测验

rebase 合并 commit + cherry-pick + bisect 找 bug + GitHub Flow

**验证**：`scripts/verify/module-6.sh`

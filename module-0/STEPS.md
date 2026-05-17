# Module 0: 命令行生存手册

> **Agent 教学入口**：按 Step 顺序执行。每步讲解概念后让用户动手操作。
> **验证脚本**：`scripts/verify/module-0.sh`

---

## Step 1: 认识终端与 Shell

**概念**：终端是输入输出界面，Shell 是命令解释器。

## Step 2: 文件系统导航

| 命令 | 作用 |
|------|------|
| `pwd` | 当前在哪 |
| `ls` | 有什么 |
| `cd` | 去哪 |

`. = 当前`, `.. = 上级`, `~ = 家目录`

```bash
cd module-0/ && pwd && ls -a
mkdir prac_nav && cd prac_nav && pwd && cd ..
```

## Step 3: 文件操作

```bash
cd module-0/prac_nav/
echo "hello" > a.txt && cat a.txt
touch b.java c.class d.class && ls
```

## Step 4: 通配符

```bash
ls *.class && rm *.class && ls
```

## Step 5: Vim 退出困境

`i` 插入 → `Esc` Normal → `:wq` 保存退出 / `:q!` 强制退出

## Step 6: 命令行技巧

Tab 补全、↑ 历史、Ctrl+C 中断

## Step 7: 测验

创建 `module-0/quiz/src/Main.java` 和 `module-0/quiz/out/Main.class`
用 `rm *.class` 删除编译产物

**验证**：`scripts/verify/module-0.sh`

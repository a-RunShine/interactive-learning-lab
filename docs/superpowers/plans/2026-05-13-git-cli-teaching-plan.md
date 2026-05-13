# Git 命令行教学系统 — 实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 通过交互式教学，从零教会用户 Git 核心命令流（日常 80% 场景），同时建立命令行操作能力。

**架构：** 6 个顺序模块，每个模块独立目录（`module-0/` 至 `module-5/`），教学遵循概念讲解 → 动手练习 → 动态检查 → 即时反馈 → 场景化模拟 → 测验验证 → 深度提问的七步流程。每个模块严格依赖前一个模块的能力。

**依赖前提：** 无。用户零命令行基础、零 Git 基础。

---

### Task 0: 创建练习目录与初始化

**Files:**
- Create: `module-0/.gitkeep`
- Create: `module-1/.gitkeep`
- Create: `module-2/.gitkeep`
- Create: `module-3/.gitkeep`
- Create: `module-4/.gitkeep`
- Create: `module-5/.gitkeep`

- [ ] **Step 1: 创建目录结构**

```bash
cd "c:/Users/k/Desktop/WorkSpace-CC/git学习"
mkdir -p module-{0,1,2,3,4,5}
touch module-0/.gitkeep module-1/.gitkeep module-2/.gitkeep
touch module-3/.gitkeep module-4/.gitkeep module-5/.gitkeep
git add module-*/.gitkeep
git commit -m "chore: 创建教学模块练习目录"
```

---

### Task 1: 教学模块 0 — 命令行生存手册

**目录：** `module-0/`

**教学目标：** 掌握终端导航、文件操作、通配符、Vim 基本操作。

**本模块的 7 步教学流程：**

- [ ] **Step 1: 概念讲解 — Shell、终端、命令行**
  - 解释：Shell 是命令解释器，终端是输入输出界面，命令行是交互方式
  - Windows 下的 Bash 环境说明（当前环境就是 Git Bash）
  - 说明路径：在此交互中，我们直接用 Claude Code 的 Bash 工具执行命令

- [ ] **Step 2: 概念讲解 — 文件系统导航**
  - `pwd`：当前在哪
  - `ls`：有什么（-l 详细、-a 显示隐藏、-R 递归）
  - `cd`：去哪（`.` 当前、`..` 上级、`~` 家目录、绝对路径 vs 相对路径）
  - 演示后在 `module-0/` 内创建 `prac_nav/` 子目录让用户练习 cd

- [ ] **Step 3: 动手练习 + 动态检查 — 导航操作**
  - 用户执行 `cd module-0` → `mkdir prac_nav` → `cd prac_nav` → `pwd` → `ls -a` → `cd ..`
  - **动态检查：** 自动运行 `ls -R module-0/` 验证目录结构

- [ ] **Step 4: 概念讲解 — 文件操作 + 通配符**
  - `mkdir` 创建目录、`touch` 创建空文件、`echo "text" > file` 写入内容、`cat` 查看、`rm` 删除、`mv` 移动/重命名
  - 通配符：`*` 匹配任意、`?` 匹配单个、`[abc]` 匹配集合，`rm *.class` 清理产物

- [ ] **Step 5: 动手练习 — 文件操作 + 通配符**
  - 在 `prac_nav/` 下执行：`echo "hello" > a.txt` → `touch b.java c.class d.class` → `ls *.class` → `rm *.class` → `ls`
  - **动态检查：** `ls -R module-0/prac_nav/` 确认 `.class` 文件被删除

- [ ] **Step 6: 场景化模拟 — 退出困境（Vim）**
  - 概念：Vim 模式（Normal vs Insert），`i` 进入插入，`Esc` 回 Normal
  - 写一个文本保存并用 `:wq` 退出
  - 解释：为什么 `git commit` 不加 `-m` 会进 Vim — 编辑器等待你写提交信息
  - **场景：** 让用户打开 Vim、输入文字、保存退出

- [ ] **Step 7: 命令行技巧 + 盲打挑战**
  - Tab 补全路径
  - ↑ 历史命令
  - Ctrl+C 中断当前命令
  - **练习：** 让用户输入 `cd mod` 按 Tab、用 ↑ 找回之前命令
  - **盲打挑战：** 创建一个很长名字的目录 `very-long-directory-name-for-practice`，要求用户**只敲前 3-4 个字母**按 Tab 补全进入，不得完整输入目录名
  - **动态检查：** `pwd` 确认已进入长目录

- [ ] **Step 8: 测验验证**
  - **测验题：** 在 `module-0/` 下创建如下结构：
    ```
    module-0/quiz/
    ├── src/
    │   └── Main.java
    └── out/
        └── Main.class
    ```
  - 要求：用 `rm` 删除 `out/` 目录下的所有 `.class` 文件（不可直接指定 `Main.class`，必须用通配符）

- [ ] **Step 9: 深度提问**
  - 提 2-3 个原理性问题：
    1. "`echo "a" > file` 和 `echo "a" >> file` 有什么区别？"
    2. "为什么 `cd ..` 能回到上级目录，`..` 到底是什么？"
    3. "Vim 里如果按了 Ctrl+S 卡住了怎么办？（提示：终端流控制）"

- [ ] **Step 10: 检查 — 所有 `.class` 已清除，目录结构正确**
  - 如果不对，提示用户补做
  - **验证：** `ls -R module-0/quiz/` 预期只有 `src/Main.java`

- [ ] **Step 11: 提交测验产物到 Git**

```bash
git add module-0/
git commit -m "feat(module-0): 完成命令行生存手册模块"
```

---

### Task 2: 教学模块 1 — Git 起步

**目录：** `module-1/`

**教学目标：** 理解 Git 三棵树模型，掌握 `init`/`add`/`commit`/`status`/`log`，学会使用 `.gitignore` 和约定式提交。

- [ ] **Step 1: 概念讲解 — 为什么需要版本控制**
  - 手动备份的痛点：目录爆炸（`report_final_v3_really_final.doc`）
  - 版本控制的承诺：记录每次修改、可回溯、可协作

- [ ] **Step 2: 概念讲解 — Git 三棵树（核心心智模型）**
  - **工作区（Working Directory）：** 你看到的文件，实际修改的地方
  - **暂存区（Staging Area / Index）：** 准备提交的快照
  - **仓库（Repository / .git）：** 保存所有历史版本
  - 类比：工作区是购物车 → 暂存区是收银台 → 仓库是结账后的收据

- [ ] **Step 3: 动手练习 — 第一次提交**
  - 用户初始化仓库：`cd module-1 && git init`
  - 配置用户信息（首次使用必须配）：`git config user.name "xxx"`、`git config user.email "yyy@zzz"`
  - 创建文件 `README.md`，写入 `# Git 学习笔记`
  - `git status` → `git add README.md` → `git status`（看颜色变化） → `git commit -m "docs: init project"`
  - **动态检查：** `git log --oneline` 验证提交成功

- [ ] **Step 4: 概念讲解 — 查看历史**
  - `git log`（详细）、`git log --oneline`（一行）、`git log --oneline --graph`（带分支图）
  - 演示返回上次提交的效果

- [ ] **Step 5: 动手练习 — 多次提交 + log**
  - 创建 `src/main.py` 写入 `print("hello")` → `git add src/main.py` → `commit -m "feat: add main script"`
  - 修改 `main.py` 加一行 → `git add` → `commit -m "feat: add greeting"`
  - `git log --oneline` 看到两条提交

- [ ] **Step 6: 概念讲解 — .gitignore**
  - 为什么需要：编译产物（`.class`、`target/`）、IDE 配置（`.idea/`）、临时文件（`*.log`、`.DS_Store`）不应入库
  - 创建 `.gitignore` 文件，常见规则
  - 推荐 [gitignore.io](https://www.toptal.com/developers/gitignore) 生成模板

- [ ] **Step 7: 动手练习 — 配置 .gitignore**
  - 在 `module-1/` 下创建 `.gitignore`，内容：
    ```
    *.class
    .idea/
    *.log
    target/
    ```
  - `echo "temp" > a.log` → `git status` 应看到 `a.log` 被忽略
  - 提交：`git add .gitignore && git commit -m "chore: add .gitignore"`

- [ ] **Step 8: 概念讲解 — 约定式提交（Conventional Commits）**
  - 格式：`<type>: <description>`
  - 常用 type：`feat:`（新功能）、`fix:`（修 bug）、`docs:`（文档）、`chore:`（杂务）、`refactor:`（重构）
  - 好处：自动生成 changelog、语义化版本、大厂/开源社区通用语言
  - 回顾刚才的提交：让用户把之前的提交改成约定式格式（用 `--amend` 或重做）

- [ ] **Step 9: 测验验证**
  - **测验题：** 在 `module-1/` 下（模拟 Java Web 项目结构）：
    1. 创建如下目录结构：
       ```
       java-app/
       ├── src/
       │   └── Main.java
       ├── target/
       │   └── app.jar
       └── .idea/
           └── workspace.xml
       ```
    2. 配置 `.gitignore` 忽略 `*.class`、`target/` 目录和 `.idea/` 文件夹
    3. 执行 `git add .` 后 `git status` 应显示只有 `src/Main.java`
    4. 提交，commit message 使用约定式格式

- [ ] **Step 10: 深度提问**
  - 提 2-3 个原理性问题：
    1. "如果 `git add` 后再次修改了文件，`git status` 会看到什么状态？（理解 staged 和 unstaged 共存）"
    2. "`.gitignore` 中写 `*.class` 和 `/target/` 有什么区别？（/ 前缀的含义）"
    3. "如果我把一个本应忽略的文件（如 `app.log`）不小心提交到了仓库，现在才加进 `.gitignore`，它还会被追踪吗？怎么让它真正被忽略？（涉及 `git rm --cached`，高频面试题）"
    4. "为什么不推荐 `git commit -a`？（绕过了暂存区的审阅机会）"

- [ ] **Step 11: 提交测验产物**

```bash
git add module-1/
git commit -m "feat(module-1): 完成 Git 起步模块"
```

---

### Task 3: 教学模块 2 — 分支管理

**目录：** `module-2/`

**教学目标：** 理解分支即指针，掌握 `branch`/`switch`/`restore`/`merge`，能解决合并冲突。

- [ ] **Step 1: 概念讲解 — 分支是指针**
  - 分支本质上是指向某次提交的可移动指针
  - `HEAD` 是"你当前在哪"的指针
  - 默认 `master/main` 是一个分支，创建新分支 = 创建新指针
  - 类比：分支是贴纸，贴在某个提交上

- [ ] **Step 2: 动手练习 — 初始化 + 创建分支**
  - `cd module-2 && git init` 导入三棵树心智模型（演示 `init` 创建了 `.git` 目录）
  - 创建 `README.md` 并提交（`docs: init project`）
  - `git branch` 看当前分支
  - `git branch feature/login` 创建分支
  - `git branch` 看到两个分支，`*` 号所在的为当前分支

- [ ] **Step 3: 概念讲解 — 分支命名规范**
  - 语义化前缀：`feat/xxx`（新功能）、`fix/xxx`（修 bug）、`docs/xxx`（文档）
  - 示例：`feat/login-page`、`fix/null-pointer`、`docs/api-guide`
  - 职业习惯：好名字让协作者秒懂意图

- [ ] **Step 4: 动手练习 — 切换分支**
  - `git switch feature/login`（老版 `git checkout feature/login`，两个都教）
  - `git log --oneline` 看两个分支指向同一个提交
  - 在 `feature/login` 上创建 `login.py` → `add` → `commit -m "feat: add login module"`
  - `git switch main` 发现 `login.py` 消失了（分支隔离）
  - **动态检查：** `git branch -v` 看每个分支的最新提交

- [ ] **Step 5: 概念讲解 + 动手 — git restore（撤销修改）**
  - 精分职责：`git switch` 管分支切换，`git restore` 管文件恢复 ← Git 2.23 的新分工
  - 场景：改到一半的文件想放弃修改
  - `git restore <file>`：撤销工作区的未提交修改（文件回到上次提交的状态）
  - `git restore --staged <file>`：把文件从暂存区移出，但保留工作区改动
  - **练习：** 修改 `login.py` 加一行乱码 → `git restore login.py` → 文件恢复
  - 对比旧版 `git checkout -- <file>`，了解即可，优先用 `restore`

- [ ] **Step 6: 概念讲解 — 合并分支与 fast-forward**
  - `git merge feature/login`（切回 main 后）
  - **重点解释 fast-forward：** main 只是把指针向前移动到了 feature/login 的位置，没有产生新提交
  - 这就是"为什么有时候合并没产生新提交记录"
  - 对比：如果 main 也有新提交，fast-forward 不可能，会产生三方合并 + merge commit

- [ ] **Step 7: 动手练习 — 创建三方合并场景**
  - 从当前 main 创建 `feature/payment`，切过去
  - 创建 `payment.py` → `add` → `commit -m "feat: add payment"`
  - 切回 main，创建 `utils.py` → `add` → `commit -m "feat: add utils"`（main 前进了）
  - 此时 `git merge feature/payment` → 自动产生 merge commit（非 fast-forward）
  - `git log --oneline --graph --all` 看分叉再汇合的线条

- [ ] **Step 8: 场景化模拟 — 冲突解决**
  - 刻意制造冲突：
    - main 分支上 `echo "main version" > conflict.txt` → `add` → `commit`
    - `git switch -c feature/conflict`（创建并切换）
    - 修改 `conflict.txt` 为 `"feature version"` → `add` → `commit`
    - `git switch main`，修改 `conflict.txt` 为 `"main version modified"` → `add` → `commit`
    - `git merge feature/conflict` → **CONFLICT！**
  - **引导解决：**
    - `git status` 看冲突文件
    - 打开 `conflict.txt` 看 `<<<<<<<` / `=======` / `>>>>>>>` 标记
    - 手动编辑保留正确内容 → 删除冲突标记 → `add` → `commit`
  - **验证：** `git log --oneline --graph --all` 确认冲突已解决

- [ ] **Step 9: 测验验证**
  - **测验题：** 在 `module-2/` 下：
    1. 从 `main` 创建分支 `feat/dashboard`
    2. 在 `feat/dashboard` 上提交两个改动
    3. 切回 `main`，在 `main` 上也提交一个改动
    4. 合并 `feat/dashboard` 到 `main`
    5. 执行 `git log --oneline --graph --all` 观察历史形状
    6. 解释：这次合并是 fast-forward 还是三方合并？为什么？

- [ ] **Step 10: 深度提问**
  - 提 2-3 个原理性问题：
    1. "`git switch` 本质上对工作区做了什么？为什么切分支时已提交的文件会消失/出现？"
    2. "冲突标记 `<<<<<<<` 和 `>>>>>>>` 分别代表什么？为什么一定要手动处理？"
    3. "如果合并到一半发现搞错了，如何取消合并回到之前的状态？"

- [ ] **Step 11: 提交**

```bash
git add module-2/
git commit -m "feat(module-2): 完成分支管理模块"
```

---

### Task 4: 教学模块 3 — 远程协作

**目录：** `module-3/`

**教学目标：** 理解分布式模型，掌握 `remote`/`push`/`fetch`/`pull`，能配置 SSH，能处理 pull 冲突。

- [ ] **Step 1: 概念讲解 — 分布式模型**
  - 本地仓库 vs 远程仓库：每个开发者本地都是完整仓库
  - `clone` 不是"下载"，是"复制一个完整的仓库"
  - 远程仓库的角色：中心化的"真理之源"，但 Git 本身是去中心化的

- [ ] **Step 2: 概念讲解 — SSH vs HTTPS**
  - HTTPS：每次 push 要输密码，简单但烦人
  - SSH：用密钥对认证，配置后免密
  - `ssh-keygen` 生成密钥对（`id_rsa` 私钥、`id_rsa.pub` 公钥）
  - 公钥配置到 GitHub/Gitee → SSH 握手原理

- [ ] **Step 3: 动手练习 — 模拟远程仓库**
  - 用本地目录模拟远程：`cd module-3 && git init --bare remote-repo.git`
  - 创建一个本地开发目录并推送初始提交：

  实际操作：
  ```bash
  cd module-3
  git init --bare remote-repo.git
  git init local-dev
  cd local-dev
  echo "# my project" > README.md
  git add README.md
  git commit -m "docs: init project"
  git remote add origin ../remote-repo.git
  git push -u origin main
  ```
  - **动态检查：** `cd ../remote-repo.git && git log --oneline` 验证收到提交

- [ ] **Step 4: 动手练习 — 模拟协作**
  - 创建第二个用户目录模拟协作者：
  ```bash
  cd module-3
  git clone remote-repo.git collaborator-dev
  cd collaborator-dev
  echo "collaborator change" > collab.txt
  git add collab.txt && git commit -m "feat: add collab file"
  git push
  ```
  - 回到 `local-dev`：`git pull` 拉取协作者的提交
  - **动态检查：** `git log --oneline --all` 看到来自两个"人"的提交

- [ ] **Step 5: 场景化模拟 — pull 冲突（核心防坑）**
  - 刻意制造"本地未提交就 pull"的经典事故：
  ```bash
  # 在 collaborator-dev 里
  echo "collab line" > shared.txt
  git add shared.txt && git commit -m "feat: add shared file"
  git push

  # 在 local-dev 里（不 pull，直接改同一文件）
  echo "local line" > shared.txt
  git pull  # 失败！冲突
  ```
  - **引导解决：** 提交本地 → 再 pull（`git add shared.txt && git commit -m "..."` → `git pull`）→ 或 stash
  - 核心教训：**pull 前先提交或 stash**
  - 明确记住：`pull = fetch + merge`

- [ ] **Step 6: 概念讲解 — fetch vs pull**
  - `git fetch`：从远程拉取最新数据，但不合并，安全
  - `git pull`：fetch + merge 一步到位，方便但有风险
  - 习惯：先 `fetch`，看一眼差异再 `merge`，比直接 `pull` 更稳

- [ ] **Step 7: 测验验证**
  - **测验题：** 在 `module-3/` 下：
    1. 创建一个新的 bare repo 作为"远程仓库"
    2. 克隆它到两个不同目录（模拟两人协作）
    3. 两人各提交一个文件并 push
    4. 其中一人修改对方的文件，提交后 push
    5. 另一人 pull，观察发生了什么
    6. 用 `git log --oneline --graph --all` 展示协作历史

- [ ] **Step 8: 深度提问**
  - 提 2-3 个原理性问题：
    1. "`git init --bare` 和 `git init` 有什么区别？为什么远程仓库要用 bare？"
    2. "如果 A push 了，B 在没 pull 的情况下也 push 会怎样？为什么？"
    3. "`git push -u origin main` 中的 `-u` 的作用是什么？"

- [ ] **Step 9: 提交**

```bash
git add module-3/
git commit -m "feat(module-3): 完成远程协作模块"
```

---

### Task 5: 教学模块 4 — 历史追溯与回退

**目录：** `module-4/`

**教学目标：** 掌握 `diff`、`log --graph`、`revert`/`reset`、`reflog`、`stash`。

- [ ] **Step 1: 概念讲解 — 差异查看**
  - `git diff`：工作区 vs 暂存区
  - `git diff --staged`：暂存区 vs 上次提交
  - `git diff <commit1> <commit2>`：两次提交之间的差异

- [ ] **Step 2: 动手练习 — diff 实战**
  - `cd module-4 && git init`
  - 创建 `calc.py` 提交 → 修改后 `git diff` 看差异 → `git add` → `git diff --staged`
  - **动态检查：** 对比 `git diff` 和 `git diff --staged` 输出的区别

- [ ] **Step 3: 动手练习 — 可视化历史**
  - 制造分叉历史（创建分支、多次提交、合并）
  - `git log --oneline --graph --all` 看漂亮的线条图
  - 对照练习：在每个分支上多做几次提交，让 graph 更丰富

- [ ] **Step 4: 场景化模拟 — Detached HEAD（游离头指针）**
  - 场景：用户 `git checkout <commit-hash>` 而不是分支名
  - 终端会警告：`You are in 'detached HEAD' state...`
  - **制造：** `git log --oneline` 取一个 hash → `git checkout <hash>` → 观察警告信息
  - 解释：HEAD 没有指向分支，而是直接指向某次提交，Git 警告你"迷路了"
  - 在 detached HEAD 状态下可以浏览，但新提交会"悬空"
  - **安全回到分支：** `git switch main`（或 `git checkout main`）
  - **心法：** 看到 detached HEAD 不要慌，`git switch <分支名>` 就回来了

- [ ] **Step 6: 概念讲解 — revert vs reset（核心安全指南）**
  - `git revert <commit>`：创建一个"反向提交"来撤销，不丢失历史。**安全、适合共享分支**
  - `git reset --soft <commit>`：HEAD 移动，暂存区不变，工作区不变。**撤销 commit 但保留改动**
  - `git reset --mixed <commit>`（默认）：HEAD 移动，暂存区重置，工作区不变
  - `git reset --hard <commit>`：三棵树全回到过去。**危险！会丢失工作区未提交的改动**
  - 心法：**共享分支用 revert，本地分支用 reset**

- [ ] **Step 7: 动手练习 — revert 和 reset**
  - 在 `module-4/` 做 3 次提交 → `git log --oneline`
  - `git revert HEAD` → 产生第 4 次提交，内容回到第 2 次的状态
  - `git log --oneline` 看到全部 4 次提交
  - 再演示 `git reset --hard HEAD~2` → 真的跳回去了
  - `git log --oneline` 发现 2 次提交消失（制造恐慌）

- [ ] **Step 8: 场景化模拟 — reflog 后悔药**
  - `git reflog` 看所有 HEAD 移动记录（包括 reset、rebase、merge）
  - 找到"丢失"的提交的哈希
  - `git reset --hard <hash>` 找回刚刚删掉的提交
  - **核心认知：** Git 几乎不真正删除数据，reflog 是终极后悔药
  - 心法：**reset --hard 不可怕，不知道 reflog 才可怕**

- [ ] **Step 9: 概念讲解 + 动手 — stash**
  - 场景：正在改代码，临时要去改别的 → 不想提交半成品
  - `git stash`：暂存当前工作区的**未提交**改动
  - `git stash list` 查看暂存列表
  - `git stash pop` 恢复最近一次暂存
  - `git stash drop` 删除指定暂存
  - **场景化：** 用户正在工作区改一半，让用户 stash → 做别的事 → pop 恢复

- [ ] **Step 10: 测验验证**
  - **测验题：** 在 `module-4/` 下：
    1. 制造一个"误删了重要代码"的场景
    2. 用 `git reflog` 定位丢失的提交
    3. 用 `git reset --hard` 找回
    4. 用 `git revert` 模拟"在共享分支上安全撤销"
    5. 解释 revert 和 reset 的本质区别

- [ ] **Step 11: 深度提问**
  - 提 2-3 个原理性问题：
    1. "`git reset --hard` 后 `git status` 显示 clean，但 `git reflog` 却能找到旧提交，这说明什么？"
    2. "`git revert` 为什么要创建新提交而不是擦除历史？"
    3. "`git stash` 和 `git commit --amend` 各自适用于什么场景？"

- [ ] **Step 12: 提交**

```bash
git add module-4/
git commit -m "feat(module-4): 完成历史追溯与回退模块"
```

---

### Task 6: 教学模块 5 — 综合实战

**目录：** `module-5/`

**教学目标：** 模拟真实开发场景，串联全部 5 个模块的知识。

- [ ] **Step 1: 场景设定（二选一）**
  - **场景 A（Web 功能开发）：** 你是一个开发者，接到一个需求——在一个 Web 项目中添加用户登录功能。从零开始：需求 → 开分支 → 开发 → 提交 → 合并 → 发现 bug → 回退 → 修复 → 推送
  - **场景 B（算法库管理）：** 你在整理蓝桥杯竞赛的练习代码，`solutions/` 目录里有零散的文件。任务是通过 Git 分支将"暴力解法"和"优化解法"分开管理，最后合并保留最佳实践。涉及：分支隔离、stash 切换上下文、合并策略选择

- [ ] **Step 2: 引导执行 — 完整工作流（根据选择的场景）**
  - **场景 A：** Web 功能开发流程
    - `cd module-5 && git init` 并加 `.gitignore`
    - 初始提交：`feat: scaffold project`
    - 从 main 创建 `feat/login` 分支
    - 在分支上模拟开发：
      - 创建 `login.html`、`login.css`、`login.js`
      - 多次提交（使用约定式提交）
    - 切回 main，模拟紧急 bug 修复：
      - 修改 `README.md` 修正一个错误
      - `commit -m "fix: correct readme typo"`
    - 合并 `feat/login` 到 main（看是 fast-forward 还是三方合并）
    - 发现 bug：README 中说错了功能名称
    - `git revert <那个 commit>` 安全回滚
    - 重新修复并提交
  - **场景 B：** 算法代码库管理
    - `cd module-5 && git init`
    - 创建 `solutions/` 目录和基础的 `.gitignore`
    - 初始提交：`feat: init algorithm solutions repo`
    - 在 `solutions/` 下创建一个问题文件 `two-sum/README.md` 描述两数之和问题
    - 从 main 创建 `brute-force` 分支，写暴力解法（双层循环）→ 提交 `feat: add brute force for two-sum`
    - 切回 main，创建 `optimized` 分支，写优化解法（哈希表）→ 提交 `feat: add hashmap solution for two-sum`
    - 模拟竞赛场景：在 `brute-force` 分支上写了一半发现思路不对 → `git stash` → 切到 `optimized` 参考 → 切回来 → `git stash pop` 继续
    - 评审后决定合并 `optimized` 到 main（保留最优解）
    - 为 `brute-force` 分支保留不动作为学习记录

- [ ] **Step 3: 场景化模拟 — 工作被打断**
  - 在 `feat/payment` 上开发到一半，紧急切换到 main：
  - `git stash` → `git switch main` → 处理 → `git switch -` 回去 → `git stash pop`
  - 完成开发

- [ ] **Step 4: 测验验证 — 自由演练**
  - **测验题：** 不给出具体步骤，只给需求：
    1. 创建一个仓库，按你自己的想法模拟一个"完整的开发日"（至少 5 次提交、1 个分支、1 次合并、1 次 stash、1 次回退）
    2. 执行完毕后用 `git log --oneline --graph --all` 展示完整历史
    3. 解释每个操作的意图

- [ ] **Step 5: 深度提问**
  - 提 2-3 个综合性问题：
    1. "今天的模拟中，你遇到了哪些让你困惑的点？解决后你的心智模型发生了什么变化？"
    2. "如果再给你一次机会，你会改变哪些操作顺序来让工作流更顺畅？"
    3. "如果这是一个多人协作的项目，哪些操作需要格外谨慎？为什么？"

- [ ] **Step 6: 提交**

```bash
git add module-5/
git commit -m "feat(module-5): 完成综合实战模块"
```

---

### Task 7: 结业 — 学习路径回顾与后续建议

- [ ] **Step 1: 回顾学习路径**
  - 从命令行零基础 → 能独立完成 Git 核心工作流
  - 列出每个模块的核心知识点，确认用户都已掌握

- [ ] **Step 2: 后续学习方向**
  - **进阶方向：** rebase 交互式变基、bisect 二分查找、submodule、hooks
  - **工作流方向：** GitHub Flow、GitFlow、PR/MR 工作流
  - **推荐资源：**
    - Pro Git 书（免费在线）
    - Learn Git Branching（交互式游戏）
    - 日常：多用、多犯错、多用 `--help`

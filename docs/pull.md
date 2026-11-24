# pull

在指定路径下发现 Git 仓库并执行 `git pull`。

## 命令

```bash
bash smtgit.sh pull -p <path> [--sdepth <0|1>]
```

| 选项 | 必填 | 默认值 | 说明 |
|------|------|--------|------|
| `-p`, `--path` | 是 | — | 目标目录；支持绝对路径、相对路径或 `.` |
| `--sdepth` | 否 | `1` | Git repo / 子模块的**嵌套扫描深度**（不是目录深度）。当前仅接受 `0` 或 `1` |
| `-h`, `--help` | 否 | — | 打印本命令用法并退出 `0` |

产品总览、场景与 `sdepth` 概念说明见根目录 [README.md](../README.md)。本文是 `pull` 的权威命令参考（选项、完整工作流、退出码、相关代码）。

## 关键语义

### sdepth

`sdepth` 表示 **Git 仓库嵌套层数**：

- 每遇到一个 Git worktree 根（含子模块）计为一层
- 穿过普通（非 Git）目录**不消耗**层数
- `1`：只处理第一层嵌套仓库
- `0`：不限制嵌套深度，递归全部

实现上扫描函数按「最大嵌套层」编写，`0` 映射为无上限；日后可扩展任意正整数而无需改语义。当前 CLI 仍只接受 `0` 与 `1`。

### 路径行为（方案 C）

| `-p` 目标 | `sdepth=1`（默认） | `sdepth=0` |
|-----------|-------------------|------------|
| 本身是 Git worktree 根 | 只 pull 该目录 | pull 自身，再递归 pull 所有嵌套 Git repo / 子模块 |
| 本身不是 Git worktree 根 | 按 `sdepth` 发现子树中的第一层 Git repo 并 pull | 递归发现并 pull 子树中所有 Git repo |

判定规则：目录必须是 worktree **根**（`git rev-parse --show-toplevel` 等于该目录的规范化路径），避免把仓库内部普通子目录误判为独立仓库。`.git` 为目录或文件（子模块）均可。

## 工作流程

```text
1. 解析 -p / --sdepth，校验 sdepth ∈ {0, 1}
2. 将路径解析为绝对路径，确认存在且为目录
3. 判断路径是否为 Git worktree 根
   ├─ 是 → 始终 git pull 该路径
   │        └─ 仅当 sdepth=0 → discover 嵌套仓库（不含自身）并逐个 pull
   └─ 否 → discover_git_repos(root, sdepth) → 逐个 pull
4. 汇总成功 / 失败数量
   ├─ 有失败 → 退出码 1
   └─ 全部成功但发现数为 0 → 警告「未找到仓库」，退出码 0
```

单仓 `git pull` 失败不会中断整批；脚本继续处理剩余仓库，最后按失败计数决定退出码。

### 发现规则摘要

- 不进入名为 `.git` 的路径
- `discover_git_repos` **从不**把 `root` 自身列入结果；自身是否 pull 由命令层按上表决定
- `sdepth=1` 时：找到一层 worktree 后输出路径，不再进入该仓库寻找更深层嵌套
- `sdepth=0` 时：找到 worktree 后仍继续向下扫描

## 示例

### 容器目录 + 默认深度

```bash
bash smtgit.sh pull -p /path/to
# 等价于
bash smtgit.sh pull -p /path/to --sdepth 1
```

目录树：

```text
/path/to
  example_repo/           <- 探测到 .git → 执行 pull
    .git
    submodules/
      nested/             <- sdepth 为 1 → 跳过
        .git
```

### 当前目录是仓库

```bash
bash smtgit.sh pull -p .
# 只 pull 当前仓库

bash smtgit.sh pull -p . --sdepth 0
# pull 当前仓库，并递归 pull 嵌套的 Git repo / 子模块
```

### 帮助

```bash
bash smtgit.sh help
bash smtgit.sh help pull
bash smtgit.sh pull --help
```

## 退出码

| 码 | 含义 |
|----|------|
| `0` | 全部 pull 成功（或未找到任何仓库，仅警告）；或仅请求帮助（`-h` / `--help`） |
| `1` | 参数错误、路径无效，或至少一个仓库 pull 失败 |

## 相关代码

| 文件 | 职责 |
|------|------|
| [`smtgit.sh`](../smtgit.sh) | 子命令分发、参数解析、方案 C 主流程 |
| [`shared/scan.sh`](../shared/scan.sh) | 按 `sdepth` 发现仓库 |
| [`shared/git.sh`](../shared/git.sh) | worktree 判定与 `git pull` |
| [`shared/path.sh`](../shared/path.sh) | 路径规范化与目录校验 |
| [`shared/log.sh`](../shared/log.sh) | 统一日志（诊断输出到 stderr） |

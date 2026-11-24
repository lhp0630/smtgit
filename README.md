# smtgit

按 **Git 仓库嵌套深度（`sdepth`）** 发现仓库并批量 `git pull` 的 bash 工具。

当你在一个目录里放了许多 Git 仓库，或当前仓库还嵌套了子模块 / 其他 Git 仓库时，直接「遍历目录再 `git pull`」很难控制**扫到哪一层仓库**。smtgit 面向这类开发者与维护者：用 `sdepth` 按 **Git worktree 嵌套层数**（不是普通文件夹深度）决定发现范围，再批量执行 `git pull`。

## Why smtgit?

- **仓库容器目录：** 一个父目录下有多个并列的 Git 仓库，只想更新第一层，或有意递归全部嵌套仓库。
- **当前仓库含嵌套 Git 仓库 / 子模块：** 需要先更新自身，并在需要时一并 pull 嵌套仓库。
- **需要控制发现范围：** 默认只处理一层嵌套（`--sdepth 1`）；需要时用 `--sdepth 0` 不限制嵌套深度。

## Features

- 按路径发现 Git worktree 根
- 嵌套仓库 / 子模块扫描（由 `sdepth` 控制）
- 可配置的 `sdepth`（当前 CLI 接受 `0` 或 `1`，默认 `1`）
- 批量 `git pull`（单仓失败不中断整批）
- 轻依赖：仅 **bash** + 系统 **git**

## Requirements

- **Bash ≥ 4.3**（脚本使用 nameref / `local -n`）
- 系统自带的 **git**
- 克隆本仓库后直接运行；无单独安装步骤、无额外运行时依赖

未提供经过验证的操作系统兼容性矩阵；只要满足上述 bash 与 git 即可尝试运行。

## Quick Start

```bash
git clone <repository-url> smtgit
cd smtgit

# 容器目录：只 pull 第一层 Git 仓库（默认 --sdepth 1）
bash smtgit.sh pull -p /path/to

# 当前目录是仓库：只 pull 自身
bash smtgit.sh pull -p .

# 当前目录是仓库：自身 + 全部嵌套仓库 / 子模块
bash smtgit.sh pull -p . --sdepth 0
```

## How It Works

`sdepth` 计的是 **Git 仓库嵌套层数**：每遇到一个 Git worktree 根计一层；穿过普通（非 Git）目录**不消耗**层数。

```text
/path/to                         <- 容器（本身不是 Git 仓库）
  example_repo/                  <- 第 1 层 → sdepth=1 时 pull
    .git
    submodules/
      nested/                    <- 第 2 层 → sdepth=1 时跳过；sdepth=0 时 pull
        .git
```

路径行为摘要（方案 C）：

| `-p` 目标 | `sdepth=1`（默认） | `sdepth=0` |
|-----------|-------------------|------------|
| 本身是 Git worktree 根 | 只 pull 该目录 | pull 自身，再递归嵌套仓库 |
| 本身不是 Git worktree 根 | 发现并 pull 第一层子仓库 | 递归发现并 pull 全部子仓库 |

完整工作流、发现规则、退出码见 [docs/pull.md](docs/pull.md)。

## Usage

```bash
bash smtgit.sh pull -p <path> [--sdepth <0|1>]
bash smtgit.sh help
bash smtgit.sh help pull
```

| 常用项 | 说明 |
|--------|------|
| `-p` / `--path` | 目标目录（必填）；绝对路径、相对路径或 `.` |
| `--sdepth` | 嵌套扫描深度；默认 `1`；当前仅 `0` 或 `1` |
| `-h` / `--help` | 打印 `pull` 用法 |

更多示例与语义见 [docs/pull.md](docs/pull.md)。

## Safety and Limitations

- 当前只执行各仓库内的 `git pull`，不执行 reset / clean / force push 等破坏性操作。
- `git pull` **不带额外参数**；fast-forward / rebase 等行为取决于各仓库自身的 git 配置。
- 单个仓库 pull 失败不会中断整批；脚本继续处理其余仓库，最后按失败计数决定退出码。
- 扫描使用非点文件通配（未启用 `dotglob`）：**名称以 `.` 开头的目录下的仓库不会被发现**（当前实现行为）。
- 无自动化测试套件；无 `SECURITY.md` 所声明的额外安全保证。

## Documentation

| 文档 | 用途 |
|------|------|
| [docs/pull.md](docs/pull.md) | `pull` 命令参考（权威语义） |
| [docs/release.md](docs/release.md) | Tag / GitHub Release 流程 |

贡献者与 Agent 入口：[AGENTS.md](AGENTS.md)。

## License

本仓库**尚未提供** `LICENSE` 文件；许可条款以维护者后续说明为准。同样尚未提供 `CONTRIBUTING.md`、`SECURITY.md` 或 `CHANGELOG.md`。

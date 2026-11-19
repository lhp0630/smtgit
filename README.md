# smtgit

批量拉取指定路径下 Git 仓库的 bash 工具。按 **Git repo / 子模块嵌套深度（`sdepth`）** 扫描，而不是普通目录深度。面向需要在「仓库容器目录」或「当前仓库（含嵌套子模块）」上批量 `git pull` 的开发者与维护者。

依赖：**bash** 与系统自带的 **git**。当前仅执行 `git pull`，不执行破坏性 git 操作。无需额外安装步骤：克隆本仓库后直接运行 `bash smtgit.sh …`。

`sdepth` 与路径行为的完整语义见 [docs/pull.md](docs/pull.md)；下方「快速开始」只给出最短可运行示例。

## 功能

- **`pull`**：在 `-p` 指定路径下发现 Git 仓库并执行 `git pull`（`--sdepth` 默认 `1`，当前仅接受 `0` 或 `1`）
- **`help`**：输出子命令与选项说明，以及用法示例

## 目录布局

```
smtgit/
├── smtgit.sh                 # CLI 入口
├── shared/                   # 通用函数（日志、路径、Git、扫描）
├── docs/
│   ├── pull.md               # pull 详细语义与工作流程
│   ├── release.md            # Tag / Release 发布流程
│   ├── research/             # 调研报告（学到了什么 / 应考虑什么）
│   └── maintenance/          # 迁移记录与实施报告
├── RFCs/                     # 设计与流程提案（应做什么 / 为什么）
├── .agents/
│   ├── rules/                # 文档与 Agent 规则规格
│   └── templates/            # 文档 / RFC / 评审模板
├── .cursor/rules/            # Cursor Rules 加载入口
├── .github/workflows/
│   └── release.yml           # push v* tag → 打包发布
├── AGENTS.md                 # AI Agent 入口说明
└── README.md
```

## 快速开始

```bash
# 在仓库容器目录下，只 pull 第一层 Git 仓库（默认 --sdepth 1）
bash smtgit.sh pull -p /path/to

# 当前目录是仓库：只 pull 自身；加 --sdepth 0 时再递归嵌套仓库 / 子模块
bash smtgit.sh pull -p .
bash smtgit.sh pull -p . --sdepth 0

# 查看帮助
bash smtgit.sh help
bash smtgit.sh help pull
```

命令参考与路径方案 C、退出码等详见 [docs/pull.md](docs/pull.md)。

## 发布

推送形如 `v1.0.0` 的 tag **不会**自动产生 GitHub Release。本仓库由 [`.github/workflows/release.yml`](.github/workflows/release.yml) 在匹配 `v*` 的 tag 推送后打包并创建 Release（附带 `.tar.gz` / `.zip`）。

```bash
git tag v1.0.0
git push origin v1.0.0
```

详见 [docs/release.md](docs/release.md)。

## 文档与治理

| 文档 | 用途 |
|------|------|
| [docs/pull.md](docs/pull.md) | `pull` 命令参考 |
| [docs/release.md](docs/release.md) | Tag / GitHub Release 流程 |
| [docs/research/](docs/research/README.md) | 调研报告（学到了什么 / 应考虑什么） |
| [docs/maintenance/reports/](docs/maintenance/reports/) | 实施 / 迁移执行报告（实际做了什么） |
| [AGENTS.md](AGENTS.md) | AI Coding Agent 入口与约束摘要 |
| [RFCs/](RFCs/README.md) | RFC 流程与提案（应做什么 / 为什么） |
| [.agents/rules/](.agents/rules/README.md) | 文档维护与写作规则 |
| [.cursor/rules/agents-rules.mdc](.cursor/rules/agents-rules.mdc) | Cursor Rules 加载入口 |
| [docs/maintenance/agents-md-migration.md](docs/maintenance/agents-md-migration.md) | 既有 `AGENTS.md` 迁移记录 |

当前仓库**没有** `LICENSE`、`CONTRIBUTING.md`、`SECURITY.md` 或 `CHANGELOG.md`；贡献与许可政策以维护者后续说明为准。

RFC-DOC-001（文档治理体系）状态为 **Accepted**（2026-11-19）；正文见 [`RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md`](RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md)。

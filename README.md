# smtgit

批量拉取指定路径下 Git 仓库的 bash 工具。按 **Git repo / 子模块嵌套深度（`sdepth`）** 扫描，而不是普通目录深度。

## 功能

- **`pull`**：在 `-p` 指定路径下发现 Git 仓库并执行 `git pull`
- **`help`**：输出子命令与选项说明，以及用法示例

## 目录布局

```
smtgit/
├── smtgit.sh                 # CLI 入口
├── shared/                   # 通用函数（日志、路径、Git、扫描）
├── docs/
│   ├── pull.md               # pull 详细语义与工作流程
│   └── release.md            # Tag / Release 发布流程
├── .github/workflows/
│   └── release.yml           # push v* tag → 打包发布
└── README.md
```

## 快速开始

```bash
bash smtgit.sh pull -p /path/to
bash smtgit.sh help pull
```

更多说明见 [docs/pull.md](docs/pull.md)。

## 发布

推送形如 `v1.0.0` 的 tag **不会**自动产生 GitHub Release。本仓库由 [`.github/workflows/release.yml`](.github/workflows/release.yml) 在 tag 推送后打包并创建 Release（附带 `.tar.gz` / `.zip`）。

```bash
git tag v1.0.0
git push origin v1.0.0
```

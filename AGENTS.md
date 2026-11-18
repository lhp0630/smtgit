# AGENTS.md

本文件约束 smtgit 的仓库布局、架构设计与文档格式。后续改动应与此保持一致。

## 仓库布局

```
smtgit/
├── smtgit.sh           # CLI 入口：子命令分发、参数解析、退出码
├── shared/             # 可复用函数库（按领域拆分，无隐式副作用）
│   ├── log.sh          # 统一日志（诊断信息一律 stderr）
│   ├── path.sh         # 路径规范化与目录校验
│   ├── git.sh          # Git 领域原语（worktree 判定、pull 等）
│   └── scan.sh         # 按 sdepth 发现 Git repo
├── docs/               # 各子命令/主题的详细文档与工作流程
│   └── <command>.md
├── .github/workflows/
│   └── release.yml     # push v* tag → 打包并创建 GitHub Release
├── README.md           # 仓库简介、功能列表、目录布局、一行级快速示例
└── AGENTS.md           # 本约束
```

约束：

- **入口薄、共享厚**：`smtgit.sh` 只做分发与编排；可复用逻辑放入 `shared/`。
- **一命令一文档**：子命令的完整语义与流程写在 `docs/<command>.md`，不要堆进 README。
- **README 只做总览**：介绍仓库、功能、布局与最短示例；不写扫描细节或长流程。
- **纯 bash + 系统 git**：不引入其它运行时依赖；不执行破坏性 git 操作（当前仅 `pull`）。

## 核心原则

优先写**稳定、按领域命名的纯辅助函数**，而不是过渡期形态的鸭子类型式 stopgap。架构分层与领域语义（下一节）都服从本原则。

### 为何会出现 stopgap

实现时容易留下「迁移动方言」：用松散探测（乱试路径、模糊字符串、临时 `_raw_*` / `_mapped_*` 命名）去兼容旧调用路径或双形态数据。双路径消失后，这些脚手架就不再是好 API。

### 应该

- **先定契约**：参数与返回值表达真实领域对象（worktree 根路径、sdepth、仓库列表），不要用「随便一个字符串路径」糊弄过关。
- **契约明确后直接使用**：已知是 worktree 根就按根处理；不要用一串试探性检测代替明确判定（如 `is_git_worktree`）。
- **按领域结果命名**（`discover_git_repos`、`is_git_worktree`、`git_pull`），不要按迁移故事命名（`_raw_*`、`_mapped_*`、`_compat_*`）。
- **可复用且无 I/O 编排的纯逻辑**放进 `shared/`；`smtgit.sh` / 功能侧只调用，不私藏一份同逻辑副本。
- **一个形状只保留一套 API**：旧双路径去掉后，删掉迁移命名与重复封装。

### 不应该

- 在生产契约已经固定后，仍用「宽松探测好写假数据」当借口保留 stopgap。
- 把本属于 `shared/` 兄弟函数旁的纯逻辑，以 `_` 私有副本埋在入口或功能脚本里。
- 在只剩一种形态后，仍在名字里编码分层戏剧（`raw` / `mapped` / `compat`）。

### 对照（抽象）

```text
# ❌ 过渡：命名随迁移、逻辑埋在入口、契约含糊
_raw_find_repos() { ...; find ... -name .git; ... }

# ✅ 稳定：领域名、明确 sdepth 契约、放在 shared/scan.sh
discover_git_repos <root> <sdepth>   # 一行一个 worktree 根；不含 root 自身
```

## 架构设计

具体分层与 smtgit 领域规则见下；抽象方式必须符合上一节「核心原则」。

### 分层

| 层 | 位置 | 职责 |
|----|------|------|
| CLI | `smtgit.sh` | 子命令、选项校验、编排、汇总退出码 |
| 领域 | `shared/git.sh`, `shared/scan.sh` | worktree / sdepth / 发现与 pull |
| 基础设施 | `shared/log.sh`, `shared/path.sh` | 日志、路径 |

- `shared/` 只导出函数，不在 source 时产生全局副作用。
- 单仓失败不中断整批；由 CLI 汇总成功/失败并决定退出码。
- 每个子命令必须实现 `help`（及 `help <command>`），完整说明选项并附用法示例。

### 领域语义（必须遵守）

- **`sdepth`**：Git repo / 子模块的**嵌套扫描深度**，不是普通目录深度。穿过非 Git 目录不消耗层数；每遇到一个 worktree 根计一层。
- **`sdepth` 取值**：当前 CLI 仅接受 `0`（不限）与 `1`（默认）。扫描实现按「最大嵌套层」编写（`0` → 无上限），便于日后扩展任意正整数。
- **路径方案 C**：
  - `-p` 本身是 Git worktree 根 → 始终 pull 自身；仅当 `sdepth=0` 时再扫描嵌套。
  - `-p` 不是 worktree 根 → 按 `sdepth` 发现子树中的仓库并 pull。
- **worktree 根判定**：`git rev-parse --show-toplevel` 必须等于该目录规范化路径；兼容 `.git` 为目录或文件（子模块）。勿把仓库内普通子目录当成独立 repo。
- **`discover_git_repos`**：只输出 `root` 之下的仓库，**从不**包含 `root` 自身；自身是否 pull 由命令层按方案 C 决定。跳过名为 `.git` 的路径。

### 扩展新子命令时

1. 在 `smtgit.sh` 增加分发与 `help`。
2. 领域逻辑放入 `shared/`（能共用则共用，避免在入口复制）。
3. 新增 `docs/<command>.md`，并在 README 功能列表中加一行入口。

## 文档格式

### README.md

固定小节顺序：

1. 一句话项目介绍  
2. **功能**（子命令列表）  
3. **目录布局**（树状）  
4. **快速开始**（最短命令）  
5. 指向 `docs/` 的链接  

### docs/\<command\>.md

固定小节顺序（与 [`docs/pull.md`](docs/pull.md) 对齐）：

1. 标题 = 命令名；一句说明  
2. **命令** — 用法代码块 + 选项表（选项 / 必填 / 默认值 / 说明）  
3. **关键语义** — 领域概念（如 `sdepth`、路径行为）用对照表写清  
4. **工作流程** — 有序列步骤或流程图式纯文本；写明失败与继续策略  
5. **示例** — 至少覆盖默认行为、边界（如 `-p .`、`sdepth=0`）与帮助  
6. **退出码** — 表格  
7. **相关代码** — 指向入口与 `shared/` 文件  

文风：用对照表表达分支行为；示例目录树与真实语义一致；不把实现细节重复进 README。

# agb

**agb**（agent governance bootstrap）旨在把一套已在真实项目中跑通的 Agent 协作与文档治理体系，产品化为独立的仓库初始化与运维工具，让其他 Git 仓库也能安全、可升级地采用同一套规范。

当前目录是该产品在 **smtgit** 仓库内的**研究与设计暂存区**：此处沉淀调研、Prompt 草案与交付物映射；**CLI 与可分发 Governance Pack 尚未实现**，也不属于 smtgit 运行时或 Release 产物。产品边界与分阶段交付以 Draft RFC [`RFC-DOC-002`](../RFCs/RFC-DOC-002-agent-governance-bootstrap.md) 为准；在该 RFC 经维护者 `Accepted` 之前，本文不授权实现或宣称生产可用。

## 从工作项目到可复用体系

这套体系不是纸面模板，而是从多个工作项目里逐步沉淀下来的协作方式：人负责接受决策与发布边界，Agent 在明确规则下理解仓库、起草文档与提案、执行可验证的维护任务。smtgit 是这套体系的**参考源**（reference origin）：经过 [RFC-DOC-001](../RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md)（**Accepted**）落地的 Agent 入口、可移植规则、RFC 流程，以及「RFC · 调研 · 实施报告」决策文档三角，构成了后续产品化的内容基线。

工作项目里常见的痛点是：治理资产锁在单一应用仓库里；手工拷贝会把产品专属约定一起带进目标库；缺少版本、迁移与升级语义；「想法 → 调研 → RFC」又容易和 Prompt、报告、提案混成一团。agb 要解决的，正是把**可移植的治理能力**从参考源中抽出，变成可安装、可校验、可升级的 Pack，而不是再复制一份 smtgit 应用代码。

## 体系组成

下列能力对应今天在参考源与本暂存区中可见的治理部件；将来由 agb 的 **Governance Pack** 按语义类别分发（见 RFC-DOC-002 §7.3）。名称便于人类阅读；Pack 内以可移植类别（Core / Workflow / Prompt Library / Project Overlay / Adapter / Examples）组织，**不会**把 smtgit 专属约定（例如 Spec `10`）原样灌进外库。

| 组成部分 | 回答的问题 | 在参考源中的落点（概览） |
|----------|------------|--------------------------|
| **Agent Rules** | Agent 可以做什么、不可越权什么、按什么流程协作 | `AGENTS.md`、`.agents/rules/`（可移植规格；项目 Overlay 单独生成） |
| **RFC** | 架构与重大变更应做什么、为什么 | `RFCs/` 流程、模板与状态机；仅人类维护者可 `Accepted` |
| **Documentation Governance** | 文档如何组织、如何更新、如何与决策三角一致 | `.agents/rules`（含 Spec `02` 产品向 README、`05`/`08` 研究布局）；`docs/` 与三角约定 |
| **Documentation Workflow** | Agent 如何理解、创建、修改、审查与维护文档 | 规则规格 + 文档模板 + 审查清单 |
| **Agent Workflow** | 开发者如何把 Agent 嵌进日常研发节奏 | 安装后的运营模型（调研 → RFC → 实施报告；Pack 维护） |
| **Prompt Templates** | 特定任务如何用受约束的标准 Prompt 启动 | 本目录 `prompts/` 草案；将来进入 Pack 的 Prompt Library |
| **配套资源** | 适配器、校验、锁文件、迁移计划与备份等 | 设计见 RFC-DOC-002；本暂存区仅有研究与映射，无实现 |

决策文档三角（角色不可混用；以仓库根 [docs/research/README.md](../docs/research/README.md) 等 living 约定为准）：

| 位置 | 问题 |
|------|------|
| `RFCs/` | 应做什么、为什么？（提案与接受记录） |
| `docs/research/` | 学到了什么、应考虑什么？（调研；**不是**接受；扁平 + 日期文件名；`supplementary/` / `archive/`） |
| `docs/maintenance/reports/` | 实际做了什么、结果如何？（实施 / 迁移记录） |

参考源 README 写作规范见 Spec [`02`](../.agents/rules/02-readme-writing.md)（产品向目录；完整命令参考仍在 `docs/<command>.md`）。本 `agb/README.md` 是产品暂存区说明，不替代根 README。

## 产品设想（设计中）

独立 **agb 仓库**（拟建）将维护：

1. **版本化 Governance Pack**（清单、校验和、模块依赖与溯源元数据）
2. **本地 CLI**：在任意 Git 仓库上 `init` / `scan` / `plan migrate` / `validate`，以及 emit-first 的 `research` / `rfc`；完整 `apply`、三路 `update` 等按 RFC 分阶段交付
3. **Prompt-only 分发模式**：在不必常驻运行 agb 或绑定某一 Agent 厂商 CLI 的情况下，仍可用钉死版本的 kit 完成安装 / 迁移闭环

权威与安全边界（摘要，细节见 RFC-DOC-002）：

- agb **不是** smtgit 子命令；不得并入 `smtgit.sh` / `shared/`
- Agent 可起草调研与 RFC；**不得**代替维护者接受 RFC 或跳过调研评审证据
- Examples（含打包的 RFC-DOC-001 文本）默认关闭，且不得挤占目标库活跃 RFC 编号序列
- 目标库内容与 Agent 产出在控制面上视为不可信，直至人类门禁通过

阻塞性产品决策（许可证、远程仓库、Examples 默认路径等）仍见 RFC-DOC-002 §15；本文不预填答案。

## 功能

**已有（本暂存区）**

- 产品化调研报告与研究约定说明
- Research Task / RFC Authoring Prompt 草案
- RFC-DOC-001 交付物 → Pack / init 映射清单
- 指向 Draft RFC-DOC-002 的设计入口

**拟提供（仅当 RFC-DOC-002 被维护者接受并实现后；下列命令名为设计用语，当前仓库中不存在可执行的 `agb` 二进制）**

| 能力 | 用途（设计） |
|------|----------------|
| `init` | 向目标库安装所选 Pack 模块，生成 Project Overlay 与 lock |
| `scan` / `plan migrate` | 盘点现有 Agent/文档资产，生成不可变迁移计划（计划本身不改治理树） |
| `validate` | 校验三角路径、lock、示例隔离等 |
| `research` / `rfc` | 默认只发出 Prompt；`rfc` 需绑定身份与校验和的调研评审证据 |
| `pack fetch` / `pack emit --prompt-only` | 获取钉死 Pack；发出可离线使用的 Prompt-only kit |
| `apply` / `update` / `doctor` / `rollback` | 分阶段：事务应用、三路升级、健康检查、备份回滚 |

## 目录布局

```text
agb/                                 # 位于 smtgit 内的产品暂存区（非运行时）
├── README.md                        # 本说明
├── docs/
│   └── research/                    # agb 调研（对齐仓库级 research 布局约定）
│       ├── README.md
│       └── YYYY-MM-DD-<topic>.md    # 当前主调研（扁平 + 日期）
├── prompts/
│   ├── research-task.md             # 草案：想法 → Research Task Prompt
│   └── rfc-from-research.md         # 草案：已评审调研 → RFC Prompt
└── examples/
    └── rfc-doc-001-deliverables.md  # DOC-001 产出 → Pack / init 映射
```

Living 的 smtgit 治理仍在仓库根：`AGENTS.md`、`.agents/`、`RFCs/`、`docs/`。本树不替代它们。

## 快速开始

本阶段没有可安装的 agb CLI。最短路径是按文档三角阅读设计材料：

```bash
# 1. 调研：学到了什么 / 应考虑什么
less agb/docs/research/2026-11-19-repository-governance-bootstrap-tool-research.md

# 2. 提案：应做什么 / 为什么（Status: Draft — 非实现授权）
less RFCs/RFC-DOC-002-agent-governance-bootstrap.md

# 3. 参考源中的已接受治理基线（smtgit 政策，非外库自动 Accept）
less RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md
```

确认 smtgit 应用侧未受本暂存区牵连（回归）：

```bash
bash smtgit.sh help
bash smtgit.sh help pull
```

## 文档与状态

| 文档 | 用途 |
|------|------|
| [docs/research/README.md](docs/research/README.md) | agb 调研目录约定（对齐 living research 布局） |
| [docs/research/2026-11-19-repository-governance-bootstrap-tool-research.md](docs/research/2026-11-19-repository-governance-bootstrap-tool-research.md) | 产品化可行性与设计调研（当前主报告） |
| [prompts/research-task.md](prompts/research-task.md) | Research Task Prompt 草案 |
| [prompts/rfc-from-research.md](prompts/rfc-from-research.md) | RFC Authoring Prompt 草案 |
| [examples/rfc-doc-001-deliverables.md](examples/rfc-doc-001-deliverables.md) | DOC-001 → Pack 映射 |
| [../RFCs/RFC-DOC-002-agent-governance-bootstrap.md](../RFCs/RFC-DOC-002-agent-governance-bootstrap.md) | agb 产品边界与设计（**Draft**） |
| [../RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md](../RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md) | 参考源治理基线（**Accepted**） |
| [../docs/research/README.md](../docs/research/README.md) | 仓库级调研约定（主规范） |
| [../.agents/rules/02-readme-writing.md](../.agents/rules/02-readme-writing.md) | 产品向 README 写作规范 |
| [../AGENTS.md](../AGENTS.md) | smtgit Agent 入口 |

| 项 | 状态 |
|----|------|
| 本目录角色 | 研究 / 设计暂存 |
| RFC-DOC-002 | **Draft**（未授权实现） |
| CLI / Pack / 独立仓库 | **未实现** / **未创建** |
| 许可证与发布远程 | **未定**（见 RFC-DOC-002 开放问题） |

抽取独立 agb 仓库并落地 Pack SSOT，仅在维护者接受 RFC-DOC-002 且完成其 Phase 0 之后进行。在此之前，请将本 README 视为产品叙事与导航，而非安装说明。

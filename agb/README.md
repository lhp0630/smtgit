# agb

**agb**（agent governance bootstrap）旨在把一套已在真实项目中跑通的 Agent 协作与文档治理体系，产品化为独立的仓库初始化与运维工具，让其他 Git 仓库也能安全、可升级地采用同一套规范。

当前目录是该产品在 **smtgit** 仓库内的**产品暂存区**：含调研、Prompt 草案、以及按 [RFC-DOC-002](../RFCs/RFC-DOC-002-agent-governance-bootstrap.md) 落地的**架构骨架**（CLI 命令面、Pack 布局、schema / Prompt-only kit 占位）。**不是** smtgit 子命令或 Release 产物；可执行入口为 `bash agb/agb.sh`，业务命令目前为桩（exit 2）。RFC-DOC-002 仍为 **Draft**——产品 Accept、独立仓库抽取与完整 MVP 仍属维护者决策；本骨架按维护者明确任务落地，不宣称生产可用。

## 从工作项目到可复用体系

这套体系不是纸面模板，而是从多个工作项目里逐步沉淀下来的协作方式：人负责接受决策与发布边界，Agent 在明确规则下理解仓库、起草文档与提案、执行可验证的维护任务。smtgit 是这套体系的**参考源**（reference origin）：经过 [RFC-DOC-001](../RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md)（**Accepted**）落地的 Agent 入口、可移植规则、RFC 流程，以及「RFC · 调研 · 实施报告」决策文档三角，构成了后续产品化的内容基线。

工作项目里常见的痛点是：治理资产锁在单一应用仓库里；手工拷贝会把产品专属约定一起带进目标库；缺少版本、迁移与升级语义；「想法 → 调研 → RFC」又容易和 Prompt、报告、提案混成一团。agb 要解决的，正是把**可移植的治理能力**从参考源中抽出，变成可安装、可校验、可升级的 Pack，而不是再复制一份 smtgit 应用代码。

## 体系组成

下列能力对应参考源与 Pack 语义类别（RFC-DOC-002 §7.3）。Pack **不会**把 smtgit 专属约定（例如 Spec `10`）原样灌进外库。

| 组成部分 | 回答的问题 | 暂存 / Pack 落点 |
|----------|------------|------------------|
| **Agent Rules** | Agent 边界与协作方式 | `pack/core/`（占位；待 Phase 0 泛化） |
| **RFC** | 应做什么、为什么 | Core 内 RFC 流程占位；Examples 默认关闭 |
| **Documentation Governance** | 文档组织与三角一致性 | Core docs 约定占位 |
| **Documentation Workflow** | 如何理解 / 创建 / 审查文档 | Workflow + templates 占位 |
| **Agent Workflow** | 如何把 Agent 嵌进研发节奏 | `pack/workflow/` |
| **Prompt Templates** | 标准 Prompt | `prompts/` 草案 → `pack/prompts/` |
| **配套资源** | 适配器、lock、计划、kit | `pack/adapters/`、`schemas/`、`kits/prompt-only/` |

决策文档三角（角色不可混用）：

| 位置 | 问题 |
|------|------|
| `RFCs/` | 应做什么、为什么？ |
| `docs/research/` | 学到了什么、应考虑什么？（**不是**接受） |
| `docs/maintenance/reports/` | 实际做了什么、结果如何？ |

## 功能

| 命令 | 现状 | 说明 |
|------|------|------|
| `help` / `version` | **可用** | 命令面与版本；help 中英双版（§7.14 / L1） |
| `init` | 桩 | 安装 Pack 模块 + overlay + lock |
| `scan` | 桩 | 盘点 Agent/文档资产 → inventory |
| `plan migrate` | 桩 | 不可变迁移计划（不改治理树） |
| `plan approve` | 桩 | 人类批准计划（Phase 2+） |
| `validate` | 桩 | 三角 / lock / 示例隔离等 |
| `research` / `rfc` | 桩 | emit-first Prompt；`rfc` 需评审证据 |
| `pack fetch` / `pack emit` | 桩 | 钉死 Pack；发出 Prompt-only kit |
| `apply` / `rollback` | 桩 | 事务应用 / 回滚（Phase 2+） |
| `update` / `doctor` | 桩 | 三路升级 / 诊断（Phase 4+） |

权威边界（摘要）：agb **不是** smtgit 子命令；Agent 不得 Accept RFC；Examples 默认 off 且不得挤占活跃 RFC 编号。

## 目录布局

```text
agb/
├── agb.sh                          # CLI 入口（骨架）
├── shared/                         # log / ui_lang / usage(zh+en) / stub / pack / commands
├── pack/                           # Governance Pack SSOT 骨架
│   ├── manifest.yaml
│   ├── checksums.sha256
│   ├── core/ workflow/ prompts/ overlay/
│   ├── adapters/                   # cursor|claude|gemini|copilot
│   └── examples/                   # 默认不安装
├── schemas/                        # lock / plan / review / state 示例
├── kits/prompt-only/               # Prompt-only kit 骨架
├── prompts/                        # Research / RFC Prompt 草案
├── examples/                       # DOC-001 → Pack 映射
├── docs/
│   ├── architecture/skeleton.md    # 骨架地图
│   ├── research/                   # agb 调研
│   └── maintenance/reports/        # 实施报告
└── README.md
```

## 快速开始

```bash
# 命令面与帮助（已实现；默认跟随系统消息 locale）
bash agb/agb.sh help
bash agb/agb.sh --lang zh help
bash agb/agb.sh --lang en help
bash agb/agb.sh help validate
LC_ALL=C bash agb/agb.sh help    # 英文（C 短路）
bash agb/agb.sh version

# 业务命令目前为桩（期望 exit 2）
bash agb/agb.sh validate

# 设计材料
less agb/docs/architecture/skeleton.md
less RFCs/RFC-DOC-002-agent-governance-bootstrap.md

# 确认未牵连 smtgit 应用
bash smtgit.sh help
bash smtgit.sh help pull
```

## 文档与状态

| 文档 | 用途 |
|------|------|
| [docs/architecture/skeleton.md](docs/architecture/skeleton.md) | 骨架架构地图 |
| [docs/maintenance/reports/2026-11-24-architecture-skeleton.md](docs/maintenance/reports/2026-11-24-architecture-skeleton.md) | 本次落地实施报告 |
| [docs/research/README.md](docs/research/README.md) | agb 调研约定 |
| [docs/research/2026-11-19-repository-governance-bootstrap-tool-research.md](docs/research/2026-11-19-repository-governance-bootstrap-tool-research.md) | 产品化调研 |
| [pack/README.md](pack/README.md) | Pack 模块说明 |
| [schemas/README.md](schemas/README.md) | 工件示例 |
| [kits/prompt-only/README.md](kits/prompt-only/README.md) | Prompt-only kit |
| [../RFCs/RFC-DOC-002-agent-governance-bootstrap.md](../RFCs/RFC-DOC-002-agent-governance-bootstrap.md) | 产品设计（**Draft**） |
| [../RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md](../RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md) | 参考源治理基线（**Accepted**） |

| 项 | 状态 |
|----|------|
| 本目录角色 | 产品暂存 + **架构骨架** |
| RFC-DOC-002 | **Draft**（产品 Accept 仍待维护者） |
| CLI `help` / `version` | 可用 |
| CLI 业务命令 / Pack 正文 | 桩 / 占位 |
| 独立仓库 / 许可证 / 远程 | **未定**（RFC §15） |

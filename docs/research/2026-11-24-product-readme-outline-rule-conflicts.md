# 产品向 README 建议目录落地与规则冲突清查

- **角色：** `docs/research/` 下**当前研究结论主入口**（扁平 + 日期文件名；索引见 [`README.md`](./README.md)）
- **日期：** 2026-11-24（组织整理：2026-11-24）
- **范围：** 明确采用维护者建议的 README 目录；将该目录纳入 Spec `02` 与 `README.template` 的修订目标；**重点清查**除此二者之外、仍会与落地冲突的规则与引用点
- **性质：** 调研报告。**不构成**维护者批准、RFC 接受或授权执行规则/README 改写。
- **前序：**
  - 归档：[`archive/2026-11-23-product-oriented-readme-revision.md`](./archive/2026-11-23-product-oriented-readme-revision.md)（产品向修订可行性；立场已被本报告取代）
  - 专项：[`supplementary/2026-11-20-readme-pull-release-docs-review.md`](./supplementary/2026-11-20-readme-pull-release-docs-review.md)（README/pull/release 事实审查；独立价值）

## 1. 本报告相对前序的立场修正

| 议题 | 2026-11-23 立场 | **本报告明确立场** |
|------|-----------------|-------------------|
| 建议目录 | 「值得做」的可选产品大纲 | **定为落地目标目录**（见 §2）；后续 Spec `02` / `README.template` **应改写成该目录** |
| Spec `02` + template | 建议更新 | **必须与 README 改写同批更新为目标目录**；否则治理与产品文档互搏 |
| `docs/pull.md` 合并 | 不建议全文合并 | **维持**：不合并；How It Works / Usage 只承载概念与常用命令 |
| 其他规则 | 点到 Spec 05/10/AGENTS | **本报告重点**：逐条清查冲突等级与处置 |

## 2. 目标 README 目录（规范候选，锁定采用）

以下即维护者建议目录，本报告将其视为 **Spec `02` 与 `README.template` 的目标必选/约定结构**（小节标题可用英文如下；正文语言见 §5 C-LANG）：

```text
# smtgit
一句话产品定位
短介绍（解决问题 / 面向用户 / 与普通批量 git pull 的区别）

## Why smtgit?
## Features
## Requirements
## Quick Start
## How It Works
## Usage
## Safety and Limitations
## Documentation
## License
```

### 2.1 写入 Spec `02` / `README.template` 时应固定的语义（草案）

| 节 | MUST 包含 | MUST NOT |
|----|-----------|----------|
| 开篇 | 产品定位；问题；用户；与「无深度控制的批量 pull」的差异 | 仓库树；RFC/Agent 治理说明 |
| Why smtgit? | 经核实场景：容器多仓；嵌套/子模块；控制发现范围 | 未实现场景 |
| Features | 能力（发现、嵌套扫描、可配置 `sdepth`、批量 pull、轻依赖） | 完整子命令百科；仓库目录树 |
| Requirements | 已验证依赖（bash、git；可写 bash≥4.3） | 无证据 OS 矩阵 |
| Quick Start | 获取项目 + 可验证最短命令 | 发布 tag 流程 |
| How It Works | `sdepth` **概念**图示；路径行为**摘要**（方案 C） | 完整工作流、发现规则全文、退出码表、相关代码表（仍属 `docs/pull.md`） |
| Usage | 常用命令/参数 + 短示例；链到 `docs/pull.md` | 复制整份命令参考 |
| Safety and Limitations | 仅 `git pull`；失败聚合；已知限制 | 虚构安全/成熟度保证 |
| Documentation | `docs/pull.md`、`docs/release.md`；治理至多一行 | RFC 状态段、Agent Rules 大表、迁移记录 |
| License | 有 `LICENSE` 则摘录/链接；**当前无文件则披露「尚未提供」或省略标题改用 Project status** | 杜撰许可条款 |

Spec `02` 现有禁令应**保留并收紧措辞**：

- 仍 MUST NOT 吸收 **完整** `sdepth`/scan **工作流**（退出码、发现规则全文、相关代码）→ 与 How It Works 概念图示兼容。
- 仍 MUST NOT 虚构 badges / license 正文 / 无证据成熟度标签。
- 仍 MUST NOT 在 README 主体复制 `.agents/rules` / RFC 体系。
- 删除「必选 **目录布局**」；仓库树权威位置改为 Spec `10` §A / `AGENTS.md`。
- Required workflow 中「Confirm layout from the repository tree」改为可选贡献者核对，**不再**作为 README 必选节的生成步骤。

## 3. 冲突清查方法

1. 全文检索 `.agents/`、`AGENTS.md`、`.cursor/rules/`、`docs/maintenance/`、`docs/research/`、`RFCs/` 中与 README 结构/总览/语言相关的规范句。
2. 将每条与 §2 目标目录对照，判定冲突等级。
3. 区分：**规范冲突**（改规则才能改 README）vs **内容边界**（目录可留，写法受限）vs **历史记录**（不改正文，仅避免被当作现行规范）。

### 冲突等级

| 等级 | 含义 |
|------|------|
| **Blocker** | 不修订该规则，按 §2 改 README / Spec 02 会直接违反 MUST |
| **Coupled** | 与 Spec 02 重复规定同一事实；只改 02 会造成 Spec 间自相矛盾 |
| **Boundary** | 不禁止产品向目录，但限制 How It Works / License / 语言等写法深度 |
| **Policy** | 需维护者显式裁定（语言、许可披露形式等） |
| **Stale-ref** | 历史迁移/研究表述仍描述旧五节；不应当作现行规范，但易误导 |
| **None** | 与 §2 兼容或正交 |

## 4. 冲突清单（重点：Spec 02 / template **之外**）

### 4.1 Blocker / Coupled（落地前必须同批处理）

| ID | 位置 | 现行要求（摘要） | 与 §2 的冲突 | 建议处置 |
|----|------|------------------|--------------|----------|
| C1 | Spec [`02`](../../.agents/rules/02-readme-writing.md) § Project-required section order | 必选：引言→**功能**→**目录布局**→**快速开始**→docs 链接 | §2 无目录布局；节名与顺序全不同 | **改写为 §2 目录**（本任务已明确纳入目标） |
| C2 | [`.agents/templates/README.template.md`](../../.agents/templates/README.template.md) | 同上旧五节；可选发布/治理/License | 与 C1 同源 | **改写为 §2 目录**；License 校验改为「有则写、无则披露缺席」 |
| C3 | Spec [`10`](../../.agents/rules/10-smtgit-project-conventions.md) §F README.md section order | 与 Spec 02 **重复**旧五节（中文标题） | Coupled：只改 02 → Spec 10 仍强制旧序 | **§F 改为「遵循 Spec 02」或内嵌同一 §2 目录**；避免双源 |
| C4 | Spec [`10`](../../.agents/rules/10-smtgit-project-conventions.md) §A 约束 3 | `README is overview only: intro, features, **layout**, shortest examples; no scan deep-dives` | 「layout」强制仓库树；「no scan deep-dives」易被读成禁止 How It Works | 改为产品向 overview 定义；明确允许概念级 `sdepth` 图示，禁止完整工作流 |
| C5 | Spec [`05`](../../.agents/rules/05-documentation-architecture.md) Project documentation rules 第 2 条 | `README is overview only: intro, features, layout, shortest examples, links` | 同 C4 | 与 Spec 02 对齐产品向 overview；**保留**「一命令一文档」 |
| C6 | [`AGENTS.md`](../../AGENTS.md) Essential constraints | `README stays overview-only with fixed section order` | 「fixed section order」指向旧五节摘要 | 改为「fixed section order per Spec 02（产品向）」或删具体旧序、只链 Spec 02 |

> **说明：** C1/C2 是用户已点名的纳入对象；C3–C6 是**同批必改的连带冲突**。若只改 Spec 02 + template 而留下 Spec 10/05/AGENTS.md，代理按 Source-of-truth 仍可能读到互相矛盾的 MUST。

### 4.2 Boundary（不拦目录，但约束写法）

| ID | 位置 | 现行要求 | 对 §2 的影响 | 建议处置 |
|----|------|----------|--------------|----------|
| B1 | Spec 02 Content rule 3；Spec 05 Prohibited #1；Spec 10 §A/F | MUST NOT 吸收完整 sdepth/scan 工作流；MUST NOT dump scan implementation detail | How It Works **可以**有图示与摘要；**不可以**搬 `pull.md` 工作流/退出码/相关代码 | Spec 02 改写时用「概念 vs 规范参考」二分句消解歧义 |
| B2 | Spec 05 / 10「一命令一文档」；Extending subcommands → README **feature bullet** | 完整语义在 `docs/<command>.md`；新命令要更新 README 功能点 | Usage/Features 可提命令名；全文参考仍归 `docs/pull.md`；「feature bullet」应对齐 Features 能力条目而非旧「功能」节 | Spec 05/10 将「feature bullet」改为「Features 或 Usage 中的可验证提及」 |
| B3 | Spec 02 / 04 / 06 | 禁止虚构 license、平台矩阵、安全保证；禁止营销超级措辞 | License / Requirements / Safety 只能写证据内事实 | 保留禁令；License 节按「实际许可状态」= 当前披露缺席 |
| B4 | Spec 08 §1 | 用户可见行为变更时更新 `docs/<command>.md` 与 README feature/quick-start | 产品向后应对 Quick Start / Usage / Features | 措辞改为「README 中与用户可见行为对应的 Quick Start / Usage / Features」 |
| B5 | Spec 06 | README 示例须与 `usage_pull` / `docs/pull.md` 对照 | Usage / Quick Start 仍须可验证 | **保留**；与产品向兼容 |
| B7 | Spec 04 术语 | `sdepth`、worktree root、Path scheme C、`discover_git_repos` 定义 | How It Works 应用这些术语，勿把 `sdepth` 写成目录深度 | **保留**；产品叙事仍用规范术语 |
| B8 | Spec 02 Prohibited #3；Spec 10 纯 bash+git | 不得列出 bash/git 以外运行时依赖 | Requirements 不得发明包管理器/运行时 | **保留** |
| B9 | Spec 05 Diátaxis 表 | README = Orientation / Quick Start；精确语义 = `docs/<command>.md` | §2 的 How It Works 属 Explanation-lite，仍须短 | 可在 Spec 05 表增一行：README How It Works = 概念说明（非完整参考） |

### 4.3 Policy（需维护者裁定，否则代理不得 silent 选择）

| ID | 位置 | 张力 | 选项 |
|----|------|------|------|
| P-LANG | Spec 02 rule 5；Spec 04 rule 7 | §2 节标题为英文；现行产品文档多为中文；规则要求语言冲突上报 | (a) 中文正文 + 英文节标题；(b) 全文中文节标题意译；(c) 产品 README 改英；(d) 维持中文旧结构（否决产品向） |
| P-LIC | Spec 02 禁虚构 license；无 `LICENSE` 文件 | §2 含 License 节 | (a) 节内写「尚未提供 LICENSE」；(b) 无文件则省略 License 标题；(c) 先补 LICENSE 再写条款 |
| P-ENV | Requirements「Supported environments」 | 无测试矩阵 | 仅 bash≥4.3 + 系统 git；或维护者批准点名平台 |
| P-HIDE | 2026-11-20 Q1 | 隐藏目录不扫描 | Safety 写现状 Limitation，或先修代码 |

### 4.4 Stale-ref / 历史（不要改写成「现行规范」，但执行时勿引用为 MUST）

| ID | 位置 | 内容 | 处置 |
|----|------|------|------|
| S1 | [`docs/maintenance/agents-md-migration.md`](../maintenance/agents-md-migration.md) L5/L17 | 记录「README 固定五节」「layout 在 README」为迁移当时处置 | **保留历史**；落地后可加 dated addendum 指向新 Spec 02，勿回写旧表假装从未存在 |
| S2 | [`supplementary/2026-11-20-…`](./supplementary/2026-11-20-readme-pull-release-docs-review.md) F5 | 「现行 README 符合旧五节」为当时验证事实 | 历史正确；产品向落地后自然过时 |
| S3 | [`archive/2026-11-23-…`](./archive/2026-11-23-product-oriented-readme-revision.md) | 将建议目录视为待裁定选项 | 以**本报告 §1–§2** 为后续立场；该文已加 addendum 指针 |
| S4 | Spec 10 §A 布局树注释 `README.md # Overview only` | 仍正确（README≠百科） | 可改注释为 `product overview`；非 Blocker |

### 4.5 None（与 §2 兼容，无需为目录而改）

| 位置 | 为何兼容 |
|------|----------|
| Spec 00 / 09 | 权威与发布边界；不规定 README 小节 |
| Spec 01 | 证据顺序；产品向仍须先查代码 |
| Spec 03 | RFC；产品 README 文风变更通常不自动等于 RFC，除非维护者要求 |
| Spec 07 | 审查清单；落地后用其验证 02/10/05/README 一致即可 |
| `.cursor/rules/agents-rules.mdc` | 只指向读 Spec 02/04/05，无旧五节正文 |
| `docs/release.md` 保留结论（2026-11-20） | Documentation 节链接即可；不冲突 |
| `docs/<command>.md` 七节顺序（Spec 05/10） | **保持**；与 README 产品向正交 |

## 5. Spec `02` / `README.template` 目标改写要点（调研草案，未生效）

### 5.1 Spec 02 — Project-required section order（替换原文）

建议权威顺序改为：

1. Title + one-sentence product positioning (+ short problem / audience / differentiation paragraph)
2. **Why smtgit?**
3. **Features**
4. **Requirements**
5. **Quick Start**
6. **How It Works**
7. **Usage**
8. **Safety and Limitations**
9. **Documentation**
10. **License** (or explicit absence disclosure / omit per Maintainer policy)

并删除「Additional sections MAY include full governance tables / directory tree in the main body」。治理链接最多出现在 Documentation 末行。

### 5.2 README.template — 同步 checklist

- Required section order = 上表。
- Validation 保留：CLI 对照、禁止虚构 badge/license 正文/平台矩阵、详细语义仍 defer 到 `docs/<command>.md`。
- 删除「目录布局 — tree matching the repo」必选项。
- Optional：单行 Contributors/Agents → `AGENTS.md`（非必选节）。

### 5.3 最小同批变更集（规则层）

若维护者批准落地，**一次变更集**建议至少包含：

1. `.agents/rules/02-readme-writing.md`（C1）
2. `.agents/templates/README.template.md`（C2）
3. `.agents/rules/10-smtgit-project-conventions.md` §A 约束 3 + §F（C3、C4）
4. `.agents/rules/05-documentation-architecture.md` overview 句 + 可选 Diátaxis 行（C5、B9）
5. `AGENTS.md` 一句摘要（C6）
6. （随后或同批）根 `README.md` 按 §2 改写
7. （可选措辞）Spec 08「feature/quick-start」→ Features/Quick Start/Usage（B4）

**不在同批删除或合并：** `docs/pull.md`、`docs/release.md`、迁移历史报告。

## 6. 与「只改 02 + template」相比的风险

| 若只改… | 残留冲突 | 后果 |
|---------|----------|------|
| 仅 Spec 02 | Spec 10 §F、§A；Spec 05；AGENTS.md；template | 代理读 Spec 10（项目约定优先于通用 Spec 的说明）仍可能强制旧五节 |
| Spec 02 + template | Spec 10 / 05 / AGENTS | 模板与 02 一致，但项目约定与入口摘要仍旧 |
| 02 + template + 10 + 05 + AGENTS（§5.3） | 仅剩 P-LANG / P-LIC / P-ENV / P-HIDE | 可执行产品向 README |

Spec 10 写明：在 smtgit 特定主题上 **project spec `10` wins over generic specs**。因此 **C3/C4 的优先级不低于 C1**——遗漏 Spec 10 比遗漏 template 更危险。

## 7. 开放问题（本报告仍需维护者）

| # | 问题 | 阻塞什么 |
|---|------|----------|
| Q1 | 是否批准 §2 为目标目录，并授权执行 §5.3 同批规则修订？ | 规则与 README 落地 |
| Q2 | P-LANG：节标题/正文语言策略？ | Spec 02 语言条款与 README 文稿 |
| Q3 | P-LIC：License 节形式？ | §2 最后一节 |
| Q4 | 是否确认 **不** 合并 `docs/pull.md`？ | How It Works / Usage 深度上限 |
| Q5 | P-ENV / P-HIDE 披露粒度？ | Requirements / Safety 内容 |

## 8. 本报告未做的事

- 未修改 Spec `02`、`README.template`、Spec 05/10、`AGENTS.md`、`README.md`。
- 未起草完整新 README 正文。
- 未开 RFC（规则变更仪式是否需要由维护者在 Q1 时决定）。

## 9. 总结

| 议题 | 结论 |
|------|------|
| 建议目录 | **明确采用** §2 作为 README / Spec 02 / template 的目标结构 |
| Spec 02 + README.template | **必须改写为 §2**（用户已指定纳入范围） |
| 其他冲突（本报告重点） | **Blocker/Coupled：** Spec 10 §A/§F、Spec 05 overview、AGENTS.md 摘要（C3–C6）必须同批；**Boundary：** B1–B9 用措辞收紧而非删节；**Policy：** 语言/许可/环境/隐藏目录待裁定；**历史：** S1–S3 不回写 |
| `docs/pull.md` | 仍不建议合并；与 B1/一命令一文档一致 |
| 下一步 | 维护者裁定 Q1–Q4 → 执行 §5.3 → 按 §2 改 README |

**Final status of this research delivery:** Completed with Open Questions — 目标目录已锁定为调研建议；规则冲突已按等级清查；执行层变更等待维护者批准。

---

## Addendum — 2026-11-24 implementation

维护者指示**按本报告落地、不必单独开 RFC**。执行记录见 [`../maintenance/reports/2026-11-24-product-readme-outline-implementation.md`](../maintenance/reports/2026-11-24-product-readme-outline-implementation.md)。

落地时对开放问题的取舍：P-LANG = 英文节标题 + 中文正文；P-LIC = License 节披露缺席；不合并 `docs/pull.md`；P-ENV = 仅 bash≥4.3 + git；P-HIDE = Safety 中记录为当前限制（未改扫描代码）。

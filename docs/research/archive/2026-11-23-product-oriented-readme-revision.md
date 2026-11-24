# 产品导向型 README 修订调研

- **角色：** `docs/research/archive/` 历史报告（**立场已被后续主入口取代**；保留供追溯）
- **日期：** 2026-11-23（归档：2026-11-24）
- **归档原因：** 关于「建议目录是否采用 / Spec 02 是否必改」的立场已被 [`../2026-11-24-product-readme-outline-rule-conflicts.md`](../2026-11-24-product-readme-outline-rule-conflicts.md) 明确锁定并扩展为规则冲突清查；本文不再作为当前结论入口。
- **仍可查阅的独立片段：** 受众错位分析、`docs/pull.md` 合并选项 A/B/C 详表、建议节证据适配表（主入口已吸收结论，细节以本文为据时可回溯）。
- **性质：** 调研报告历史记录。**不构成** RFC 接受、维护者批准或授权执行修订。
- **关联：** 承接 [`../supplementary/2026-11-20-readme-pull-release-docs-review.md`](../supplementary/2026-11-20-readme-pull-release-docs-review.md) 的事实层发现。

## 1. 问题陈述

现行 README 对「仓库里有什么、命令是什么、文档与治理在哪」回答充分，对「解决什么问题、为何选用、与直接批量 `git pull` 的差异、30 秒内如何确认可用」回答不足。

维护者给出的目标写作转向：

> 从「告诉用户 smtgit 仓库包含什么」，转变为「让用户理解 smtgit 能解决什么问题，以及如何用它解决问题」。

建议大纲（摘要）：开篇产品定位 → Why smtgit? → Features → Requirements → Quick Start → How It Works（含 sdepth 图示）→ Usage → Safety and Limitations → Documentation → License。

本报告回答三个调研问题：

1. 按该方向修订 README 是否可行，边界与风险是什么？
2. `docs/pull.md` 能否 / 应否合并进 README？
3. 是否应将新目录写入 Spec `02`（以及连带哪些规则）？

## 2. 验证事实（Verified facts）

| # | 事实 | 证据 |
|---|------|------|
| F1 | 现行 README 固定小节顺序为：一句话引言 → **功能** → **目录布局** → **快速开始** → 链到 `docs/`；其后可有发布 / 治理等 | Spec [`02`](../../../.agents/rules/02-readme-writing.md)、[`10` §F](../../../.agents/rules/10-smtgit-project-conventions.md)、[`README.template.md`](../../../.agents/templates/README.template.md)；现行 `README.md` 符合 |
| F2 | Spec 02 **禁止** README 吸收完整 `sdepth` / 扫描工作流，要求链到 `docs/pull.md` | Spec 02 Content rule 3 |
| F3 | Spec 05 / 10：**一命令一文档**；README 只做总览；完整命令语义在 `docs/<command>.md` | Spec 05、10 §A/F |
| F4 | Spec 05 Diátaxis：README ≈ orientation + quick how-to；精确语义 / 退出码 = `docs/pull.md` | Spec 05 |
| F5 | 产品差异化能力是 **按 Git 仓库嵌套深度（`sdepth`）发现并批量 `git pull`**，而非普通目录深度；路径方案 C 决定「`-p` 是否为 worktree 根」时的行为分支 | `smtgit.sh` `cmd_pull`；`shared/scan.sh`；`docs/pull.md` |
| F6 | CLI 表面：`pull`、`help`；`--sdepth` 仅 `0`/`1`；单仓失败不中断整批；无额外运行时依赖 | `smtgit.sh`；`bash smtgit.sh help` / `help pull` |
| F7 | 仓库**没有** `LICENSE` 文件 | 文件系统检查 |
| F8 | 产品文档现行语言主要为中文；Spec 02 要求语言政策冲突**上报维护者**，不得 silently 全盘英文化 | Spec 02 Content rule 5；现行 README / `docs/pull.md` |
| F9 | 治理入口已有独立权威位置：`AGENTS.md`、`.agents/rules/`、`RFCs/`、`docs/research/`、`docs/maintenance/` | `AGENTS.md`；Spec 05 triad |
| F10 | 前次调研已证实：需 bash ≥ 4.3（`local -n`）；隐藏目录下仓库默认不被发现；`git pull` 无额外参数 | [`2026-11-20-…`](../supplementary/2026-11-20-readme-pull-release-docs-review.md) F1–F3 |

## 3. 调研发现（Survey findings）

### 3.1 现行 README 的受众错位

| 现行区块 | 主要回答的问题 | 对终端用户的价值 |
|----------|----------------|------------------|
| 开篇（实现向一句话 + 依赖 + 指向 pull.md） | 它是什么技术对象？ | 中：有定位，但价值主张弱 |
| **功能** | 有哪些子命令？ | 中：偏 CLI 清单，非能力卖点 |
| **目录布局** | 仓库里有什么？ | **低**（维护者 / Agent 关心） |
| **快速开始** | 最短怎么跑？ | **高** |
| **发布** | 如何打 tag / Release？ | **低**（维护者） |
| **文档与治理**（含 RFC 状态、Agent Rules、迁移记录） | 治理体系在哪？ | **低**（贡献者 / Agent） |

结论：结构合规（F1），但信息密度偏向仓库说明；与本次「产品介绍」目标不一致。这是**写作定位问题**，不是事实错误问题。

### 3.2 建议大纲与现行规则的硬冲突

建议大纲若原样落地，会与下列**强制性**规则冲突（不是风格偏好）：

| 建议变化 | 冲突规则 | 冲突性质 |
|----------|----------|----------|
| 去掉 **目录布局** 作为主体必选节 | Spec 02 / 10 / README.template 必选第 3 节 | **硬冲突** |
| 用 Why / Features / How It Works / Usage / Safety 替换「功能→布局→快速开始」顺序 | Spec 02 / 10 固定顺序 | **硬冲突** |
| 把 sdepth 提升为带图示的核心能力说明 | Spec 02「MUST NOT absorb full sdepth / scan workflows」 | **边界冲突**（概念图示 vs 完整工作流） |
| License 节写「实际许可状态」 | 无 `LICENSE`（F7）；Spec 02 禁止虚构 license | **内容边界**：只能披露「尚未声明」，不能杜撰条款 |
| 英文小节标题为主的产品 README | Spec 02 语言政策（F8） | **政策冲突**：需维护者明确是否改语言 |

因此：**不能在不改 Spec 02（及连带 Spec 10 / template）的前提下，直接按建议大纲改 README。** 否则代理或后续贡献者会按旧规则「纠正」回仓库说明型结构。

### 3.3 建议大纲各节的证据适配性

| 建议节 | 可否用已验证事实填写 | 注意 |
|--------|----------------------|------|
| 一句话产品定位 + 解决什么问题 | 是 | 应用用户语言重述 F5，避免开篇堆实现细节 |
| Why smtgit?（容器多仓 / 嵌套子模块 / 控制发现范围） | 是 | 与方案 C + `sdepth` 直接对应；勿编造未实现场景 |
| Features | 是 | 应以能力表述（发现、嵌套扫描、可配置 sdepth、批量 pull、轻依赖），避免再列仓库目录 |
| Requirements | 部分 | bash + git 已验证；「Supported environments」**未**有官方矩阵——最多写「需 bash ≥ 4.3 + 系统 git」，勿写未验证的 OS 支持表（F10） |
| Quick Start | 是 | 保留可验证命令；可补「获取项目」一步（clone），仍属事实 |
| How It Works（嵌套图 + sdepth + 路径处理） | 有条件 | **概念级**图示与方案 C 简表适合 README；完整工作流 / 发现规则 / 退出码应留在 `docs/pull.md`（F2–F4） |
| Usage | 是 | 常用命令可与 `help pull` 对齐；勿复制整份参考 |
| Safety and Limitations | 是（强建议写） | 仅 `git pull`、单仓失败继续、无 LICENSE/安全保证；可纳入前次调研的已知限制（隐藏目录、bash 版本），但隐藏目录是否「缺陷」仍待裁定 |
| Documentation | 是 | 链到 `docs/pull.md`、`docs/release.md`；治理链接应压缩或移出主体 |
| License | 受限 | 无文件 → 只能写「尚未提供 LICENSE」或省略该节标题改用「Project status」披露 |

### 3.4 治理信息应去哪

从 README 主体移出 **目录布局全树、RFC 状态段、Agent Rules 表、迁移记录** 与 Spec 05「Agent guide ≠ README」一致（F9）。

建议去向（调研建议，非已批准政策）：

| 内容 | 建议权威位置 |
|------|----------------|
| 仓库布局 / Agent 约束 | `AGENTS.md` + Spec 10（已有） |
| RFC / 研究 / 实施报告导航 | `RFCs/README.md`、`docs/research/README.md`、`docs/maintenance/` |
| 发布 how-to | `docs/release.md`（README 最多一行链接） |
| 贡献者入口 | 无 `CONTRIBUTING.md` 时：README 末尾极短「For contributors / agents → AGENTS.md」即可 |

## 4. `docs/pull.md` 能否合并进 README？

### 4.1 选项对比

| 选项 | 做法 | 优点 | 缺点 |
|------|------|------|------|
| **A. 完全合并后删除 `docs/pull.md`** | 把命令表、关键语义、工作流、退出码、相关代码全部并入 README | 单页读完 | 违反 F2–F4；README 变为完整参考；双受众混杂；后续每加命令仍需「一命令一文档」例外；与 `usage_pull`「See docs/pull.md」冲突 |
| **B. 保留 `docs/pull.md`，README 只提升概念层**（推荐） | README How It Works / Usage 放**用户够用**的 sdepth 图示与方案 C 简表；`pull.md` 仍为规范参考（退出码、发现规则、相关代码） | 符合 Diátaxis；保留单一事实源；支持产品叙事 | 两处都谈 sdepth，需纪律：README 概念、pull.md 规范，避免表述漂移 |
| **C. 瘦身 `pull.md` 为附录式，主体叙事全在 README** | 接近 B，但进一步缩短 pull.md | README 更完整 | 仍需两文件；「合并」名不副实；维护边界模糊 |

### 4.2 结论（调研建议）

**不建议将 `docs/pull.md` 完全合并进 README（否决选项 A）。**

理由：

1. **规范冲突：** Spec 02/05/10 明确 README ≠ 完整命令参考；合并等于废除「一命令一文档」对唯一用户命令的适用，需正式改规则且收益有限（当前仅 `pull` 一个命令，不代表长期成立）。
2. **篇幅与扫描性：** `pull.md` 约 110+ 行规范内容（选项表、方案 C、工作流树、发现规则、退出码、相关代码）。并入后 README 会同时承担营销叙事与规范手册，削弱「30 秒确认」目标。
3. **单一事实源：** CLI help 已指向 `docs/pull.md`；规范细节应以该文件 + 代码为准。README 复制退出码 / 发现规则易与实现漂移。
4. **产品目标不要求合并：** 突出 sdepth 与场景，只需在 README 增加**解释性**图示与短表，不必搬迁参考全文。

**推荐选项 B：** README 产品化；`docs/pull.md` 保留为权威命令参考；两者交叉链接；语义变更时先改代码与 `pull.md`，再同步 README 概念段。

## 5. 是否将新目录纳入 Spec `02`？

### 5.1 结论（调研建议）

**应当更新 Spec `02`，但不要「只改 02、不改连带文件」，且更新应在（或紧随）维护者批准产品向 README 大纲之后。**

否则会出现：README 已产品化，代理仍按旧必选「目录布局」回写——治理与产品文档互相打架。

### 5.2 建议写入 Spec 02 的方向（草案级，非已生效文本）

将「仓库说明型固定五节」改为「产品介绍型固定骨架」，例如：

1. 一句话产品定位（解决什么问题）
2. **Why smtgit?**（经核实的典型场景）
3. **Features**（能力，非仓库树）
4. **Requirements**（仅已验证依赖）
5. **Quick Start**（获取 + 最短可运行命令）
6. **How It Works**（`sdepth` 概念 + 路径行为**摘要**；禁止完整工作流/退出码百科）
7. **Usage**（常用命令；细节链到 `docs/<command>.md`）
8. **Safety and Limitations**（仅代码支持的行为与已知限制）
9. **Documentation**（产品文档链接；治理入口至多一行）

并保留 / 强化现有禁令：

- MUST NOT 虚构 license、平台矩阵、安全保证
- MUST NOT 把 `docs/<command>.md` 全文吸入 README
- MUST NOT 在 README 主体展开 RFC / Agent Rules / 完整目录树
- Quick Start 命令 MUST 可对照 CLI 验证

### 5.3 必须连带修订的文件

| 文件 | 原因 |
|------|------|
| [`.agents/rules/10-smtgit-project-conventions.md`](../../../.agents/rules/10-smtgit-project-conventions.md) §F README 顺序 | 与 Spec 02 重复规定同一顺序；只改 02 会 Spec 内冲突 |
| [`.agents/templates/README.template.md`](../../../.agents/templates/README.template.md) | 仍要求「功能 / 目录布局」旧顺序 |
| [`.agents/rules/05-documentation-architecture.md`](../../../.agents/rules/05-documentation-architecture.md) | 「README is overview only: intro, features, **layout**, …」需改为产品向概述定义；**保留**「一命令一文档」与「完整语义不在 README」 |
| `AGENTS.md` 中「README stays overview-only with fixed section order」摘要 | 避免入口摘要与 Spec 02 新顺序不一致 |

**不建议**为这次 README 文风调整单独开大型治理 RFC，除非维护者要求；但因 Spec 02/10 属 Accepted 治理体系下的规范文件，**改必选小节顺序属于规则变更**，应有明确维护者批准（可记在 PR / 短 RFC / 维护者指令任选其一）。

## 6. 设计建议（Design proposals）

### 6.1 推荐实施顺序

```text
1. 维护者确认：产品向大纲 + 语言（中文保留 / 中英混合 / 全英）
2. 维护者确认：不合并 docs/pull.md（或明确反对本报告建议）
3. 一次变更集内更新 Spec 02 + Spec 10 §F + README.template + Spec 05 相关句
4. 按新 Spec 改写 README（保留事实；压缩治理；提升 sdepth 概念图）
5. 仅做 docs/pull.md 的交叉链接与措辞对齐（不删、不合并）
6. （可选）吸收 2026-11-20 报告中的 bash 版本与限制说明进 Requirements / Safety
```

### 6.2 README 内容迁移映射（现行 → 产品向）

| 现行内容 | 建议处置 |
|----------|----------|
| 开篇技术定义 | 改写为产品定位 + 与「find + xargs git pull」类做法的差异（嵌套深度控制、方案 C） |
| **功能**（子命令列表） | 并入 Features（能力）+ Usage（命令）；子命令名仍须准确 |
| **目录布局** | **移出** README 主体 |
| **快速开始** | 保留并扩展为 Quick Start（含获取项目） |
| **发布** | 压缩为 Documentation 下一行，或完全留给 `docs/release.md` |
| **文档与治理**大表 + RFC 状态 | 压缩为 Documentation（产品）+ 可选一行 Contributors/Agents |
| （缺失）Why / How It Works / Safety | **新增**；How It Works 用目录树图示解释 `sdepth=1` vs `0`，材料可改编自 `docs/pull.md` 示例树与方案 C 表 |

### 6.3 明确不推荐的做法

1. 在未改 Spec 的情况下强行改 README 必选结构。  
2. 删除 `docs/pull.md` 或将其降级为「空壳转载」。  
3. 在 License / Supported environments 中写入无证据承诺。  
4. 把 How It Works 写成 `cmd_pull` 伪代码级实现说明（违反 Spec 02/05）。  
5. 用营销超级措辞（「最安全」「生产级保证」等）——与 Safety 节的诚实披露相矛盾，且违反 Spec 04。

## 7. 开放问题（Maintainer decisions）

| # | 问题 | 影响 |
|---|------|------|
| Q1 | 是否批准「产品向」必选小节顺序，并授权同步修改 Spec 02 / 10 / 05 / README.template？ | 阻塞正式 README 改写 |
| Q2 | README 正文语言：维持中文、中英标题+中文正文、还是全英？ | 影响 Spec 02 语言条款与写作执行 |
| Q3 | 确认 **不** 合并 `docs/pull.md`（本报告推荐），还是坚持单页合并？ | 决定文档架构是否要开 RFC 级变更 |
| Q4 | 「Supported environments」允许写到什么粒度？（仅 bash≥4.3 + git，还是点名 Linux/macOS/WSL？） | 无测试矩阵时扩大声明有虚假风险 |
| Q5 | 隐藏目录不扫描：文档化为 Limitation，还是先修扫描再写？（见 2026-11-20 Q1） | 影响 Safety and Limitations 诚实度 |
| Q6 | LICENSE：保持「未提供」披露，还是先补许可证再写 License 节？ | License 节能否从「缺席说明」升级为真实条款 |

## 8. 本报告未做的事

- 未修改 `README.md`、`docs/pull.md`、任何 `.agents/rules/` 或模板。  
- 未起草完整新 README 正文（避免在规则未批准前产生第二事实源）。  
- 未创建 RFC；若维护者要求规则变更高仪式化，可基于本报告 §5–§6 起草短流程 RFC。

## 9. 总结建议

| 议题 | 建议 |
|------|------|
| README 产品导向修订 | **值得做**；保留事实、压缩治理、突出问题/场景/`sdepth`；与用户目标一致 |
| 合并 `docs/pull.md` 进 README | **不建议**；改为 README 概念层 + `pull.md` 规范层 |
| 更新 Spec `02` | **建议更新**，并**连带** Spec 10、05、README.template；作为改 README 的前置或同批变更 |
| 下一步 | 维护者裁定 §7 的 Q1–Q3 后，再执行规则修订与 README 改写 |

---

**Final status of this research delivery:** Completed with Open Questions — 调研结论已记录；执行层修订等待维护者裁定。

---

## Addendum — 2026-11-24

维护者跟进后，后续立场以 [`../2026-11-24-product-readme-outline-rule-conflicts.md`](../2026-11-24-product-readme-outline-rule-conflicts.md) 为准：

1. **明确采用**该任务中给出的建议 README 目录（Why / Features / Requirements / Quick Start / How It Works / Usage / Safety / Documentation / License）作为落地目标，不再仅作「可选大纲」。
2. 该目录应写入 Spec `02` 与 `README.template`；同批须处理 Spec 10 / 05 / `AGENTS.md` 等连带冲突（详见主入口冲突清查）。
3. 本文 §4「不合并 `docs/pull.md`」建议仍然有效；本文未改写正文历史结论。

### Addendum — 2026-11-24（归档）

本文已迁入 `docs/research/archive/`。当前研究结论请读 [`../2026-11-24-product-readme-outline-rule-conflicts.md`](../2026-11-24-product-readme-outline-rule-conflicts.md)；专项事实审查见 [`../supplementary/2026-11-20-readme-pull-release-docs-review.md`](../supplementary/2026-11-20-readme-pull-release-docs-review.md)。

# Research: agb CLI help 中英双版与系统语言选择

- **Date:** 2026-11-24
- **Kind:** Research Report（调研；**不是** RFC Accept）
- **Scope:** `agb` CLI 的 `help` / usage 文案语言；重点：按系统语言配置选择输出，同时保留英文版
- **Related:** 架构骨架 [`../../architecture/skeleton.md`](../../architecture/skeleton.md)；Draft [`RFC-DOC-002`](../../../../RFCs/RFC-DOC-002-agent-governance-bootstrap.md) **§7.14**
- **Adoption (2026-11-24):** 方案 **L1** + §6 语言选择算法已写入 RFC-DOC-002 §7.14，并在 staging CLI（`shared/ui_lang.sh` + `shared/usage.sh`）落地；本文件仍为证据，不是 Accept。
- **Out of scope for this report:** 完整 i18n（错误日志 / Pack 正文 / Prompt 全文）、独立仓库 CLI 语言选型（Go/Python，RFC §15）

## 1. 问题陈述

**Verified fact：** 当前 `bash agb/agb.sh help`（及各 `help <command>`）输出为**英文**；文案硬编码在 `agb/agb.sh` 的 `usage_*` heredoc 中。在本机 `LANG=zh_CN.UTF-8` / `LC_MESSAGES=zh_CN.UTF-8` 下输出仍为英文，说明 **help 尚未绑定任何 locale 机制**。

**核心目标（任务给定）：**

1. 支持**中文** help 输出；
2. **保留英文版**（不可只剩中文）；
3. 重点调研：如何根据**当前系统的语言配置**决定输出语言。

本报告只回答「学到了什么 / 应考虑什么」，不落地实现，不 Accept 任何 RFC。

---

## 2. Verified facts（仓库与本机证据）

| ID | 陈述 | 证据 |
|----|------|------|
| V1 | `help` / `-h` / `--help` / `help <topic>` 走 `usage_*`，正文为英文 heredoc | `agb/agb.sh`（约 12 个 `usage_*`） |
| V2 | 改变 `LANG` / `LC_MESSAGES` / `LC_ALL` **不改变** agb help 首行与正文语言 | 本机实测：`LANG=zh_CN.UTF-8` 与 `LC_ALL=C` 下均为 `Usage: agb.sh …` |
| V3 | 桩命令与日志前缀（`agb: …`）同为英文硬编码 | `shared/stub.sh`、`shared/log.sh` |
| V4 | 产品向 README / 多份产品文档以中文为主；治理文档（`AGENTS.md`、`.agents/rules`、多数 RFC）以英文为主 | Spec `02` / `04`；现行 `agb/README.md`、根 `README.md` |
| V5 | Spec `02`：产品 README 正文宜中文；CLI 示例可与脚本一致（常为英文）；语言政策冲突须上报维护者，不得 silent 全盘改写 | `.agents/rules/02-readme-writing.md` |
| V6 | 本机（WSL）locale：`LANG=zh_CN.UTF-8`，`LC_ALL` 空，`LANGUAGE` 空；`locale -a` 含 `zh_CN.utf8`、`C.utf8` | `locale` / `locale -a` |
| V7 | 同机 GNU 工具在中文 locale 下可出中文 help（如 `ls --help` →「用法：」；`LC_ALL=C` → `Usage:`） | 本机实测 |
| V8 | `gettext` 二进制存在；`msgfmt` **未**安装；`/usr/share/locale/zh_CN/LC_MESSAGES` 有系统包 `.mo`，与 agb 无关 | 本机路径探测 |
| V9 | RFC-DOC-002 未规定 CLI UI 语言；§15 仅开放「CLI 实现语言（Go vs Python）」 | RFC-DOC-002 |
| V10 | agb 仍为 staging 骨架；业务命令多为 stub exit 2；帮助面是目前唯一「完整」用户可见 CLI 文案 | `agb.sh` / 实施报告 |

**Claim class：** 上表为 Verified（本仓库文件或本机命令）。下文 Survey / Design 另行标注。

---

## 3. Survey findings：系统如何表达「消息语言」

### 3.1 POSIX / glibc 惯例（Survey）

对**面向用户的消息**（含许多 CLI 的 `--help`），常见约定是看 **`LC_MESSAGES` 类别**，而不是 `LC_TIME` / `LC_NUMERIC` 等。

有效查找顺序（概念上，与 gettext / glibc 文档一致；实现时应以所选运行时为准）：

1. **`LC_ALL`**（若非空）覆盖所有类别，包括 messages  
2. 否则 **`LC_MESSAGES`**（若非空）  
3. 否则 **`LANG`**  
4. 若结果为 `C` / `POSIX`（或等价），通常视为**不翻译** / 英文源文案  

**`LANGUAGE`（GNU 扩展，Survey）：** 可为冒号分隔的**偏好列表**（如 `zh_CN:zh:en`）。gettext 会按列表选可用翻译；它**不**取代「是否启用翻译」的 C locale 短路——许多实现对 `LC_ALL=C` 仍强制英文。

**本机旁证：** `LC_ALL=C` 时 `locale` 显示 `LC_MESSAGES="C"`，即使 `LANG=zh_CN.UTF-8`；与「`LC_ALL` 优先」一致。

### 3.2 标签解析（Design-relevant Survey）

从 locale 字符串映射到「中文 / 英文 / 其他」时，实践中常见：

| 输入示例 | 常见解释 |
|----------|----------|
| `zh_CN.UTF-8` / `zh_CN.utf8` / `zh_TW` / `zh` | 中文（可再细分为地区，MVP 可合并为「中文」） |
| `en_US.UTF-8` / `en` / `C` / `POSIX` | 英文 |
| 空 / 无法解析 | 需定义回退（通常英文） |

**注意：** 大小写与 `.utf8` vs `.UTF-8` 在不同系统上并存；匹配应基于**语言子标签**（如忽略编码后缀后看 `zh*`），而不是整串相等。

### 3.3 生态对照（Survey，advisory）

| 模式 | 谁在用 | 对 agb 的含义 |
|------|--------|----------------|
| gettext（`.po` / `.mo`）+ `LC_MESSAGES` | GNU coreutils、大量 Linux CLI | 标准、可扩展；bash 骨架需 `gettext` 运行时，构建要 `msgfmt`（本机缺） |
| 运行时按 locale 选内置字符串表 | 自研小工具常见 | 无额外构建依赖；适合双语文案量小的 help |
| 仅 `--lang` / 环境变量覆盖、不读 locale | 部分跨平台工具 | 可控，但不满足「跟系统语言」的默认目标 |
| Git 等 | 本机 `git help` 在 `zh_CN` 下已为中文 | 说明用户环境已具备中文消息预期；agb 与之脱节会造成体验不一致 |

---

## 4. 目标澄清与范围切分

| 层次 | 是否在本次目标内 | 说明 |
|------|------------------|------|
| `agb.sh help` / `help <cmd>` / `-h` 的 usage 正文 | **是** | 用户明确的双版 help |
| stub / `log_*` 诊断短句 | **建议同策略，可二期** | 同属 CLI 用户可见；非本任务硬性范围 |
| `docs/*.md`、Pack 内 Markdown、RFC 正文 | **否** | 文档语言政策另案；Spec 已有中英分工 |
| Agent Prompt 模板语言 | **否** | 与 emit-first 工作流相关，独立决策 |
| 命令名本身（`init`、`validate`） | **保持英文**（强烈建议） | 与脚本 argv、文档交叉引用、自动化解析一致；翻译的是**说明文字** |

**「保留英文版」的含义（需维护者确认的产品语义）：**

| 解释 | 含义 |
|------|------|
| A. 运行时双轨 | 中文环境出中文；英文/`C` 环境出英文；源码或资源中**两套文案都存在** |
| B. 强制并列输出 | 每次 help 中英并排打印 |
| C. 显式切换 | 永远能通过 flag/环境变量拿到英文（即使系统是中文） |

与「按系统语言配置决定默认输出」最对齐的是 **A + C**（默认跟 locale；覆盖开关保证英文永远可达）。**B** 噪音大，仅作可选项。

---

## 5. 方案比较（Design proposals，未采纳）

### 方案 L1 — 双 heredoc / 双函数 + 手写 locale 解析（bash 内置）

```text
resolve_ui_lang → zh | en
usage_root_zh / usage_root_en
```

| 优点 | 缺点 |
|------|------|
| 零新运行时依赖；与当前 bash 骨架一致 | 文案重复，易漂移；语言一多即崩 |
| 实现与测试路径短 | 需自写 locale 解析，要覆盖 `LC_ALL` / `LC_MESSAGES` / `LANG` / `LANGUAGE` |

**适合：** 明确只要 **zh + en**、help 面文案量可控（现状 ~12 段 usage）。

### 方案 L2 — GNU gettext

| 优点 | 缺点 |
|------|------|
| 业界标准；`LANGUAGE` 列表自然 | 本 staging 缺 `msgfmt`；发布需带 `.mo` 或运行时依赖 |
| 利好未来多语言 | 对「仅双语文案」偏重；与「CLI 或迁 Go/Python」叠加成本 |

**适合：** 独立仓库后、确定长期 bash 或绑定 gettext 的实现语言时再评估。

### 方案 L3 — 外置 `locales/en/*.txt` + `locales/zh/*.txt`，运行时 `cat`

| 优点 | 缺点 |
|------|------|
| 文案与逻辑分离；diff 友好 | 需约定占位符（如版本号）；加载路径要稳定 |
| 仍可不依赖 gettext | 比双函数多一层文件约定 |

**适合：** 希望翻译/审阅不改 `.sh`，仍保持双语文案。

### 方案 L4 — 仅 `--lang` / `AGB_LANG`，不读系统 locale

| 优点 | 缺点 |
|------|------|
| 行为极度可预测 | **不满足**「根据系统语言配置」的核心目标 |

可作 **覆盖层**，不可作唯一机制。

---

## 6. 推荐的选择算法（Design proposal）

在未 Accept 任何 RFC 前，下列算法仅作**候选规范**，供后续 RFC / 实现引用。

### 6.1 优先级（高 → 低）

1. **显式覆盖（保留英文的硬保证）**  
   - CLI：`--lang en|zh`（或 `--locale …`）  
   - 环境变量：`AGB_LANG=en|zh`（名称待定）  
2. **系统消息 locale**  
   - 取 `LC_ALL` → 否则 `LC_MESSAGES` → 否则 `LANG`  
   - 若设置了 GNU `LANGUAGE` 且未进入 C 短路：可按列表**第一个**可识别为 `zh*` / `en*` 的项（Survey：与 gettext 精神一致；MVP 可简化为只解析单一类别字符串）  
3. **回退** → `en`

### 6.2 C / POSIX 短路

若有效 messages locale 为 `C` 或 `POSIX`（含 `LC_ALL=C` 的常见调试手法）→ **强制英文**，即使 `LANG=zh_CN.UTF-8`。  
与 GNU 工具行为对齐，便于脚本与 CI 得到稳定英文输出。

### 6.3 映射（MVP）

| 有效标签（规范化后） | UI 语言 |
|----------------------|---------|
| `zh` 或 `zh_*` | 中文 |
| `en` 或 `en_*` | 英文 |
| `C` / `POSIX` | 英文 |
| 其他 / 无法解析 | 英文（回退；是否警告见开放问题） |

MVP **不**区分简繁（`zh_CN` vs `zh_TW`）：统一中文文案，除非维护者要求分拆。

### 6.4 「保留英文」的可测试断言（建议）

| 场景 | 期望 |
|------|------|
| `LC_ALL=C agb.sh help` | 英文 |
| `LC_ALL=zh_CN.UTF-8 agb.sh help`（或等价） | 中文 |
| `AGB_LANG=en` 且系统为 `zh_CN` | 英文 |
| `AGB_LANG=zh` 且 `LC_ALL=C` | 中文或英文？ → **建议：显式覆盖仍优先**，以便译者预览；若希望 C 短路不可覆盖，须单独规定 |
| 源树 / 资源 | 英、中两套 usage 均存在且可抽检 |

---

## 7. 与仓库语言政策的关系

| 层 | 现行倾向 | 对 help 双版的启示 |
|----|----------|-------------------|
| 产品 README / `docs/<command>.md` | 中文正文 +（根 README）英文节标题 | 中文 help 与产品文档读者一致 |
| 治理（AGENTS / rules / RFC） | 英文 | help 中文化**不要求**治理文档改中文 |
| CLI 命令标识符 | 英文 | 中文 usage 中保留英文命令名与路径 |
| Spec `02` 语言冲突 | 上报维护者 | **CLI UI 语言是新产品面**，建议在 RFC 或维护者纪要中单列，避免只改代码不改政策 |

**Survey：** 根研究与维护报告多次把「产品中文 vs 治理英文」列为开放政策；agb help 落在**产品 CLI**一侧，默认跟系统中文、并保留英文轨，与该分工相容，但仍需维护者一句确认，以免与「CLI 示例保持英文」被误读为「help 必须英文」。

---

## 8. 风险与测试注意

| 风险 | 影响 | 缓解方向 |
|------|------|----------|
| 中英文案漂移 | 一版更新另一版遗漏 | 单测或检查脚本对比「命令列表是否两端齐全」；L3 外置文件便于 diff |
| WSL / 远程 SSH locale 不完整 | `locale` 报错、回退不稳 | 解析失败 → 英文；文档说明需有效 `zh_CN.utf8` |
| `LANGUAGE=zh_CN:en` 与 `LC_ALL=C` 组合 | 用户困惑 | 文档写清短路与覆盖优先级 |
| 把 Pack/RFC 一并翻译 | 范围爆炸、治理英文基线冲突 | 严格限制在 CLI UI 字符串 |
| stub 仍英文、help 已中文 | 体验不一致 | 二期对齐或同期最小集 |

---

## 9. 建议结论（Recommendations — 非 Accept）

在**仅双版 help、bash 骨架、跟系统语言**的约束下，调研倾向：

1. **默认语言**跟消息 locale（`LC_ALL` > `LC_MESSAGES` > `LANG`，尊重 `C` 短路）；可选尊重 `LANGUAGE` 列表的第一可识别项。  
2. **实现形态优先 L1 或 L3**（zh/en 字符串表），暂不引入 gettext（L2），除非独立仓库后重评。  
3. **必须提供显式覆盖**（`--lang` / `AGB_LANG`），以满足「系统中文时仍能稳定拿到英文」——这是「保留英文版」在运行时的可操作含义。  
4. **命令名与 flag 保持英文**；只翻译说明性句子。  
5. 落地前用短 RFC 或 DOC-002 修订附录冻结：优先级、C 短路、覆盖与 `LC_ALL=C` 的冲突规则、是否含 stub/log。

**本报告不授权改 `agb.sh`。** 下一步若维护者认可方向，再开实现任务或 Draft RFC 小节。

---

## 10. Open assumptions / 需维护者拍板

| ID | 问题 | 为何阻塞或影响设计 |
|----|------|-------------------|
| Q1 | 「保留英文」取 A+C（推荐）还是每次中英并列（B）？ | 输出形状与测试断言 |
| Q2 | `AGB_LANG=zh` 是否允许覆盖 `LC_ALL=C`？ | 调试与译者预览 vs 严格 C 短路 |
| Q3 | MVP 是否包含 stub/log 中文化，还是仅 `usage_*`？ | 工作量与一致性 |
| Q4 | 简繁是否分立？ | 文案份数 |
| Q5 | 无法识别的 locale（如 `ja_JP`）是静默英文还是警告？ | UX |
| Q6 | 是否要把 CLI UI 语言写进 RFC-DOC-002 修订，或单独 RFC-DOC-00x？ | 权威落点 |
| Q7 | 根产品 `smtgit.sh help` 是否未来对齐同一策略？ | 范围蔓延；建议 **本期仅 agb** |

---

## 11. 参考

### In-repo

- [`../../../agb.sh`](../../../agb.sh) — 现行英文 help  
- [`../../architecture/skeleton.md`](../../architecture/skeleton.md)  
- [`.agents/rules/02-readme-writing.md`](../../../../.agents/rules/02-readme-writing.md)  
- [`.agents/rules/04-technical-writing.md`](../../../../.agents/rules/04-technical-writing.md)  
- [`RFC-DOC-002`](../../../../RFCs/RFC-DOC-002-agent-governance-bootstrap.md)  
- [`docs/research/README.md`](../../../../docs/research/README.md) — 三角与调研约定  

### External（advisory）

- POSIX locale 类别与 `LC_*` / `LANG` 关系（系统 `locale(1)` / libc 文档）  
- GNU gettext：`LANGUAGE`、`LC_MESSAGES`、`C` locale 行为  
- 本机对照：`ls --help`、`git help` 在 `zh_CN` 下的中文消息  

---

*End of research report. Not Maintainer approval. Not an RFC. Not implementation.*

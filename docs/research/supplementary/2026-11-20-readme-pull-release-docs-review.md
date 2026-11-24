# README / pull / release 文档审查与修订调研

- **角色：** `docs/research/supplementary/` 专项报告（**独立研究价值**；非当前产品向 README 结论的主入口）
- **日期：** 2026-11-20（组织整理：2026-11-24）
- **范围：** `README.md`、`docs/pull.md` 的修订调研；`docs/release.md` 保留必要性评估
- **性质：** 调研报告（学到了什么 / 应考虑什么）。**不构成** RFC 接受、维护者批准或发布授权。
- **为何保留为专项：** 含 bash≥4.3、隐藏目录不扫描实证、`docs/release.md` Keep 论证等，未被后续产品向报告取代。
- **当前产品向结论主入口：** [`../2026-11-24-product-readme-outline-rule-conflicts.md`](../2026-11-24-product-readme-outline-rule-conflicts.md)

## 1. 审查方法

1. 重读三份目标文档与现行治理规则（`AGENTS.md`、`.agents/rules/` 02/04/05/06/07/08/10、`docs/research/README.md`）。
2. 将文档声明与 `smtgit.sh`、`shared/*.sh`、`.github/workflows/release.yml` 逐一比对。
3. 运行 CLI 与发现函数做实证验证（命令见附录）。
4. 校验三份文档的全部相对链接。
5. 按 [`.agents/rules/07-documentation-review.md`](../../../.agents/rules/07-documentation-review.md) 的严重度模型（Blocker / Major / Minor / Suggestion）归档发现。

代码自 2026-11-18 上次文档修订以来未变化（`smtgit.sh`、`shared/`、`release.yml` 无提交），既有文档的技术声明整体仍然成立。

## 2. 验证事实（Verified facts）

| # | 事实 | 证据 |
|---|------|------|
| F1 | 脚本使用 `local -n`（nameref，需 **bash ≥ 4.3**）与 `mapfile`（需 bash ≥ 4.0） | `smtgit.sh:129-130,149` |
| F2 | 目录扫描用 `for child in "$dir"/*`，未设 `dotglob` → **隐藏目录（如 `.config/`）下的仓库不会被发现** | `shared/scan.sh:12`；实证：`/tmp/smtgit-probe/.hidden/repo` 在 `sdepth=0` 下未被 `discover_git_repos` 输出，可见目录仓库正常输出 |
| F3 | `git pull` 以无额外参数形式调用，行为由目标仓库自身 git 配置决定 | `shared/git.sh:28` |
| F4 | bare 仓库与仓库内部普通子目录不会被当作可 pull 目标（`--is-inside-work-tree` + toplevel 相等判定） | `shared/git.sh:12-20` |
| F5 | README 固定小节顺序（引言→功能→目录布局→快速开始→链接）现行 README 符合 | `README.md` vs Spec 02/10 |
| F6 | `docs/pull.md` 固定七节顺序现行版本符合 | `docs/pull.md` vs Spec 05/10 |
| F7 | 三份文档合计 24 条相对链接全部可解析 | 附录链接检查 |
| F8 | RFC-DOC-001 已 **Accepted**（2026-11-19），正文在 `RFCs/accepted/`，原路径为跳转 stub；README 状态描述一致 | `RFCs/accepted/`、stub、README 末段 |
| F9 | release workflow：`v*` tag 触发，`contents: write`，打包 `smtgit.sh shared docs README.md AGENTS.md`，`softprops/action-gh-release@v2` 创建 Release 并自动生成 notes | `.github/workflows/release.yml` |
| F10 | `docs/release.md` 被 README（2 处）、`AGENTS.md` 项目身份表、Spec 05（How-to 映射）、Spec 08（打包内容约定）引用 | 各文件现状 |

## 3. 调研发现（Survey findings）

### 3.1 `README.md`

整体判断：**准确、结构合规，保留框架，做小幅增补**。

| 严重度 | 发现 | 说明 |
|--------|------|------|
| Major | 未声明最低 bash 版本 | 仅写「依赖 bash 与系统 git」，但 F1 表明需 bash ≥ 4.3；使用旧 bash（如 macOS 自带 3.2）会直接运行失败，读者无法从文档预知 |
| Minor | 「文档与治理」表混排产品文档与治理文档 | 8 行表格同时承担两类导航；可拆为「产品文档」与「治理与流程」两组提升可扫读性（可选，不违反任何规则） |
| Suggestion | 目录布局树未展开 `RFCs/` 生命周期子目录 | 树保持高层即可，是否加注 `accepted/` 等由维护者取舍 |
| Suggestion | `docs/maintenance/reports/` 为目录链接 | GitHub 上渲染为目录列表，可接受；日后报告增多可考虑加索引页 |

未发现事实性错误；RFC-DOC-001 状态、`docs/research/` 条目、缺失治理文件的披露均与仓库现状一致（F7、F8）。

### 3.2 `docs/pull.md`

整体判断：**语义与代码一致、七节结构合规，保留并做小幅增补**。

| 严重度 | 发现 | 说明 |
|--------|------|------|
| Major | 隐藏目录不扫描的行为未文档化（F2） | 「发现规则摘要」只写了跳过 `.git`；用户把仓库放在 `.` 开头目录下时会被静默跳过，应写明当前行为。但该行为是**有意设计还是缺陷**需维护者裁定（见 §5 开放问题 Q1） |
| Major | 缺少运行前提（bash ≥ 4.3） | 同 README 的 Major 项；可在「命令」节加一行前提说明 |
| Minor | 未说明 `git pull` 不带额外参数（F3） | 读者可能误以为脚本固定 fast-forward 或 rebase；一句话即可澄清「行为取决于各仓库自身 git 配置」 |
| Suggestion | 判定规则可补一句边界情况（F4） | bare 仓库不在处理范围，属一句话补充，可选 |

退出码表、方案 C 表、示例与工作流程均与实现逐项核对一致。

### 3.3 `docs/release.md`

事实核对：触发条件、打包清单、权限、Release 创建方式均与 `release.yml` 一致（F9）；前提一节（推送权限、启用 Actions、`contents: write`）准确。未发现错误声明。

## 4. `docs/release.md` 保留必要性评估

**结论：建议保留（Keep）。** 依据：

1. **唯一的信息源。** 它是仓库唯一自动化发布路径（`v*` tag → workflow）的 how-to；删除后该知识只剩 YAML 本身，维护者需反读 workflow 才能发布。
2. **符合现行文档架构。** Spec 05 的 Diátaxis 映射明确把「任务导向流程（How-to）」定位到 `docs/release.md`；它不是命令参考，不受「一命令一文档」约束。
3. **被多处权威引用（F10）。** 删除需同步改 README（2 处）、`AGENTS.md`、Spec 05、Spec 08，否则产生断链与规则自相矛盾；收益为零、成本高。
4. **内容准确且低维护。** 约 76 行，单一事实源是 workflow 文件，漂移风险低；打包内容表已声明「以 release.yml 为准」。
5. **读者群独立。** 面向维护者而非 CLI 用户，并入 `pull.md` 或 README 会模糊受众并违反 README 总览纪律。

反向考虑（为何不删）：若未来发布流程废弃（workflow 删除），该文档才进入弃用评估；届时按 Spec 08 记录原因与去向即可。

可选改进（不紧急）：re-tag 或删除 Release 的处置流程当前未文档化，且 workflow 在重推同名 tag 时的行为未经实证——列入开放问题而非直接写文档。

## 5. 修订建议（Design proposals）

可直接执行（有代码证据、不改行为声明）：

| # | 目标 | 建议 |
|---|------|------|
| P1 | `README.md` | 在依赖说明处加「需要 bash ≥ 4.3（脚本使用 nameref/`local -n`）与系统 git」 |
| P2 | `docs/pull.md` | 「命令」节加同样前提；「工作流程」补一句 `git pull` 不带额外参数、行为取决于目标仓库自身配置 |
| P3 | `README.md` | 可选：将「文档与治理」表拆为「产品文档」「治理与流程」两表 |

需维护者先行裁定（裁定后再改文档）：

| # | 目标 | 建议 |
|---|------|------|
| P4 | `docs/pull.md` | 待 Q1 裁定后，在「发现规则摘要」写明隐藏目录行为（现状描述或修复后语义） |
| P5 | `docs/release.md` | 待 Q2 裁定后，补充 re-tag / 撤回 Release 的处置说明 |

## 6. 开放问题（Open questions / assumptions）

| # | 问题 | 为何需要维护者 |
|---|------|----------------|
| Q1 | 隐藏目录不扫描（F2）是有意设计还是缺陷？若有意，文档化现状；若缺陷，先改 `shared/scan.sh` 再同步文档 | 涉及扫描语义变更，属行为决策；Spec 10 禁止文档与代码在方案 C / sdepth 语义上漂移 |
| Q2 | 同名 tag 重推、Release 撤回的官方处置流程是什么？ | workflow 未覆盖，属发布政策，不能由代理发明 |
| Q3 | README 是否需要声明 macOS 等旧 bash 环境的具体规避方式（如 `brew install bash`）？ | 涉及平台支持承诺，目前仅有「bash ≥ 4.3」这一最低限度事实可写 |

## 7. 本报告未做的事

- 未修改 `README.md`、`docs/pull.md`、`docs/release.md`（本轮交付仅为调研）。
- 未创建 RFC；若 Q1 裁定为缺陷修复或 P3 结构性调整被认为值得正式记录，再按 `RFCs/process.md` 起草。
- 未验证 GitHub 端真实发布行为（无测试用 tag 推送权限与必要）。

## 附录：验证命令与结果

| 检查 | 结果 |
|------|------|
| `bash smtgit.sh help` / `help pull` | 与文档一致 |
| `grep -n 'local -n\|mapfile\|shopt' smtgit.sh shared/*.sh` | `local -n` ×2、`mapfile` ×1；无 `shopt`（无 dotglob） |
| 实证扫描 `/tmp/smtgit-probe`（含 `visible/repo` 与 `.hidden/repo` 两个 git 仓库），`discover_git_repos ... 0` | 仅输出可见仓库，隐藏目录下仓库被跳过 |
| 三份文档相对链接（24 条） | 全部可解析，无断链 |
| `git diff 91dc54f..HEAD -- smtgit.sh shared .github` | 代码与 workflow 自上次文档修订以来无变化 |
| `RFCs/accepted/RFC-DOC-001-…` 与原路径 stub | 均存在，README 状态描述一致 |

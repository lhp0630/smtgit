# AGENTS.md Migration Record

- **Original location:** `/AGENTS.md` (repository root)
- **Nested AGENTS.md files:** none found
- **Bootstrap RFC:** [`RFCs/RFC-DOC-001-documentation-governance-bootstrap.md`](../../RFCs/RFC-DOC-001-documentation-governance-bootstrap.md) (Status: Proposed)
- **Migration date:** 2026-11-18
- **New root entry:** [`AGENTS.md`](../../AGENTS.md)
- **Primary extraction target:** [`.agents/rules/10-smtgit-project-conventions.md`](../../.agents/rules/10-smtgit-project-conventions.md) (relocated from `Rules Specs/` on 2026-11-18)
- **Implementation report:** [`reports/2026-11-18-rfc-doc-001-documentation-governance-bootstrap.md`](reports/2026-11-18-rfc-doc-001-documentation-governance-bootstrap.md)

This record exists so Maintainers can verify that meaningful legacy instructions were retained, extracted, consolidated, updated, deprecated, or flagged — not silently discarded.

**Audience:** Maintainers and agents verifying the governance bootstrap. This is a historical migration trace, not end-user product documentation. Product command semantics live in [`docs/pull.md`](../pull.md); release packaging in [`docs/release.md`](../release.md).

## 1. Inventory by category

| Category | Legacy headings / topics |
|----------|--------------------------|
| Project identity and architecture | 仓库布局; 分层; 扩展新子命令时 |
| Code conventions | 核心原则 (stopgap vs stable helpers); shared/ side-effect rules; help requirement; batch failure aggregation |
| Domain / product semantics | sdepth; path scheme C; worktree root判定; discover_git_repos |
| Documentation rules | README 固定小节; docs/`<command>`.md 固定小节; 文风 |
| Security and safety | 纯 bash + 系统 git; 不执行破坏性 git 操作（当前仅 pull） |
| Global agent instructions | “后续改动应与此保持一致” (general binding of constraints) |
| RFC governance | *(not present in legacy file)* |
| Development workflow (build/test) | *(not present — no test suite documented)* |
| Temporary / obsolete | *(none identified as obsolete; layout tree needed additive update for RFCs / Rules Specs)* |

## 2. Disposition of instruction groups

| ID | Instruction group (identifying excerpt) | Disposition | Destination | Notes |
|----|-----------------------------------------|-------------|-------------|-------|
| L1 | Opening purpose: constrain layout, architecture, doc format | **Consolidated** | Root `AGENTS.md` (role + links) + Spec `10` | Meaning retained; root file no longer holds full encyclopedia |
| L2 | Repository layout tree | **Updated** + **Extracted** | Spec `10` §A; summarized in README + AGENTS | Tree **updated** to include `RFCs/`, `Rules Specs/`, `docs/maintenance/` (verified new dirs). Core entries unchanged |
| L3 | 入口薄、共享厚 | **Extracted** | Spec `10` §A; summary in AGENTS | Meaning unchanged |
| L4 | 一命令一文档 | **Extracted** | Spec `10` §A/F; Spec `05` | Meaning unchanged |
| L5 | README 只做总览 | **Extracted** | Spec `10` §A/F; Spec `02` | Meaning unchanged |
| L6 | 纯 bash + 系统 git; 仅 pull / 非破坏性 | **Retained** (summary) + **Extracted** | AGENTS Safety + Spec `10` §A | Security-relevant; not weakened |
| L7 | 核心原则 — prefer stable domain helpers over stopgaps | **Extracted** | Spec `10` §B | Full should/shouldn't + abstract contrast preserved |
| L8 | Layering table (CLI / domain / infra) | **Extracted** | Spec `10` §C; brief mention in AGENTS | Meaning unchanged |
| L9 | shared/ no global side effects on source | **Extracted** | Spec `10` §C | Meaning unchanged |
| L10 | Single-repo failure does not abort batch | **Extracted** | Spec `10` §C; AGENTS summary | Meaning unchanged |
| L11 | Each subcommand must implement help | **Extracted** | Spec `10` §C; AGENTS summary | Meaning unchanged |
| L12 | sdepth semantics + accepted values 0/1 | **Extracted** | Spec `10` §D; AGENTS summary | Meaning unchanged; still matches CLI |
| L13 | Path scheme C | **Extracted** | Spec `10` §D; AGENTS summary | Meaning unchanged |
| L14 | worktree root判定 via rev-parse toplevel | **Extracted** | Spec `10` §D | Meaning unchanged; matches `shared/git.sh` |
| L15 | discover_git_repos excludes root; skip `.git` | **Extracted** | Spec `10` §D | Meaning unchanged; matches `shared/scan.sh` |
| L16 | Extending subcommands (3 steps) | **Extracted** | Spec `10` §E | Meaning unchanged |
| L17 | README fixed section order (5 steps) | **Extracted** | Spec `10` §F; Spec `02` | Meaning unchanged; README still follows it |
| L18 | docs/`<command>`.md fixed section order (7 steps) | **Extracted** | Spec `10` §F; Spec `05` | Meaning unchanged |
| L19 | Doc style: tables, accurate trees, no impl detail in README | **Extracted** | Spec `10` §F; Spec `04`/`05` | Meaning unchanged |
| L20 | Binding phrase「后续改动应与此保持一致」 | **Consolidated** | AGENTS + Spec `10` normative requirements | Same intent: constraints remain mandatory |

## 3. Wording changes that affect presentation (not product semantics)

| Change | Rationale |
|--------|-----------|
| Root `AGENTS.md` rewritten primarily in **English** | RFC-DOC-001 primary language is English; agent-neutral entry. Product semantics preserved in Spec `10` (English rendering of original Chinese rules). |
| Spec `10` translates legacy Chinese rules into English | Enables cross-agent use; **semantic intent preserved**. Original Chinese product docs (`docs/pull.md`, README overview) left in place. |
| Layout tree lists governance directories | Reflects repository after bootstrap; does not change runtime architecture. |
| README adds governance / release / missing-policy notes | Evidence-based; does not claim LICENSE/CONTRIBUTING exist. |

**No product-semantic weakening** was applied to sdepth, path scheme C, dependency policy, or non-destructive git constraint.

## 4. Deprecated instructions

None.

No legacy instruction was found to be false against current code. Layout omission of governance dirs was treated as **update**, not deprecation.

## 5. Unresolved items requiring Maintainer judgment

| Issue | Impact | Options | Recommendation |
|-------|--------|---------|----------------|
| RFC-DOC-001 remains **Proposed** while deliverables exist | Governance may be “implemented but not adopted” | Accept RFC; request revisions; reject | Review deliverables, then set status explicitly |
| Documentation language policy (Chinese product docs vs English governance) | Contributors may be unsure which language to use where | Keep bilingual split; move all to English; move all to Chinese | Keep current split until policy is written |
| Whether release archives should include `RFCs/` and `.agents/rules/` (formerly `Rules Specs/`) | `release.yml` currently packages `smtgit.sh`, `shared/`, `docs/`, `README.md`, `AGENTS.md` only | Extend package list; keep runtime-only archives; document exclusion | Keep runtime-focused archives unless agents need rules offline; if Specs should ship, update workflow + `docs/release.md` |
| Missing `LICENSE` / community files | README cannot state license or contribution rules authoritatively | Add LICENSE + CONTRIBUTING; leave absent; draft as Proposed RFCs | Add LICENSE when ready; avoid inventing terms in docs |
| Whether Spec `10` English text should also keep a Chinese normative twin | Translation drift risk | English-only Spec `10`; bilingual Spec `10`; Chinese Spec + English AGENTS summary | Start English-only Spec `10`; fix wording if Maintainers find drift |

## 6. Conflicts preserved (not arbitrarily resolved)

| Conflict | Handling |
|----------|----------|
| RFC-DOC-001 asks for English governance; legacy AGENTS/README/docs are largely Chinese | Documented bilingual split; language policy listed as Maintainer decision |
| RFC-DOC-001 Status=Proposed vs execution request to implement | Deliverables created for review; RFC status **not** auto-accepted |

## 7. Verification notes (migration-specific)

- Compared Spec `10` domain rules against `smtgit.sh`, `shared/git.sh`, `shared/scan.sh`, and `docs/pull.md`: aligned.
- Confirmed no nested `AGENTS.md`.
- Confirmed legacy file had no RFC/test/license instructions to migrate.

## 8. Addendum — 2026-11-18 path relocation

- `Rules Specs/` renamed to `.agents/rules/`.
- `Rules Specs/templates/` moved to `.agents/templates/` (sibling of `rules/`).
- Cursor Rules load entry added at `.cursor/rules/agents-rules.mdc` (`alwaysApply: true`) pointing agents at `AGENTS.md` and `.agents/rules/`.
- Living docs (`AGENTS.md`, README, RFC process links, Spec `10` layout) updated to the new paths. Historical RFC-DOC-001 narrative that named the original `Rules Specs/` deliverable is left intact as proposal history.

# Research Report: agb (Agent Governance Bootstrap)

- **Document type:** Product / technical feasibility research (not an Accepted RFC)
- **Date:** 2026-11-19 (aligned revision)
- **Document class:** Research report (`docs/research/` triad; see [`README.md`](README.md))
- **Path:** `agb/docs/research/repository-governance-bootstrap-tool-research.md`
- **Prior locations:** `docs/repository-governance-bootstrap-tool-research.md` (removed); `agb/docs/repository-governance-bootstrap-tool-research.md` (moved here)
- **Reference repository surveyed:** smtgit (origin of the governance system)
- **Product name (working):** **agb** — agent governance bootstrap
- **Product home:** **new repository** (not implemented inside smtgit)
- **Staging location in smtgit:** [`agb/`](../../README.md)
- **Status:** Draft for Maintainer review
- **Related RFC:** [`../../../RFCs/RFC-DOC-002-agent-governance-bootstrap.md`](../../../RFCs/RFC-DOC-002-agent-governance-bootstrap.md) (Status: Draft)

Evidence classes:

| Label | Meaning |
|-------|---------|
| **Verified** | Confirmed against smtgit files/commands or cited official docs |
| **Survey finding** | Observed from external tools / official documentation |
| **Design proposal** | Recommended product design; not yet implemented |
| **Open assumption** | Needs Maintainer decision or prototype validation |

---

## 1. Executive Summary

smtgit already hosts a working **agent-neutral documentation governance system** created under **RFC-DOC-001** (Status: **Accepted**, 2026-11-19): `AGENTS.md`, `.agents/rules/`, templates, RFC process, Cursor load entry, and migration/report practices. That system is valuable beyond smtgit, but it must not be productized by growing a second product inside the smtgit application repo.

This research aligns on:

1. **New product / new repository:** **agb** installs and maintains the governance system in *other* Git repos. smtgit is the **reference origin**, not the runtime home of the tool.
2. **RFC-DOC-001 complete outputs are the pack example:** `agb init` installs that governance system (portable extraction) into target repos, and retains RFC-DOC-001 as a worked example. See [`../../examples/rfc-doc-001-deliverables.md`](../../examples/rfc-doc-001-deliverables.md).
3. **Two additional Agent-facing prompt features:**
   - **Research Task generation:** user idea text → tool emits a Research Task Prompt for an Agent.
   - **RFC generation:** approved Research Task → tool emits an RFC Authoring Prompt for an Agent.

```bash
agb init
agb init --agent claude
agb research --idea ./idea.md
agb rfc --research ./tasks/research-task.md --i-approve-research
agb pack emit --prompt-only
```

**Recommended architecture:** local-first **agb CLI** (future repo) + **Git-tagged Governance Pack** (SSOT derived from RFC-DOC-001 deliverables) + optional Agent Adapters + **deterministic prompt emitters** for research/RFC. Migration uses human-gated plans; upgrades use Copier-like three-way merge; version pinning follows a pre-commit-like `ref` model.

**MVP:** pack extraction + `init` / `scan` / `validate` / `research` / `rfc` / `pack emit`; migration planner; defer full auto-apply maturity and three-way `update` to later phases.

---

## 2. Problem Statement

### 2.1 Pain

| Pain | Evidence |
|------|----------|
| Governance locked in one product repo | Verified: rules/RFCs live in smtgit only |
| Manual porting loses knowledge | Verified: disposition migration in `docs/maintenance/agents-md-migration.md` |
| Target repos already have agent/docs norms | Survey finding: AGENTS/CLAUDE/GEMINI/Copilot/Cursor patterns |
| “Copy folder” ships smtgit-specific Spec `10` | Verified: `.agents/rules/10-smtgit-project-conventions.md` |
| Implementing agb inside smtgit couples unrelated products | Design constraint from Maintainer direction (this alignment) |
| Fuzzy ideas rarely become disciplined Research Tasks / RFCs | Process gap; RFC-DOC-001 and templates exist but prompt emitters do not |

### 2.2 Wrong approaches

| Approach | Why insufficient |
|----------|------------------|
| Add `agb` as smtgit subcommand beside `pull` | Couples bash pull tool with governance product; violates separate-repo goal |
| GitHub template of whole smtgit | Ships application code; no upgrade/migration semantics |
| Cookiecutter-only | Weak ongoing update; no agent-knowledge merge |
| Single mega-prompt | No integrity, no stages, inconsistent results |

---

## 3. Product Vision and Goals

### 3.1 Vision

**agb** is a local CLI and versioned pack that makes the RFC-DOC-001-style Agent + documentation governance system installable, migratable, and operable in any Git repository — and that helps users turn rough ideas into Research Tasks and RFCs via Agent-ready prompts.

### 3.2 Goals

| ID | Goal |
|----|------|
| G1 | One-command init of the RFC-DOC-001 governance system into a target repo |
| G2 | Safe scan/migrate of pre-existing agent/docs/RFC assets |
| G3 | Dual modes: Agent CLI orchestration and Prompt-only kits |
| G4 | Pack SSOT with versions, checksums, offline install |
| G5 | Upgrade with three-way merge + overlay protection |
| G6 | Workflows + Prompt Library for ongoing practice |
| G7 | Agent-neutral Markdown SSOT; thin vendor adapters |
| G8 | **`agb research`:** idea → Research Task Prompt |
| G9 | **`agb rfc`:** approved Research Task → RFC Prompt |
| G10 | Product lives in a **dedicated repository**; smtgit only stages research under `agb/` until extraction |

### 3.3 Non-goals

| Non-goal | Rationale |
|----------|-----------|
| Implement agb inside smtgit application/release | Maintainer product boundary |
| Ship smtgit CLI / product docs as part of pack | Wrong artifact |
| Auto-accept RFCs | Human authority (Spec `00`/`09`, RFC process) |
| Force identical docs trees on every project | RFC-DOC-001 non-goal |
| Bind to one Agent vendor | Ecosystem fragmentation |
| Have the tool itself write RFCs without Agent (MVP) | Tool emits prompts; Agent authors |

---

## 4. Current Repository Governance Asset Inventory

Surveyed: smtgit. agb consumes these as **content source**, not as runtime dependency.

### 4.1 Inventory (Verified)

| Asset | Path | Pack role |
|-------|------|-----------|
| Agent entry | `AGENTS.md` | Skeleton source |
| Rules 00–09 + README | `.agents/rules/` | **Core pack** (genericize path examples) |
| Spec 10 | `.agents/rules/10-smtgit-project-conventions.md` | **Overlay template only** |
| Templates | `.agents/templates/` | Core pack |
| Cursor entry | `.cursor/rules/agents-rules.mdc` | Optional adapter |
| RFC process | `RFCs/README.md`, `process.md`, `TEMPLATE.md`, status dirs | Core pack |
| RFC-DOC-001 | `RFCs/RFC-DOC-001-…` | **Example RFC retained and initialized** |
| Migration / reports | `docs/maintenance/*` | Example patterns + Spec `08` rules |
| Product docs / app / release CI | `docs/pull.md`, `smtgit.sh`, `shared/`, `.github/workflows/release.yml` | **Excluded from pack** |

### 4.2 Gaps vs product vision (Verified)

No Prompt Library, no workflows pack module, no manifest/lock, no install CLI in smtgit today. Staging drafts exist under [`agb/prompts/`](../../prompts/).

---

## 5. Existing Governance System Analysis

### 5.1 What RFC-DOC-001 produced (example system)

```text
AGENTS.md
  ├─ .agents/rules/00–09 (+ README)
  ├─ .agents/rules/10-<project>-conventions   ← project-specific in smtgit
  ├─ .agents/templates/
  ├─ RFCs/ process + TEMPLATE + example RFC-DOC-001
  └─ .cursor/rules/agents-rules.mdc (adapter)
```

### 5.2 Productization split

| Layer | Contents | Ships to targets |
|-------|----------|------------------|
| Core | Portable rules, RFC process, templates, workflows, prompts | Always |
| Example | RFC-DOC-001 + migration/report examples | Yes (labeled example) |
| Overlay | `10-<project>-conventions.md`, local AGENTS zones | Generated per target |
| Adapters | Cursor / Claude / Gemini / Copilot shims | Optional modules |
| Excluded | smtgit application & product command docs | Never |

---

## 6. External Ecosystem and Competitor Research

| Tool | Borrow | Limit |
|------|--------|-------|
| Copier | Three-way update, answers, conflicts | Not agent-knowledge aware |
| pre-commit | `repo` + `rev` pin / cache | Hooks ≠ governance content |
| Cookiecutter / GitHub templates | Greenfield snapshot | Weak migrate/upgrade |
| Yeoman | Conflict prompts | Poor long-term sync |
| AGENTS.md standard | Neutral entry file | No pack lifecycle |
| Claude / Codex / Gemini headless | Adapter feasibility | Vendor permission models differ |
| Copilot custom instructions | GitHub adapter target | Not an installer |

---

## 7. Product Requirements

| ID | Requirement | Priority |
|----|-------------|----------|
| FR1 | Dedicated agb repository hosts CLI + pack | P0 |
| FR2 | `agb init` installs RFC-DOC-001-derived governance system | P0 |
| FR3 | Include RFC-DOC-001 as example in init | P0 |
| FR4 | Generate project overlay; never install smtgit Spec `10` verbatim | P0 |
| FR5 | Scan / plan migrate / validate / backup | P0 |
| FR6 | Prompt-only migration kit with checksum lock | P0 |
| FR7 | **`agb research`:** idea → Research Task Prompt | P0 |
| FR8 | **`agb rfc`:** approved Research Task → RFC Prompt | P0 |
| FR9 | Optional `--agent` for init/migrate stages | P1 |
| FR10 | `agb update` three-way merge | P1 |
| FR11 | Full Prompt Library + workflows module | P1 |

Prompt features default to **emit prompt only**; optional `--agent` later.

---

## 8. Core User Journeys

### 8.1 Create agb product repo

```text
extract pack from smtgit RFC-DOC-001 outputs → new agb repo → version tags → publish CLI
```

### 8.2 Target init / migrate

```text
agb init | agb scan → plan migrate → apply → validate
```

### 8.3 Idea → Research Task → RFC

```text
agb research --idea ./idea.md
# Agent writes Research Task → human reviews
agb rfc --research ./tasks/research-task.md --i-approve-research
# Agent drafts RFC (Status: Draft) → Maintainer decides
```

---

## 9. Governance Resource Distribution Design

Future agb repo holds `pack/` SSOT with Git tags. smtgit `agb/` is research staging only until extraction. Target repos get `.agb/lock.yaml`.

Example module includes RFC-DOC-001 from smtgit `RFCs/`.

---

## 10–14. Scan, Migration, Adapters, Prompt-only, Lifecycle

Unchanged design core from prior research:

- Scanner → inventory → dispositions  
- Human-gated apply with backup / anti-loss  
- Optional Claude/Codex/Gemini adapters; emit-first for research/rfc  
- Prompt-only kits with checksum locks  
- Copier-like three-way update for managed files  

---

## 15. Best Practice Workflow Design

Requirement → **`agb research`** → review → **`agb rfc`** (if needed) → Maintainer → implement → docs sync. Long-term: `agb doctor` / `update --check`.

---

## 16. Prompt Template Library Design

Drafts staged:

- [`../../prompts/research-task.md`](../../prompts/research-task.md)
- [`../../prompts/rfc-from-research.md`](../../prompts/rfc-from-research.md)

Plus future bootstrap/migration/delivery/docs/lifecycle prompts in pack.

---

## 17. Technical Architecture

```text
smtgit (reference origin + agb/ staging)
        │ extract
        ▼
agb repository (NEW) — CLI + pack SSOT
        │ init/update/prompts
        ▼
Target Git repos  (+ optional Agent CLIs)
```

No agb implementation under `smtgit.sh` / `shared/`.

---

## 18–20. Data Model, Security, CLI

Target shape: `AGENTS.md`, `.agents/`, `RFCs/` (+ example RFC-DOC-001), `.agb/lock.yaml`.

```bash
agb init | scan | plan migrate | apply | validate | update | doctor
agb research [--idea ...] [--out ...]
agb rfc --research <file> --i-approve-research [...]
agb pack fetch | pack emit --prompt-only
```

Security: emit-only defaults; rfc approval gate; checksums; backup before apply; never auto-Accept RFCs.

---

## 21. MVP Scope

In: dedicated repo plan, pack from RFC-DOC-001 outputs, `init`/`validate`/`research`/`rfc`/`pack emit`, migration plan.

Out: implementing inside smtgit app; full auto-apply; three-way update; multi-adapter parity; auto Agent for research/rfc without flag.

---

## 22. Phased Roadmap

| Phase | Goal |
|-------|------|
| 0 | Extract pack; create agb repo; genericize rules |
| 1 | MVP CLI |
| 2 | Migration closed loop |
| 3 | Full Prompt Library |
| 4 | Update engine |
| 5 | Multi-adapter + releases |

---

## 23. Risks and Open Questions

Pack contamination with smtgit Spec `10`; example RFC misread as Accepted; unreviewed research fed to `rfc`; license/remote for agb repo.

---

## 24. Final Recommendations

1. Build agb as a **new repository**; keep smtgit `agb/` as staging only.  
2. Init installs RFC-DOC-001 governance outputs + example RFC.  
3. CLI name **`agb`** with `research` / `rfc` emit-first.  
4. MVP = init + validate + research + rfc + pack emit + migration plan.  
5. Next: Phase 0 extraction after Maintainer go-ahead.

---

## Appendix A — Note on withdrawn home-directory move

An incomplete attempt to relocate staging to `/home/lma/agb` was **withdrawn**. Canonical staging remains **`/home/lma/smtgit/agb/`** until Maintainers decide otherwise.

---

*End of research report (restored after withdrawn task).*

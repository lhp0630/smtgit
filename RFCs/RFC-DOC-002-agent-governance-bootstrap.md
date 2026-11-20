# RFC: Agent Governance Bootstrap Tool (agb)

- **RFC ID:** RFC-DOC-002
- **Title:** Agent Governance Bootstrap Tool (agb)
- **Status:** Draft
- **Type:** Process / Documentation Architecture / Product Boundary
- **Authors:** Project Maintainers (drafted by AI agent from research; revised after architecture/governance review)
- **Created:** 2026-11-19
- **Updated:** 2026-11-19
- **Supersedes:** N/A
- **Superseded by:** N/A
- **Related research:** [`../agb/docs/research/repository-governance-bootstrap-tool-research.md`](../agb/docs/research/repository-governance-bootstrap-tool-research.md)
- **Related RFC:** [`accepted/RFC-DOC-001-documentation-governance-bootstrap.md`](accepted/RFC-DOC-001-documentation-governance-bootstrap.md) (Status: **Accepted** in smtgit — governance policy baseline for portable Core; target Examples remain non-sequence copies)

---

## Review-finding map (this revision)

| Finding | Addressed in |
|---------|----------------|
| P0-1 DOC-001 dependency / authority | §6.1, §7.2, Appendix A |
| P0-2 Research→RFC approval workflow | §7.5 |
| P0-3 Pack architecture (semantic classes) | §7.3 |
| P0-4 Manifest / compatibility contract | §7.4 |
| P0-5 Migration transaction / recovery | §7.7 |
| P0-6 Prompt-only distribution mode | §7.8 |
| Governance operating model | §7.9 |
| RFC status alignment | §7.5.4, §7.10 |
| MVP vs later phases | §7.11–§7.12 |
| Trust boundaries | §11 |
| Command responsibilities | §7.6 |
| Three-way merge (future) | §7.13 |
| Blocking vs deferred decisions | §15 |

---

## 1. Summary

This RFC proposes creating **agb** (agent governance bootstrap): a **dedicated product and repository** that maintains a versioned **Governance Pack** and a local CLI to install, migrate, validate, and operate an agent collaboration + documentation governance system in arbitrary Git repositories.

agb is **not** a smtgit subcommand and MUST NOT be implemented under `smtgit.sh` / `shared/`. smtgit remains the **reference origin** of portable governance *assets* and a temporary research staging tree under `agb/`; after extraction, the Governance Pack SSOT lives in the agb repository.

agb MUST also provide emit-first prompt features that support a strict Research→RFC workflow, and a **Prompt-only** distribution mode that does not require an installed Agent CLI or a continuously running agb process on the operator’s machine beyond kit emission / offline pack acquisition.

**This Draft RFC does not authorize implementation.** Implementation may proceed only after a human Maintainer sets Status to `Accepted` (then typically `In Progress` / `Implemented` per [`process.md`](process.md)).

---

## 2. Context and problem statement

### 2.1 Current situation (smtgit) — Verified

- A working agent-neutral governance system exists: `AGENTS.md`, `.agents/rules/` (00–10), `.agents/templates/`, `RFCs/` process and templates, `.cursor/rules/agents-rules.mdc`, maintenance records under `docs/maintenance/`, and research convention under `docs/research/`.
- That system was produced in connection with **RFC-DOC-001**, now **Accepted** (2026-11-19) and filed under `RFCs/accepted/`.
- Spec `10` encodes **smtgit-specific** product contracts (`.agents/rules/10-smtgit-project-conventions.md`).
- Release packaging ships `smtgit.sh`, `shared/`, `docs/`, `README.md`, `AGENTS.md` only — not `RFCs/` or `.agents/rules/` (`.github/workflows/release.yml`).
- Productization research and draft prompts stage under [`agb/`](../agb/README.md).

### 2.2 Problem

1. Governance assets are locked inside one application repository.
2. Blind copy installs product-specific rules and lacks versioning, migration, and upgrade semantics.
3. Target repos often already have agent/docs/decision files requiring safe merge.
4. Idea → research → RFC paths are underspecified; prompts, reports, and RFCs are easy to conflate.
5. Implementing agb inside smtgit would couple an unrelated product to a bash `git pull` utility.

---

## 3. Motivation

- Reuse a coherent governance model without hand-copying smtgit.
- Make adoption safe via scan / immutable plan / human gate / backup / validate / audit.
- Operationalize Research Report → RFC practice without weakening Maintainer authority.
- Keep smtgit focused on batch `git pull`; grow agb on its own release train.

**Affected parties:** Maintainers (authority, license, remotes); adopters in other repos; AI agents consuming installed rules and prompts.

---

## 4. Goals

1. Authorize (upon Accept) a **new repository** for the agb CLI and Governance Pack SSOT.
2. Define pack content by **semantic portability classes**, derived from portable assets whose *provenance* includes work done under Accepted RFC-DOC-001 (smtgit policy baseline), without auto-Accepting example copies inside foreign target repos.
3. Ship **Core Governance** that includes the decision-document triad: `RFCs/` · `docs/research/` · `docs/maintenance/reports/` (roles defined in living smtgit docs; pack MUST preserve those roles).
4. Require **Project Overlay** generation for target-specific conventions; forbid shipping smtgit Spec `10` verbatim into foreign repos.
5. Make **Examples** (including packaged RFC-DOC-001 text) **opt-in**, isolated from the target’s active RFC sequence.
6. Specify CLI responsibilities for `init`, `scan`, `plan migrate`, `apply`, `validate`, `update`, `doctor`, `rollback`, and pack/prompt commands.
7. Specify emit-first **`agb research`** and **`agb rfc`** with an unambiguous Research→RFC approval workflow.
8. Specify **Prompt-only** as an independent distribution mode with lock, integrity, stages, resume, and final report.
9. Keep smtgit `agb/` as staging until extraction; authorize **no** change to smtgit pull semantics by this RFC alone.
10. Preserve human Maintainer authority over RFC acceptance everywhere.

---

## 5. Non-goals

1. Implementing agb inside smtgit application code or smtgit GitHub Release archives (unless a later Maintainer-approved RFC says otherwise).
2. Shipping smtgit CLI, `shared/`, or product command docs (`docs/pull.md`, `docs/release.md`) in the Governance Pack.
3. Auto-accepting RFCs or replacing human Maintainer authority.
4. Treating an **Examples** install of RFC-DOC-001 text inside a foreign target repo as that target’s Accepted policy (target Accept remains local/Maintainer-owned).
5. Forcing identical documentation trees beyond the Core Governance contracts.
6. Binding agb to a single Agent vendor.
7. MVP requiring full automatic migration apply, three-way `update`, or multi-adapter parity.
8. Default path where the tool itself authors Research Reports or RFCs without an Agent (emit prompts; Agents author).
9. Re-litigating RFC-DOC-001’s smtgit Accept via this RFC (DOC-001 is already Accepted independently).

---

## 6. Constraints and assumptions

### 6.1 Provenance and authority (P0-1) — Design proposal

Distinguish three layers:

| Layer | Meaning | Authority |
|-------|---------|-----------|
| **Source repository** | smtgit (today): reference host of governance *files* and staging under `agb/` | Living rules for smtgit itself |
| **Governance Pack** | Versioned, checksummed artifact maintained in the **agb** repository after extraction | Pack manifest + agb Maintainer releases |
| **Example RFC artifact** | Packaged copy of RFC-DOC-001 text (and similar) under Examples | Illustrative only; **not** policy in target repos |

**Normative:**

1. RFC-DOC-001 is **Accepted** in smtgit (Verified after Maintainer filing on 2026-11-19). That Accept is the policy baseline for the living governance system *in smtgit*.
2. Installing a packaged **Examples** copy of RFC-DOC-001 into a foreign target does **not** by itself Accept that RFC for the target; Examples stay out of the target’s active sequence unless the target’s Maintainers decide otherwise.
3. Pack Core Governance (portable rules + process + triad) is derived from the Accepted DOC-001 system after genericization. Accepting **this** RFC (DOC-002) authorizes agb productization; it does not re-open DOC-001.
4. Each pack resource MUST record provenance metadata (source path/commit or equivalent) in the manifest (see §7.4).
5. **Public stable pack baseline:** with DOC-001 Accepted, portable Core MAY be advertised as aligned to that Accepted governance system once genericization is verified. Product decisions that remain blocking are license/remote/Examples defaults (§15), not DOC-001’s Status.

### 6.2 Other constraints

1. Only human Maintainers may Accept this RFC or Accept RFCs in target repos.
2. Emit-first `research` / `rfc` remains the MVP default; `--agent` execution is optional and later.
3. External patterns are advisory: Copier-like three-way merge; pre-commit-like `ref` pins; vendor headless CLIs for adapters.

---

## 7. Proposed design

### 7.1 Product boundary — Preserved decision

```text
smtgit (reference origin + agb/ research staging)
        │  extract (only after DOC-002 Accepted → Phase 0)
        ▼
agb repository (NEW) — CLI + pack SSOT + releases
        │  init / migrate / prompts / update / Prompt-only kits
        ▼
Target Git repositories (+ optional user Agent CLIs)
```

- MUST NOT add agb commands to `smtgit.sh`.
- MUST NOT treat smtgit `shared/` as agb libraries.
- After extraction, Governance Pack SSOT is maintained in the agb repository.

### 7.2 Asset provenance model (P0-1)

| Asset kind | Example | Pack handling |
|------------|---------|---------------|
| Portable process/rules | Genericized specs formerly 00–09, RFC process, research/maintenance conventions | Core Governance (after genericization) |
| Product-specific contracts | smtgit Spec `10`, `docs/pull.md`, `smtgit.sh` | **Excluded** from pack |
| Historical proposal text | RFC-DOC-001 Markdown | Examples module only; Status field preserved as in source copy; not active sequence |
| Staging prompts | `agb/prompts/*` | Seed Prompt Library (rewritten/versioned in pack) |

### 7.3 Governance Pack architecture (P0-3) — semantic classes

Classify by **portability semantics**, not by original numeric filenames.

| Class | Role | Default on `init` | Editable by user |
|-------|------|-------------------|------------------|
| **Core Governance** | Agent entry skeleton zones, portable rules, RFC process/TEMPLATE, `docs/research/` convention, `docs/maintenance/reports/` retention rules, shared doc templates needed for the triad | **On** | Managed zones discouraged; overlays for project facts |
| **Workflow** | Operating playbooks (init→operate→update cadence) | **On** (minimal MVP set) | May extend locally |
| **Prompt Library** | Versioned prompts including research/rfc/migration | **On** (MVP subset) | Local additions allowed; managed prompts merge on update |
| **Project Overlay** | Generated target conventions (`*-project-conventions`), local AGENTS user zones | **Generated** | Expected |
| **Agent Adapter** | Cursor / Claude / Gemini / Copilot shims | **Opt-in** (Cursor MAY default on — open question) | Thin shims |
| **Examples** | Packaged RFC-DOC-001 text, sample migration/report exemplars | **Off** (`--with-examples`) | Read-only preference |
| **Product-specific exclusions** | Any application CLI/product docs from source repos | **Never installed** | N/A |

**Examples isolation (normative):**

1. Example RFCs MUST install under `RFCs/examples/` (or equivalent non-sequence path), **not** as `RFCs/RFC-<AREA>-<NNN>-…` competing with the target’s active numbering.
2. Example files MUST be labeled as examples in filename and/or header banner.
3. `agb validate` MUST fail if an Examples-class file is placed into the active RFC sequence path without an explicit dangerous override (post-MVP enforcement; MVP SHOULD at least document and plan-check this).

Detail inventory (staging, not normative pack layout yet): [`../agb/examples/rfc-doc-001-deliverables.md`](../agb/examples/rfc-doc-001-deliverables.md) — to be updated during Phase 0 to match semantic classes.

### 7.4 Pack manifest and compatibility contract (P0-4)

**Design proposal** — illustrative schema (not an implemented file in smtgit today):

```yaml
# pack/manifest.yaml  (design example)
manifest_schema_version: "1"
pack_id: "org.agb.governance-core"
pack_version: "0.1.0"          # pack semver
min_cli_version: "0.1.0"       # lowest agb CLI that may install this pack
max_cli_version: null          # optional upper bound
created_at: "2026-11-19T00:00:00Z"
license: "TBD"                 # blocking product decision

modules:
  core_governance: { required: true }
  workflow: { required: true }
  prompt_library: { required: true }
  project_overlay: { required: true }
  agent_adapter_cursor: { required: false, default: true }
  agent_adapter_claude: { required: false, default: false }
  agent_adapter_gemini: { required: false, default: false }
  agent_adapter_copilot: { required: false, default: false }
  examples: { required: false, default: false }

dependencies:
  # module -> modules that must be present
  workflow: [core_governance]
  prompt_library: [core_governance]
  project_overlay: [core_governance]
  agent_adapter_cursor: [core_governance]
  examples: [core_governance]

integrity:
  checksums_file: "checksums.sha256"
  # optional later: sigstore / git tag signature policy

provenance:
  reference_origin: "smtgit"
  reference_commit: "TBD-at-extract"
    note: >
      Portable files derived from governance assets hosted in the reference
      origin; RFC-DOC-001 is Accepted in that origin (2026-11-19).

deprecations: []
  # - { path: "...", since: "0.2.0", remove_after: "0.4.0", replacement: "..." }

resources:
  - id: "core.rules.maintainer_principles"
    class: core_governance
    path: "core/rules/00-maintainer-principles.md"
    provenance_path: ".agents/rules/00-maintainer-principles.md"
  - id: "examples.rfc_doc_001"
    class: examples
    path: "examples/RFCs/RFC-DOC-001-documentation-governance-bootstrap.md"
    provenance_path: "RFCs/RFC-DOC-001-documentation-governance-bootstrap.md"
```

**Target lockfile** (design example):

```yaml
# .agb/lock.yaml
manifest_schema_version: "1"
pack_id: "org.agb.governance-core"
pack_version: "0.1.0"
source: "https://example.invalid/agb"   # TBD
ref: "pack/v0.1.0"
resolved_commit: "abc123…"
checksum_sha256: "…"
cli_version_used: "0.1.0"
modules: [core_governance, workflow, prompt_library, project_overlay]
examples_installed: false
installed_at: "2026-11-19T12:00:00Z"
```

**Version pinning:** installs and kits MUST pin `pack_version` + content checksum (and SHOULD pin VCS `ref`/commit). Floating `main` without pin is forbidden for non-dev installs.

**Deprecation policy:** pack MAY mark resources deprecated with `since` / `remove_after`; `update` MUST surface removals; deleting managed files in targets requires plan acknowledgment.

### 7.5 Research → RFC workflow (P0-2)

#### 7.5.1 Canonical pipeline

```text
Idea
  → Research Task Prompt          # agb research (emit)
  → Research Report               # Agent authors; human owns file under docs/research/
  → Human Research Review         # recorded review evidence
  → RFC Authoring Prompt          # agb rfc (emit)
  → Draft RFC                     # Agent authors; Status=Draft
  → Human RFC Review              # Proposed / In Review
  → Accepted RFC                  # Maintainer only
```

#### 7.5.2 Term distinctions (normative)

| Artifact | Is | Is not |
|----------|----|--------|
| **Research Task Prompt** | Instructions for an Agent to produce a Research Report | A Research Report; an RFC |
| **Research Report** | Evidence/options document under `docs/research/` | An RFC; Maintainer acceptance |
| **Research review** | Human attestation that a Research Report is adequate to draft an RFC | RFC acceptance |
| **RFC Authoring Prompt** | Instructions for an Agent to draft an RFC | An RFC |
| **Draft RFC** | Proposal under `RFCs/` with Status `Draft` | Accepted policy |
| **Accepted RFC** | Maintainer-set Status `Accepted` | Something Agents may set |

Agents MAY author and revise Research Reports and RFCs. Agents MUST NOT approve research reviews or Accept/Reject/Defer/Implement/Supersede RFCs.

#### 7.5.3 Research review evidence (replaces `--i-approve-research`)

Ambiguous flag `--i-approve-research` is **rejected** by this revision.

`agb rfc` MUST require machine-checkable evidence that a **named human** reviewed a **specific** Research Report revision, for example:

```yaml
# docs/research/<topic>.review.yaml  (design example)
schema_version: "1"
research_report_path: "docs/research/my-topic-research.md"
research_report_sha256: "…"
reviewed_at: "2026-11-19T15:00:00Z"
reviewed_by: "alice@example.com"    # or Maintainer handle
decision: "approve_for_rfc"         # or "reject" | "revise"
notes_path: "docs/research/my-topic-research.review-notes.md"  # optional
```

CLI sketch:

```bash
agb research --idea ./idea.md --out ./prompts/research.prompt.md
# human runs Agent → writes docs/research/….md
# human writes review YAML (or `agb research record-review` helper — post-MVP OK)

agb rfc --research-report docs/research/my-topic-research.md \
  --research-review docs/research/my-topic.review.yaml \
  --out ./prompts/rfc.prompt.md
```

`agb rfc` MUST verify `research_report_sha256` matches the file bytes and `decision` is `approve_for_rfc`. A bare boolean CLI flag without binding identity + checksum is insufficient.

#### 7.5.4 Alignment with RFC process statuses

Installed / generated RFCs follow [`process.md`](process.md):

`Draft` → `Proposed`/`In Review` → `Accepted` → `In Progress` → `Implemented` (or `Rejected` / `Deferred` / later `Superseded`).

Only human Maintainers may set `Accepted`, `Rejected`, `Deferred`, `Implemented`, or `Superseded`. Emitted RFC prompts MUST state this. Initial Agent output MUST use `Draft` unless a human explicitly requested `Proposed` **and** local process allows authors (not Agents alone) to advance to Proposed.

### 7.6 Command responsibilities

| Command | Responsibility | Writes repo? | MVP |
|---------|----------------|--------------|-----|
| `init` | Install selected pack modules into a repo; create overlay + lockfile | Yes (managed paths) | Yes |
| `scan` | Inventory agent/docs/RFC/ADR/CI/stack signals → `inventory` artifact | Report only (default) | Yes |
| `plan migrate` | Build **immutable** migration plan from inventory + pack | Plan/state under `.agb/` | Yes |
| `apply` | Execute an **approved** plan transactionally | Yes | Phase 2 (MVP: dry-run/docs OK) |
| `validate` | Check pack completeness, triad paths, lock, anti-loss, example isolation | Report; may write validation report | Yes |
| `update` | Detect upstream pack delta; three-way merge managed files | Yes | Phase 4 |
| `doctor` | Health/drift diagnostics vs lock + manifest | Report | Phase 4 |
| `rollback` | Restore from named backup / transaction | Yes | Phase 2+ |
| `research` | Emit Research Task Prompt | Optional `--out` only | Yes |
| `rfc` | Emit RFC Authoring Prompt if research review evidence valid | Optional `--out` only | Yes |
| `pack fetch` | Download/verify pin to cache | Cache only | Yes |
| `pack emit --prompt-only` | Emit Prompt-only kit for a pinned pack version | Kit directory | Yes |

`plan migrate` **never** mutates governance content trees. `apply` **only** runs against a plan that is approved and whose checksum still matches.

### 7.7 Migration transaction and recovery (P0-5)

**Design proposal** for apply-capable phases:

1. **Immutable plan:** `plan migrate` writes `plan.json` (or YAML) including dispositions, file ops, pack version, inventory hash, and `plan_sha256`.
2. **Approval:** human records approval (signature file or CLI `agb plan approve --plan …` binding identity + plan hash). Unapproved plans MUST NOT apply.
3. **State machine:** e.g. `PLANNED` → `APPROVED` → `BACKING_UP` → `APPLYING` → `VALIDATING` → `COMPLETED` | `FAILED` | `ROLLED_BACK`.
4. **Step tracking:** each op id logged with status; apply is **idempotent** where possible (skip completed ops with matching checksums).
5. **Resume:** interrupted apply resumes from state + audit log; MUST refuse if worktree diverged unexpectedly (`stale` detection).
6. **Stale-plan detection:** if inventory hash, pack pin, or touched-file digests diverge from plan assumptions, state → `STALE_PLAN`; require new plan.
7. **Backup:** before first mutating op, snapshot all paths the plan may touch under `.agb/backups/<txn_id>/`.
8. **Rollback:** `rollback --backup <txn_id>` restores snapshot; audit log retained.
9. **Audit log:** append-only `.agb/audit/<txn_id>.jsonl` with timestamps, op ids, results.

Relationship: **`plan migrate` produces; `apply` consumes**. No implicit apply from plan.

### 7.8 Prompt-only distribution mode (P0-6)

Prompt-only is an **independent distribution mode**, not a degraded footnote of `--agent none`.

**Ways to obtain a kit:**

| Mode | How | Requires local agb CLI at apply time? |
|------|-----|----------------------------------------|
| Online emit | Operator with agb runs `agb pack emit --prompt-only --version vX` | No (kit is portable) |
| Offline emit | Same using `pack fetch` cache / vendored pack tarball | No |
| Prebuilt kit | Maintainer-published kit artifact for `pack_version` | No |

**Kit MUST contain:**

- `lock.yaml` / pack pin (`pack_version`, ref, checksums)
- Vendored pack **or** exact download URLs + checksums
- Staged prompts (`00-fetch-verify` … `N-validate-report`)
- Schemas for inventory/plan/report
- `state.yaml` template for resume
- Human README describing stages and human gates

**Closed loop without Agent CLI integration and without keeping agb running:**

1. Obtain kit (emitted earlier or downloaded).
2. Human (or any Agent UI) executes staged prompts in order.
3. Stage 0 verifies pack integrity from lock (Agent or human checksum tool).
4. Stages produce inventory → plan → **human approves plan** → apply steps → validate → migration report under `docs/maintenance/reports/`.
5. `state.yaml` allows pause/resume across sessions.

If agb CLI is unavailable during migration, Prompt-only still works; if available, CLI MAY validate the same artifacts (`agb validate --from-kit`).

### 7.9 Governance operating model (post-install)

After successful init/migrate, adopters operate the triad:

| Cadence | Activity |
|---------|----------|
| New idea | `agb research` → Research Report in `docs/research/` → human research review |
| Design decision | `agb rfc` → Draft RFC → Maintainer Accept per process |
| Implementation of Accepted RFC | Code/docs changes; implementation report in `docs/maintenance/reports/` when significant |
| Pack upkeep | `agb update --check` / `doctor` (Phase 4+) |
| Quality | Documentation consistency prompts; anti-drift vs overlay |

Installed Core Governance MUST document these roles consistently with [`../docs/research/README.md`](../docs/research/README.md).

### 7.10 This RFC’s own status transitions

For **RFC-DOC-002** itself, follow [`process.md`](process.md):

- Now: `Draft`
- Maintainer moves to `Proposed`/`In Review` when ready for decision
- Only Maintainer may `Accepted` / `Rejected` / `Deferred`
- After Accept: implementation → `In Progress` → `Implemented`

Agents revising this file MUST leave Status as set by humans.

### 7.11 Phased delivery

| Phase | Scope | Notes |
|-------|--------|-------|
| 0 | Create agb repo; extract/genericize pack; manifest; Examples module off by default | Draft pack OK before public stable policy baseline (§6.1.5) |
| 1 **MVP** | `init` (no examples by default), `scan`, `plan migrate`, `validate`, `research`, `rfc` (review YAML gate), `pack fetch`, `pack emit --prompt-only` | **No** full `apply` requirement |
| 2 | `apply` transaction model + backup/rollback/audit + one optional Adapter | |
| 3 | Full Prompt Library + Workflow module expansion | |
| 4 | `update` three-way merge + `doctor` | |
| 5 | Multi-adapter + signed release polish | |

### 7.12 MVP success criteria (tightened)

1. Empty foreign repo: `agb init` → `validate` green; Core triad paths present; overlay present; **Examples absent** unless `--with-examples`; no smtgit Spec `10` text.
2. `agb research` emits a Research Task Prompt; `agb rfc` refuses without valid research review evidence; succeeds with valid review YAML + matching checksum.
3. `pack emit --prompt-only` produces a kit with pin + checksums + staged prompts + state template.
4. `plan migrate` on a fixture with existing `AGENTS.md` yields disposition coverage for inventoried agent files (anti-loss).
5. smtgit `bash smtgit.sh help` / `help pull` still succeed; no smtgit app changes required by this RFC.

### 7.13 Three-way merge concepts (Phase 4 commitment)

For managed files on `update`:

1. Reconstruct “clean pack at old version”.
2. Diff clean-old → current target (user evolution).
3. Generate clean-new from new pack version.
4. Apply user evolution onto clean-new; conflicts → inline markers or `.rej` (configurable).
5. Never overwrite Project Overlay or user zones without merge.
6. Examples updates MUST NOT move files into the active RFC sequence.

Exact algorithm may follow Copier’s approach; this RFC freezes the *contract*, not the implementation code.

---

## 8. Alternatives considered

| Alternative | Summary | Why not chosen |
|-------------|---------|----------------|
| A. agb as smtgit subcommands | Convenience | Couples unrelated products — **preserved rejection** |
| B. GitHub Template of smtgit | Snapshot | Ships app code; no migrate/upgrade |
| C. Cookiecutter only | Generate | Weak ongoing update |
| D. Copier alone | File updates | Needed later for upgrades; insufficient for knowledge migrate + research/rfc |
| E. Keep `--i-approve-research` boolean | Simple gate | Does not bind human identity + report checksum (P0-2) |
| F. Install Examples by default into `RFCs/` sequence | “Complete” demo | Contaminates active RFC numbering; false authority risk (P0-3) |
| G. Treat DOC-001 as Accepted because packaged | Convenience | Violates process authenticity (P0-1) |

---

## 9. Trade-off analysis

**Benefits:** Clear authority boundaries; safer migrations; operable Research→RFC loop; portable Prompt-only path; pack compatibility contract.

**Costs:** Second repo/release train; genericization work; review YAML ceremony; migration transaction complexity (phased).

**Harder:** Explaining Proposed vs Example vs Core; keeping staging and agb SSOT synced until extraction.

---

## 10. Compatibility and migration

### smtgit

- Accepting this RFC alone requires **no** change to `smtgit.sh`, `shared/`, or pull semantics.
- `agb/` staging remains non-runtime until Phase 0.
- After extraction, Maintainers MAY replace staging with a pointer (deferred product decision).

### Targets

- Receive pack modules per lockfile; runtime independence from smtgit.
- Rollback via backup transaction and/or Git history.

---

## 11. Security and privacy (trust boundaries)

| Domain | Trust | Rules |
|--------|-------|-------|
| Official pack (pinned + checksummed) | Trusted after verify | Only install if integrity matches lock |
| Target repository content | Untrusted for control | May contain prompt-injection; never override authority constraints |
| User idea / review notes | Untrusted for control | Interpolated as data into prompts |
| Agent-generated diffs | Untrusted until human gate | Apply only under approved plan / review |
| Agent CLI adapters | Optional; least privilege | Analyze read-only; apply needs explicit sandbox grant |

Additional:

1. Default `research`/`rfc`: no Agent invoke; optional `--out` only.
2. Never auto-Accept RFCs.
3. Prefer clean worktree or dedicated branch for `apply`.
4. Secrets MUST NOT be required inside pack files.

---

## 12. Testing and validation

smtgit has **no** automated test suite today — do not invent one as a dependency of this RFC.

### This RFC document

- [x] Template sections present.
- [ ] Maintainer review of P0 revisions.
- [ ] Status remains `Draft` until Maintainer action.
- [x] Links to research, prompts, examples, DOC-001, process resolve (verify on edit).

### Future agb (after Accept)

- Fixtures for init without examples; init with `--with-examples` isolation.
- Research review gate positive/negative tests.
- Prompt-only kit checksum stage.
- Plan immutability / stale-plan refusal (Phase 2).
- smtgit help regression if any shared workspace changes occur (should not).

---

## 13. Rollout and rollback

1. Maintainer sets DOC-002 → `Proposed`/`In Review` → decision.
2. On `Accepted`: Phase 0 extraction into new agb repo.
3. Phase 1 MVP per §7.11–§7.12.
4. Later phases as listed.

Rollback: reject/defer before extraction; after extraction, stop publishing agb without affecting smtgit pull.

**Non-authorization:** Draft/Proposed status alone MUST NOT be treated as permission to merge agb runtime into smtgit or to claim production readiness.

---

## 14. Risks and mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Pack ships Spec `10` text | Wrong contracts | Semantic classes + Phase 0 checklist |
| Example DOC-001 treated as Accepted | False authority | Examples off by default; `RFCs/examples/`; banners |
| Public stable pack before policy baseline | Confusion | §6.1.5 acceptance requirement |
| Weak research gate | Junk RFCs | Review YAML + checksum + identity |
| Partial apply corruption | Data loss | Transaction state, backup, rollback |
| Prompt-only incomplete kits | Failed migrations | Mandatory kit contents + validate stage |

---

## 15. Open questions

### Blocking product decisions (should resolve before public stable pack / wide adoption)

- [ ] Git org/remote for the agb repository?
- [ ] License for CLI + Governance Pack?
- [ ] Confirm Examples default **off** and path `RFCs/examples/`?
- [ ] Confirm portable Core genericization checklist against Accepted DOC-001 deliverables?

### Deferred implementation decisions (non-blocking for Accepting this RFC’s product shape)

- [ ] CLI language (Go vs Python)?
- [ ] Exact Adapter defaults (Cursor on vs all off)?
- [ ] Whether `agb research record-review` helper ships in Phase 1 or review YAML is hand-written?
- [ ] After extraction: pointer vs delete vs mirror for `smtgit/agb/`?
- [ ] Conflict UX default for three-way merge (`inline` vs `rej`)?
- [ ] Signing technology for pack tags?

---

## 16. References

### In-repository (Verified paths)

- [`../agb/docs/research/repository-governance-bootstrap-tool-research.md`](../agb/docs/research/repository-governance-bootstrap-tool-research.md)
- [`../docs/research/README.md`](../docs/research/README.md) — triad convention
- [`../agb/docs/research/README.md`](../agb/docs/research/README.md)
- [`../agb/README.md`](../agb/README.md)
- [`../agb/examples/rfc-doc-001-deliverables.md`](../agb/examples/rfc-doc-001-deliverables.md)
- [`../agb/prompts/research-task.md`](../agb/prompts/research-task.md)
- [`../agb/prompts/rfc-from-research.md`](../agb/prompts/rfc-from-research.md)
- [`accepted/RFC-DOC-001-documentation-governance-bootstrap.md`](accepted/RFC-DOC-001-documentation-governance-bootstrap.md)
- [`process.md`](process.md), [`TEMPLATE.md`](TEMPLATE.md), [`README.md`](README.md)
- [`../.agents/rules/00-maintainer-principles.md`](../.agents/rules/00-maintainer-principles.md)
- [`../.agents/rules/05-documentation-architecture.md`](../.agents/rules/05-documentation-architecture.md)
- [`../.agents/rules/08-document-lifecycle.md`](../.agents/rules/08-document-lifecycle.md)
- [`../.agents/rules/09-community-governance.md`](../.agents/rules/09-community-governance.md)
- [`../.agents/rules/10-smtgit-project-conventions.md`](../.agents/rules/10-smtgit-project-conventions.md)

### External (advisory)

- [AGENTS.md](https://agents.md/)
- [Copier updating](https://copier.readthedocs.io/en/stable/updating/)
- [pre-commit](https://pre-commit.com/)

---

## Appendix A — RFC-DOC-001 relationship (normative summary)

| Topic | Rule |
|-------|------|
| DOC-001 Status today | **Accepted** (2026-11-19); filed under `RFCs/accepted/` |
| DOC-002 Accepts DOC-001? | N/A — DOC-001 already Accepted independently |
| Pack may include DOC-001 text? | Yes, as **Examples**, opt-in, non-sequence path |
| Examples install Accepts DOC-001 in a foreign target? | **No** (unless that target’s Maintainers Accept) |
| Core Governance authority | Portable pack Core derived from Accepted DOC-001 system + agb release process |

---

## Appendix B — Preserved product decisions

This revision **preserves**:

1. agb is an independent repository/product.  
2. agb is not a smtgit subcommand.  
3. smtgit remains reference origin + staging until extraction.  
4. Pack SSOT lives in agb repo after extraction.  
5. Maintainers retain RFC approval authority.  
6. MVP uses emit-first prompt generation.  
7. Automatic Agent CLI execution is optional.  
8. Full migration automation and three-way upgrades are phased.  
9. This RFC alone does not change smtgit pull semantics.

**Apparent tension resolved:** research/examples texts that said “init installs RFC-DOC-001 example by default” conflict with P0-3. This RFC **keeps** the independent-product decisions and **changes** only the Examples default to **opt-in**, explaining the conflict rather than silently keeping both.

---

*End of Draft RFC-DOC-002 (architecture/governance review revision). Not Maintainer approval. Not implementation authorization.*

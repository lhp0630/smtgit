# RFC-DOC-001 Deliverables → agb Pack / Init Mapping

- **Source RFC:** [`../../RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md`](../../RFCs/accepted/RFC-DOC-001-documentation-governance-bootstrap.md) (Status: **Accepted** in smtgit; pack Examples still install as non-sequence examples in targets)
- **Purpose:** Define what “complete RFC-DOC-001 outputs” means for the future `agb` pack and for `agb init` into target repositories
- **Kind:** Design inventory (not Maintainer acceptance)

## 1. Principle

`agb` initializes target repositories with the **governance system produced under RFC-DOC-001**, not with smtgit’s application code (`smtgit.sh`, `shared/`, product `docs/pull.md`, etc.).

smtgit’s tree is the **reference implementation / example host**. The pack ships a **portable extraction** of that governance system, plus:

1. The RFC-DOC-001 document itself as an **example RFC** (process illustration).
2. A **project overlay slot** replacing smtgit-specific Spec `10`.

## 2. Deliverable map

| RFC-DOC-001 intent | smtgit path today | Pack class | Init into target repo? |
|--------------------|-------------------|------------|------------------------|
| Agent entry | `AGENTS.md` | Templated skeleton + merge zones | Yes (rendered) |
| Rules specs 00–09 | `.agents/rules/00`–`09` + `README.md` | Managed core (genericized) | Yes |
| Project conventions | `.agents/rules/10-smtgit-project-conventions.md` | Overlay template only | Yes as `10-<project>-conventions.md` (generated), **not** smtgit text |
| Doc templates | `.agents/templates/*` | Managed | Yes |
| Cursor load entry | `.cursor/rules/agents-rules.mdc` | Optional adapter | Yes if module enabled |
| RFC process | `RFCs/README.md`, `process.md`, `TEMPLATE.md`, status dirs | Managed | Yes |
| Bootstrap RFC (example) | `RFCs/RFC-DOC-001-…` | Example / historical | **Yes** — ship as example under `RFCs/examples/` or `RFCs/` with clear **example** labeling; do not mark Accepted |
| Migration record pattern | `docs/maintenance/agents-md-migration.md` | Example + workflow guidance | Yes as example under pack `examples/` and/or `docs/maintenance/examples/` |
| Implementation report pattern | `docs/maintenance/reports/*` | Example pattern | Optional example; retention **rule** ships in Spec `08` |
| Product docs | `docs/pull.md`, `docs/release.md` | **Out of pack** | No |
| Application / CI | `smtgit.sh`, `shared/`, `.github/workflows/release.yml` | **Out of pack** | No |

## 3. What “一同初始化” means for users

After `agb init` (or Agent-assisted migrate), a target repo SHOULD contain:

1. A runnable agent-neutral governance system (entry + rules + RFC process + templates).
2. Vendor adapter shim(s) as selected.
3. An empty or skeleton project overlay for local conventions.
4. RFC-DOC-001 (or a packaged copy) as a **worked example** of a documentation-governance RFC and its outcomes.
5. `.agb/lock.yaml` (or equivalent) recording pack version.

It MUST NOT contain smtgit CLI semantics unless the target project is smtgit itself.

## 4. Extraction notes for the future agb repository

When creating the dedicated `agb` repo:

1. Copy portable governance files from smtgit into `pack/` (or `governance-pack/`).
2. Rewrite Spec paths that hard-code smtgit product names.
3. Keep RFC-DOC-001 verbatim as an Examples-module artifact for targets (do not place it in the target’s active RFC sequence; target Accept is independent).
4. Replace Spec `10` with `overlays/project-conventions.template.md`.
5. Add Prompt Library including Research Task and RFC generation prompts (see `../prompts/`).

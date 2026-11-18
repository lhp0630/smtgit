# Implementation Report: RFC-DOC-001 Documentation Governance Bootstrap

- **Date:** 2026-11-18
- **Task ID / subject:** RFC-DOC-001 / documentation governance bootstrap
- **Related RFC:** [`RFCs/RFC-DOC-001-documentation-governance-bootstrap.md`](../../../RFCs/RFC-DOC-001-documentation-governance-bootstrap.md) (Status at time of work: **Proposed**)
- **Migration record:** [`../agents-md-migration.md`](../agents-md-migration.md)
- **Report status:** Historical record of agent work. **Not** Maintainer approval, RFC acceptance, or release authorization.

## 1. Task scope

Implement the documentation governance system described by RFC-DOC-001 while preserving and migrating the existing root `AGENTS.md` project knowledge.

In scope:

- Evolve root `AGENTS.md` (not replace with a generic template)
- Improve `README.md` from verified repository facts
- Establish `RFCs/` process, template, and lifecycle docs
- Establish `Rules Specs/` (00–10 + templates)
- Create an `AGENTS.md` migration traceability record

Out of scope (per RFC non-goals and safety constraints):

- Application source / CLI behavior changes
- Release workflow changes
- Auto-accepting RFC-DOC-001
- Inventing LICENSE, CONTRIBUTING, SECURITY, CHANGELOG, or a test suite

## 2. Implementation results

### Design decisions (recommendations / interpretations)

| Decision | Kind | Notes |
|----------|------|-------|
| Keep `Rules Specs/` directory name (space included) as in RFC | Followed RFC | No conflicting existing convention |
| Put smtgit-specific legacy rules in Spec `10` | Recommendation | Separates project contracts from generic maintainer rules |
| Root `AGENTS.md` in English; product docs remain largely Chinese | Interpretation + open policy | RFC primary language English; existing README/`docs/` Chinese preserved |
| Leave RFC-DOC-001 status as Proposed | Verified constraint | Agents must not accept RFCs |
| Do not extend `release.yml` packaging yet | Recommendation | Flagged for Maintainer |

### Verified repository facts (at time of implementation)

- smtgit is bash + system git; commands are `pull` and `help`
- Domain helpers: `is_git_worktree`, `git_pull`, `discover_git_repos`
- Docs present: `docs/pull.md`, `docs/release.md`
- Release: `.github/workflows/release.yml` on `v*` tags packages `smtgit.sh`, `shared/`, `docs/`, `README.md`, `AGENTS.md`
- Absent: LICENSE, CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md, CHANGELOG.md, automated tests, nested `AGENTS.md`

### Outcomes

- Four-part governance system drafted and linked
- Legacy `AGENTS.md` instructions inventoried with dispositions (retain / extract / consolidate / update; none deprecated)
- Product semantics (`sdepth`, path scheme C, thin-entry/thick-shared, stopgap ban, doc section orders) preserved in Spec `10` and summarized in root `AGENTS.md`

## 3. Files changed

### Created

- `RFCs/README.md`, `RFCs/TEMPLATE.md`, `RFCs/process.md`
- `RFCs/{accepted,rejected,deferred,superseded}/.gitkeep`
- `Rules Specs/README.md`
- `Rules Specs/00-maintainer-principles.md` … `10-smtgit-project-conventions.md`
- `Rules Specs/templates/{README,RFC,ADR,DOCUMENTATION-REVIEW}.template.md`
- `docs/maintenance/agents-md-migration.md`

### Modified

- `AGENTS.md`
- `README.md`

### Intentionally untouched

- `RFCs/RFC-DOC-001-documentation-governance-bootstrap.md` (content/status preserved)
- `docs/pull.md`, `docs/release.md`
- `smtgit.sh`, `shared/*`, `.github/workflows/release.yml`

## 4. Verification performed

| Check | Outcome |
|-------|---------|
| Required deliverable files exist | Pass |
| Relative Markdown links (103 checked) | Pass |
| `bash smtgit.sh help` / `help pull` | Pass |
| Spec `10` domain rules vs `smtgit.sh` / `shared/` / `docs/pull.md` | Pass (aligned) |
| No unauthorized application/release source edits | Pass |
| RFC-DOC-001 not marked Accepted | Pass |
| Missing community/license/test metadata not fabricated | Pass |

## 5. Unresolved issues / Maintainer decisions required

| Issue | Why it matters | Options | Recommendation |
|-------|----------------|---------|----------------|
| Accept / revise / reject RFC-DOC-001 | Formal adoption of governance | Accept; revise; reject | Review deliverables, then set status explicitly |
| Documentation language policy | Chinese product docs vs English governance | Keep split; all English; all Chinese | Keep split until policy is written |
| Release archive contents | Whether `RFCs/` / `Rules Specs/` ship in `v*` packages | Extend workflow; keep runtime-only; document exclusion | Keep runtime-focused unless offline agent rules are desired |
| Missing LICENSE / community files | Public contribution/license clarity | Add files; leave absent; draft via RFC | Add LICENSE when ready; do not invent terms in docs |
| Spec `10` English rendering of Chinese rules | Possible translation drift | English-only; bilingual; Chinese normative + English summary | Spot-check; bilingual only if Maintainers find drift |

## 6. Final status at completion of bootstrap work

**Completed with Open Questions** — mandatory bootstrap deliverables and migration trace were produced; RFC-DOC-001 and the decisions above remain for human Maintainers.

---

## Addendum — 2026-11-18 (same day): report retention rule + this file

After the bootstrap report above was delivered in chat only, Maintainers requested:

1. Codify **Implementation Report Retention** in Rules Specs (Document Lifecycle, with a Documentation Review checklist cross-check).
2. Persist the bootstrap implementation report in-repo under `docs/maintenance/reports/`.

Additional files touched for that follow-up:

- Modified: `Rules Specs/08-document-lifecycle.md`, `Rules Specs/07-documentation-review.md`, `Rules Specs/README.md`, `Rules Specs/10-smtgit-project-conventions.md` (layout note)
- Created: this report path `docs/maintenance/reports/2026-11-18-rfc-doc-001-documentation-governance-bootstrap.md`

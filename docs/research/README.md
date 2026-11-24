# Research reports

Research reports capture **what we have learned** and **what we should consider** before (or alongside) a formal design decision.

## Decision-document triad

| Location | Question it answers | Typical outcome |
|----------|---------------------|-----------------|
| [`RFCs/`](../../RFCs/README.md) | What should we do and why? | Maintainer-controlled proposal / decision record |
| [`docs/research/`](./) | What have we learned and what should we consider? | Evidence, options, recommendations (not acceptance) |
| [`docs/maintenance/reports/`](../maintenance/reports/) | What did we actually do and what happened? | Implementation / migration execution record |

These roles MUST NOT be collapsed into a single document type.

## Directory layout

```text
docs/research/
├── README.md                 # This index (points to the current primary)
├── YYYY-MM-DD-<topic>.md     # Current / active research conclusions (flat + dated)
├── supplementary/            # Standalone topical reports that still add value
└── archive/                  # Superseded reports retained for traceability
```

| Path | Keep when | Do not use for |
|------|-----------|----------------|
| `docs/research/YYYY-MM-DD-<topic>.md` | Current Maintainer-facing conclusions for an active topic; **one primary** is listed in this README’s inventory | Claiming RFC acceptance or recording implementation work |
| [`supplementary/`](./supplementary/) | A stage report has **independent** evidence or recommendations not folded into the primary | Temporary scratch notes |
| [`archive/`](./archive/) | An earlier report was **superseded** as the conclusion entry but remains useful to audit how the position evolved | Citing archived stance as current policy |

**Naming:** primary and historical reports use **flat + dated** filenames (`YYYY-MM-DD-<topic>.md`). Do **not** use a fixed evergreen name such as `research-report.md`.

**Retention principle:** keep research history that still carries information value; do not retain duplicate passes or ephemeral notes in the repository.

When a newer primary entry replaces an older one:

1. Add the new dated file at `docs/research/YYYY-MM-DD-<topic>.md`.
2. Move the superseded primary into `archive/` and mark it superseded in its header.
3. Move any still-valuable side investigation into `supplementary/` (or leave it there).
4. Update this README’s “Current inventory” table so the primary pointer stays accurate.

## Current inventory (as of 2026-11-24)

| Role | Document | Topic |
|------|----------|-------|
| Primary | [`2026-11-24-product-readme-outline-rule-conflicts.md`](./2026-11-24-product-readme-outline-rule-conflicts.md) | Product-oriented README outline + rule-conflict inventory |
| Supplementary | [`supplementary/2026-11-20-readme-pull-release-docs-review.md`](./supplementary/2026-11-20-readme-pull-release-docs-review.md) | README / pull / release accuracy review; keep `docs/release.md` |
| Archive | [`archive/2026-11-23-product-oriented-readme-revision.md`](./archive/2026-11-23-product-oriented-readme-revision.md) | Earlier product-README feasibility; stance superseded by primary |

## When to write a research report

- Feasibility or ecosystem surveys before a substantial RFC.
- Inventory and gap analysis of repository assets.
- Comparison of alternatives where the team is not yet ready to propose a single design.
- Follow-on investigation requested by Maintainers after an RFC discussion.
- Organizing or superseding prior research while preserving valuable history.

Routine command-doc edits and small bug fixes do **not** need a research report.

## Conventions

1. Deliver research under **`docs/research/`** using the layout above (not under `docs/maintenance/reports/`).
2. Name reports with **flat + dated** filenames (`YYYY-MM-DD-<topic>.md`). List the current primary in this README; put independently valuable stage reports under `supplementary/`; put superseded primaries under `archive/`.
3. Distinguish **Verified facts**, **Survey findings**, **Design proposals**, and **Open assumptions**.
4. A research report MUST NOT mark an RFC Accepted or claim Maintainer approval.
5. If research leads to a design choice, draft or update an RFC under `RFCs/`; keep the research report as supporting evidence.
6. After significant implementation of an accepted design, write a retention report under `docs/maintenance/reports/` (see [`.agents/rules/08-document-lifecycle.md`](../../.agents/rules/08-document-lifecycle.md)).
7. Do not commit temporary research notes or duplicate intermediate drafts that add no information beyond the primary / supplementary / archive set.

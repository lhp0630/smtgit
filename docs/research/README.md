# Research reports

Research reports capture **what we have learned** and **what we should consider** before (or alongside) a formal design decision.

## Decision-document triad

| Location | Question it answers | Typical outcome |
|----------|---------------------|-----------------|
| [`RFCs/`](../../RFCs/README.md) | What should we do and why? | Maintainer-controlled proposal / decision record |
| [`docs/research/`](./) | What have we learned and what should we consider? | Evidence, options, recommendations (not acceptance) |
| [`docs/maintenance/reports/`](../maintenance/reports/) | What did we actually do and what happened? | Implementation / migration execution record |

These roles MUST NOT be collapsed into a single document type.

## When to write a research report

- Feasibility or ecosystem surveys before a substantial RFC.
- Inventory and gap analysis of repository assets.
- Comparison of alternatives where the team is not yet ready to propose a single design.
- Follow-on investigation requested by Maintainers after an RFC discussion.

Routine command-doc edits and small bug fixes do **not** need a research report.

## Conventions

1. Store new research reports under **`docs/research/`** (this directory).
2. Prefer descriptive filenames, optionally dated (for example `YYYY-MM-DD-topic-research.md` or `<topic>-research.md`).
3. Distinguish **Verified facts**, **Survey findings**, **Design proposals**, and **Open assumptions**.
4. A research report MUST NOT mark an RFC Accepted or claim Maintainer approval.
5. If research leads to a design choice, draft or update an RFC under `RFCs/`; keep the research report as supporting evidence.
6. After significant implementation of an accepted design, write a retention report under `docs/maintenance/reports/` (see [`.agents/rules/08-document-lifecycle.md`](../../.agents/rules/08-document-lifecycle.md)).

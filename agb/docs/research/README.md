# agb research reports

Research reports for the **agb** product staging tree.

Living documentation-governance rules for research live in the smtgit reference tree and **take precedence**:

- [`../../../docs/research/README.md`](../../../docs/research/README.md)
- Spec [`05`](../../../.agents/rules/05-documentation-architecture.md) / [`08`](../../../.agents/rules/08-document-lifecycle.md)

This directory mirrors those conventions for **agb-scoped** research only. It does not replace repository-root `docs/research/`.

## Role in the documentation triad

| Location | Question |
|----------|----------|
| `RFCs/` (smtgit today; agb repo later) | What should we do and why? |
| **`agb/docs/research/`** (this directory) | What have we learned and what should we consider? (agb product) |
| `docs/maintenance/reports/` | What did we actually do and what happened? |

These roles MUST NOT be collapsed into a single document type.

## Directory layout (aligned with living governance)

```text
agb/docs/research/
├── README.md                      # This index (points to the current primary)
├── YYYY-MM-DD-<topic>.md          # Current / active agb research (flat + dated)
├── supplementary/                 # Independently valuable stage reports (create when needed)
└── archive/                       # Superseded reports retained for traceability (create when needed)
```

| Path | Role |
|------|------|
| `YYYY-MM-DD-<topic>.md` | Current agb research conclusions (primary; listed below) |
| `supplementary/` | Stage reports that still add value beyond the primary |
| `archive/` | Superseded primaries kept for audit |

**Naming:** use **flat + dated** filenames. Do **not** use a fixed evergreen name such as `research-report.md`.

## Current inventory

| Role | Document | Topic |
|------|----------|-------|
| Primary | [`2026-11-19-repository-governance-bootstrap-tool-research.md`](./2026-11-19-repository-governance-bootstrap-tool-research.md) | Feasibility and design research for agb |
| Supplementary | [`supplementary/2026-11-24-cli-help-bilingual-locale.md`](./supplementary/2026-11-24-cli-help-bilingual-locale.md) | CLI help 中英双版；按系统 locale 选择语言 |

## Conventions

1. New agb Research Reports MUST be delivered under this directory (or, for repo-wide topics, under [`../../../docs/research/`](../../../docs/research/README.md)).
2. Distinguish **Verified facts**, **Survey findings**, **Design proposals**, and **Open assumptions**.
3. A research report MUST NOT mark an RFC Accepted or claim Maintainer approval.
4. If research leads to a design choice, draft or update an RFC under `RFCs/`; keep the research report as supporting evidence.

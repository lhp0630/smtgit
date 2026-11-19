# 05 — Documentation Architecture

## Purpose

Organize smtgit documentation by reader need while respecting the repository’s existing layout.

## Scope

Information architecture for `README.md`, `docs/`, `RFCs/`, `.agents/rules/`, and `AGENTS.md`.

## Applicable tasks

- Adding docs for new subcommands
- Reorganizing documentation navigation
- Choosing where a piece of content belongs

## Normative requirements

### Decision-document triad (normative)

Use these locations for substantial design and governance work. Do **not** collapse their roles.

| Location | Question it answers | Notes |
|----------|---------------------|-------|
| [`RFCs/`](../../RFCs/README.md) | What should we do and why? | Maintainer-controlled proposals and decision records |
| [`docs/research/`](../../docs/research/README.md) | What have we learned and what should we consider? | Research reports; evidence and options; **not** acceptance |
| [`docs/maintenance/reports/`](../../docs/maintenance/reports/) | What did we actually do and what happened? | Implementation / migration execution records ([`08-document-lifecycle.md`](08-document-lifecycle.md)) |

New Research Reports MUST be delivered under `docs/research/` (see that directory’s README). Maintainer-approved product staging trees MAY mirror the same role until extracted.

### Diátaxis mapping (adapted, not forced into new top-level dirs)

| Need | Form | smtgit location |
|------|------|-----------------|
| Orientation / quick start | Tutorial-lite / how-to | `README.md` Quick Start |
| Task-oriented procedure | How-to | `docs/release.md`, workflow sections in `docs/<command>.md` |
| Exact semantics / options | Reference | `docs/<command>.md` command tables, exit codes |
| Concepts / rationale | Explanation | `docs/<command>.md` key semantics; RFCs for decisions; research under `docs/research/` when pre-decision |
| Agent operating rules | Agent guide | `AGENTS.md` + `.agents/rules/` |

Do **not** create empty Tutorial/How-to/Reference/Explanation directory trees unless Maintainers request them.

### Project documentation rules (from legacy AGENTS.md)

1. **One command, one doc:** full command semantics live in `docs/<command>.md`, not in README.
2. **README is overview only:** intro, features, layout, shortest examples, links.
3. **`docs/<command>.md` fixed section order:**
   1. Title = command name; one-line description
   2. **命令** — usage + options table (option / required / default / description)
   3. **关键语义** — domain concepts via comparison tables
   4. **工作流程** — ordered steps; failure/continue policy
   5. **示例** — default, boundaries (for example `-p .`, `sdepth=0`), help
   6. **退出码** — table
   7. **相关代码** — entry + `shared/` files
4. Extending a subcommand MUST add or update `docs/<command>.md` and a README feature bullet.

## Prohibited behavior

1. MUST NOT dump scan implementation detail into README.
2. MUST NOT split one command’s normative semantics across conflicting docs without a single source of truth.
3. MUST NOT relocate accepted RFCs into `docs/` in a way that obscures decision history.

## Required workflow

1. Classify the content type.
2. Place it in the existing tree using the mapping above.
3. Update cross-links from README / AGENTS.md as needed.

## Verification criteria

- New command docs follow the section order.
- README remains overview-only.
- Navigation links resolve.

## References

- [Diátaxis](https://diataxis.fr/)
- [`10-smtgit-project-conventions.md`](10-smtgit-project-conventions.md)
- [`docs/pull.md`](../../docs/pull.md) (canonical command-doc example)

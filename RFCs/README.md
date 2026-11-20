# RFCs

RFCs (Requests for Comments) are the project's mechanism for proposing, reviewing, accepting, and recording substantial design and process decisions.

This system is adapted from practices in [Kubernetes Enhancement Proposals](https://github.com/kubernetes/enhancements) and [Rust RFCs](https://rust-lang.github.io/rfcs/), sized for a small bash utility project.

## What an RFC is

An RFC answers: **What should we do and why?**

An RFC is a Markdown proposal that:

- States a problem and motivation.
- Defines goals and non-goals.
- Describes a design and alternatives.
- Records trade-offs, risks, and open questions.
- Has an explicit status controlled by human Maintainers.

Related document types (do not substitute for each other):

| Location | Question |
|----------|----------|
| **`RFCs/`** (this tree) | What should we do and why? |
| [`docs/research/`](../docs/research/README.md) | What have we learned and what should we consider? |
| [`docs/maintenance/reports/`](../docs/maintenance/reports/) | What did we actually do and what happened? |

Prefer a research report under `docs/research/` when evidence and options are still open; promote a design choice into an RFC when Maintainers need a decision record. After implementation of significant accepted work, retain an execution report under `docs/maintenance/reports/`.

Routine bug fixes, small refactors, and documentation clarifications that do not change project meaning normally do **not** need an RFC.

## When an RFC is required

Propose an RFC when the change is substantial, including:

- New CLI subcommands or user-visible semantics (for example `sdepth` or path behavior).
- Architecture or layering changes that affect `shared/` contracts.
- Documentation governance, contribution, security, or release policy changes.
- Breaking changes to documented behavior.
- Decisions that should remain as historical project record.

When unsure, ask a Maintainer. Prefer a short RFC over an undocumented irreversible decision.

## How to propose an RFC

1. Read [`process.md`](process.md).
2. Copy [`TEMPLATE.md`](TEMPLATE.md) to a new file in `RFCs/` using the naming pattern `RFC-<AREA>-<NNN>-short-title.md` (for example `RFC-CLI-002-status-command.md`).
3. Fill every applicable section. Leave unknowns marked as open questions.
4. Open a pull request (or equivalent review request) for Maintainer review.
5. Revise in response to feedback.

Do **not** assign `Accepted` status yourself. AI agents may draft and revise RFCs; only a human Maintainer may accept, reject, defer, or supersede them.

## How to review an RFC

Reviewers SHOULD check:

- Problem clarity and evidence.
- Goals / non-goals completeness.
- Alternatives and trade-offs.
- Compatibility and migration impact.
- Security and safety implications.
- Test / validation plan realism for this repository.
- Open questions that block acceptance.

## How decisions are made

| Decision | Authority |
|----------|-----------|
| Draft, revise, analyze | Contributors and AI agents |
| Accept / Reject / Defer / Supersede | Human Maintainer only |
| Mark Implemented / Completed | Human Maintainer (after verifying implementation) |

A merged implementation PR does **not** by itself mean an RFC was accepted.

## Lifecycle overview

```text
Draft → In Review → Accepted → In Progress → Implemented
                 ↘ Rejected
                 ↘ Deferred
Accepted / Implemented → Superseded (via a newer RFC)
```

Details: [`process.md`](process.md).

## Directory layout

```text
RFCs/
├── README.md          # This file
├── TEMPLATE.md        # Authoring template
├── process.md         # Lifecycle and rules
├── accepted/          # Pointers or copies of accepted RFCs (optional staging)
├── rejected/
├── deferred/
├── superseded/
└── RFC-*.md           # Active and historical RFC documents
```

Status directories may hold stubs or relocated copies once Maintainers adopt a filing convention. Until then, the status field inside each RFC file is authoritative.

## Existing RFCs

| RFC | Title | Status |
|-----|-------|--------|
| [RFC-DOC-001](accepted/RFC-DOC-001-documentation-governance-bootstrap.md) | Documentation Governance Bootstrap | Accepted |
| [RFC-DOC-002](RFC-DOC-002-agent-governance-bootstrap.md) | Agent Governance Bootstrap Tool (agb) | Draft |

Historical RFCs MUST NOT be silently rewritten to match newer templates. Amend via a new RFC or an explicit Maintainer-approved amendment note.

## Related rules

- [`../.agents/rules/03-rfc-writing.md`](../.agents/rules/03-rfc-writing.md)
- [`../.agents/rules/09-community-governance.md`](../.agents/rules/09-community-governance.md)
- [`../AGENTS.md`](../AGENTS.md)

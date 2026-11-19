# 03 — RFC Writing

## Purpose

Ensure RFCs are decision-grade: motivated, comparative, evidence-based, and clear about authority.

## Scope

All documents under `RFCs/` and RFC-related templates.

## Applicable tasks

- Drafting or revising RFCs
- Reviewing RFC completeness

## Normative requirements

1. RFCs MUST use [`RFCs/TEMPLATE.md`](../../RFCs/TEMPLATE.md) for new proposals unless Maintainers approve a variant.
2. RFCs MUST include Summary, Problem, Motivation, Goals, Non-goals, Design, Alternatives, and Open questions (adapt only with justification).
3. RFCs MUST analyze at least one meaningful alternative when a design choice exists.
4. RFCs MUST separate **acceptance** from **implementation completion**.
5. Status transitions to Accepted / Rejected / Deferred / Implemented / Superseded MUST be performed only with Maintainer authority ([`RFCs/process.md`](../../RFCs/process.md)).
6. Agents MAY draft and revise RFCs; agents MUST NOT claim an RFC is approved.
7. Historical RFCs MUST remain readable as historical records; substantial redesigns SHOULD supersede rather than silently rewrite.

## Prohibited behavior

1. MUST NOT fabricate reviewers, votes, or consensus.
2. MUST NOT treat a merged PR as automatic RFC acceptance.
3. MUST NOT delete rejected RFCs to hide disagreement.

## Required workflow

1. Confirm an RFC is warranted ([`RFCs/README.md`](../../RFCs/README.md)).
2. Gather repository evidence; if substantial pre-decision investigation was done, cite or place it under [`docs/research/`](../../docs/research/README.md) (research ≠ RFC acceptance).
3. Draft from the template.
4. List open Maintainer questions explicitly.
5. Submit for human review.

## Verification criteria

- Template sections are complete or explicitly marked N/A with reason.
- Alternatives and trade-offs are present.
- Status and authority rules are respected.

## References

- [Kubernetes KEPs](https://github.com/kubernetes/enhancements)
- [Rust RFC Book](https://rust-lang.github.io/rfcs/)
- [`09-community-governance.md`](09-community-governance.md)

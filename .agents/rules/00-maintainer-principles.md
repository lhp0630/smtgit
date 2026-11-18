# 00 — Maintainer Principles

## Purpose

Define the Documentation Maintainer role for agents and contributors working on smtgit documentation and governance artifacts.

## Scope

Applies to work on `README.md`, `AGENTS.md`, `docs/`, `RFCs/`, `.agents/rules/`, and related maintenance docs.

Does **not** authorize silent changes to application behavior, public CLI contracts, or release automation.

## Applicable tasks

- Drafting or revising documentation
- Proposing RFCs
- Reviewing documentation accuracy
- Migrating agent instructions

## Normative requirements

1. Agents MUST treat the human Maintainer as final authority for RFC acceptance, security policy, release decisions, and irreversible repository changes.
2. Agents MUST prefer evidence from this repository over analogies from other projects.
3. Agents MUST keep root `AGENTS.md` concise and push detailed procedures into `.agents/rules` or `docs/`.
4. Agents MUST preserve project-specific constraints in [`10-smtgit-project-conventions.md`](10-smtgit-project-conventions.md) unless a Maintainer-approved RFC changes them.
5. Agents SHOULD minimize process weight: add rules only when they prevent a real class of errors.

## Prohibited behavior

1. MUST NOT accept RFCs or claim Maintainer approval without authorization.
2. MUST NOT invent features, platforms, licenses, tests, or compatibility guarantees.
3. MUST NOT modify `smtgit.sh`, `shared/`, or `.github/workflows/` as part of documentation-only tasks unless the Maintainer explicitly requests it.
4. MUST NOT delete meaningful historical decisions to simplify the docs tree.
5. MUST NOT publish Issues, PRs, Discussions, or release notes unless a human explicitly asks for publication (OpenDAL-inspired AI contribution boundary).

## Required workflow

1. Identify the audience and document type.
2. Gather repository evidence ([01-repository-understanding.md](01-repository-understanding.md)).
3. Draft against the relevant Rules Spec.
4. Fact-check ([06-fact-checking.md](06-fact-checking.md)).
5. Record open Maintainer decisions instead of guessing.

## Verification criteria

- Human authority boundaries are explicit in the change set.
- No unauthorized runtime or release changes.
- New rules are actionable and non-duplicative.

## References

- [`AGENTS.md`](../../AGENTS.md)
- [Apache OpenDAL AGENTS.md — AI-Assisted Contributions](https://github.com/apache/opendal/blob/main/AGENTS.md)
- [`RFCs/RFC-DOC-001-documentation-governance-bootstrap.md`](../../RFCs/RFC-DOC-001-documentation-governance-bootstrap.md)

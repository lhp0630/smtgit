# 01 — Repository Understanding

## Purpose

Ensure agents research the actual smtgit repository before writing or changing documentation.

## Scope

All documentation and governance tasks that make technical claims about the project.

## Applicable tasks

- README updates
- Command docs under `docs/`
- RFC drafting
- Agent instruction changes

## Normative requirements

1. Before asserting project behavior, agents MUST inspect relevant evidence in this order of preference:
   1. Current source (`smtgit.sh`, `shared/*.sh`)
   2. Maintainer-authored docs that match current code (`docs/`, `README.md`)
   3. Accepted RFCs / recorded decisions
   4. CI / release workflows
   5. Issues, PRs, discussions (supporting only)
2. Agents MUST distinguish **verified facts**, **reasonable interpretations**, and **unknowns**.
3. Agents MUST run or read help text when documenting CLI usage (for example `bash smtgit.sh help` and `bash smtgit.sh help pull`).
4. Agents MUST NOT assume presence of files that are missing (for example `LICENSE`, `CONTRIBUTING.md`, `CHANGELOG.md`, test suites) without checking.
5. Nested `AGENTS.md` files (none exist today) MUST be treated as scoped to their directory if introduced later.

## Prohibited behavior

1. MUST NOT copy architecture claims from unrelated projects (for example OpenDAL workspace layout) into smtgit docs.
2. MUST NOT describe planned features as shipped features.
3. MUST NOT invent build, test, or install toolchains.

## Required workflow

1. List files and entry points touched by the claim.
2. Read implementation and matching docs.
3. Note contradictions without silently resolving them.
4. Record unknowns for Maintainer input when they block accuracy.

## Verification criteria

- Each material claim cites evidence or is marked unknown.
- CLI examples match `usage_*` output and `docs/pull.md` where applicable.
- Missing project metadata is disclosed rather than fabricated.

## Expected output

For non-trivial doc tasks, a short evidence note (in the PR, review, or migration record) listing inspected paths and commands.

## References

- [`10-smtgit-project-conventions.md`](10-smtgit-project-conventions.md)
- [`06-fact-checking.md`](06-fact-checking.md)

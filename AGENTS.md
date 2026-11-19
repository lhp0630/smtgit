# AGENTS.md

Guidance for AI coding agents working in **smtgit**.

This file is the agent entry point. Detailed reusable rules live under [`.agents/rules/`](.agents/rules/README.md). Project-specific architecture and documentation format constraints extracted from the legacy agent guide live in [`.agents/rules/10-smtgit-project-conventions.md`](.agents/rules/10-smtgit-project-conventions.md). Cursor loads these via [`.cursor/rules/agents-rules.mdc`](.cursor/rules/agents-rules.mdc). Templates live under [`.agents/templates/`](.agents/templates/).

Migration trace: [`docs/maintenance/agents-md-migration.md`](docs/maintenance/agents-md-migration.md).

## Project identity

smtgit is a **bash** CLI that discovers Git repositories under a path by **Git-repo nesting depth (`sdepth`)** and runs **`git pull`**. It depends on bash and system `git` only.

| Item | Verified fact |
|------|----------------|
| Entry | `smtgit.sh` |
| Libraries | `shared/log.sh`, `shared/path.sh`, `shared/git.sh`, `shared/scan.sh` |
| Commands | `pull`, `help` |
| Docs | `docs/pull.md`, `docs/release.md` |
| Release | `.github/workflows/release.yml` on `v*` tags |
| Tests / LICENSE / CONTRIBUTING / SECURITY / CHANGELOG | **Not present** in the repository as of the governance bootstrap |

Do not invent missing metadata or tooling.

## Agent role and authority

1. Act as a careful implementer and documentation maintainer.
2. Human Maintainers have final authority over RFC acceptance, security/governance policy, releases, and irreversible changes.
3. You MAY draft and revise RFCs and docs. You MUST NOT mark an RFC `Accepted` or claim Maintainer approval without explicit human authorization.
4. You MUST NOT publish Issues, PRs, Discussions, or releases unless a human explicitly asks you to.

See [`.agents/rules/00-maintainer-principles.md`](.agents/rules/00-maintainer-principles.md) and [`.agents/rules/09-community-governance.md`](.agents/rules/09-community-governance.md).

## Essential repository constraints (summary)

Full normative detail: [`.agents/rules/10-smtgit-project-conventions.md`](.agents/rules/10-smtgit-project-conventions.md).

- **Thin entry, thick shared:** reusable logic in `shared/`; `smtgit.sh` only orchestrates.
- **Pure bash + system git;** currently only non-destructive `git pull`.
- **`sdepth`** counts nested Git worktree roots, not filesystem directory depth. CLI accepts `0` (unlimited) and `1` (default).
- **Path scheme C:** worktree-root `-p` always pulls itself and scans nested only when `sdepth=0`; non-root `-p` discovers per `sdepth`.
- **`discover_git_repos`** never emits `root` itself.
- Prefer stable domain-named helpers (`is_git_worktree`, `discover_git_repos`, `git_pull`) over migration stopgaps (`_raw_*`, `_mapped_*`, `_compat_*`).
- One command → one `docs/<command>.md`; README stays overview-only with fixed section order.
- Single-repo pull failure does not abort the batch; CLI aggregates exit status.
- Every subcommand must provide `help`.

## Discovery expectations

Before changing behavior or docs:

1. Read relevant source under `smtgit.sh` / `shared/`.
2. Read matching docs under `docs/`.
3. Check RFCs for proposed vs accepted decisions (`RFCs/`).
4. Check research reports under `docs/research/`.
5. Verify CLI text with:

```bash
bash smtgit.sh help
bash smtgit.sh help pull
```

Rules: [`.agents/rules/01-repository-understanding.md`](.agents/rules/01-repository-understanding.md), [`.agents/rules/06-fact-checking.md`](.agents/rules/06-fact-checking.md).

## Documentation governance

| Deliverable | Location |
|-------------|----------|
| Human overview | [`README.md`](README.md) |
| Command reference / how-to | [`docs/`](docs/) |
| Research reports | [`docs/research/`](docs/research/README.md) — *what have we learned / should we consider?* |
| RFC process | [`RFCs/README.md`](RFCs/README.md), [`RFCs/process.md`](RFCs/process.md) — *what should we do and why?* |
| Implementation / migration reports | [`docs/maintenance/reports/`](docs/maintenance/reports/) — *what did we actually do?* |
| Detailed agent rules | [`.agents/rules/README.md`](.agents/rules/README.md) |
| Doc templates | [`.agents/templates/`](.agents/templates/) |
| Cursor Rules entry | [`.cursor/rules/agents-rules.mdc`](.cursor/rules/agents-rules.mdc) |

Writing and structure rules: [`02-readme-writing.md`](.agents/rules/02-readme-writing.md), [`04-technical-writing.md`](.agents/rules/04-technical-writing.md), [`05-documentation-architecture.md`](.agents/rules/05-documentation-architecture.md).

Evidence and review: [`06-fact-checking.md`](.agents/rules/06-fact-checking.md), [`07-documentation-review.md`](.agents/rules/07-documentation-review.md), [`08-document-lifecycle.md`](.agents/rules/08-document-lifecycle.md).

RFC authoring: [`.agents/rules/03-rfc-writing.md`](.agents/rules/03-rfc-writing.md), template [`RFCs/TEMPLATE.md`](RFCs/TEMPLATE.md).

## Source-of-truth hierarchy

When instructions conflict, prefer in order:

1. Explicit user / Maintainer direction for this task
2. Accepted RFCs and Maintainer-approved policy
3. This `AGENTS.md`
4. [`.agents/rules/`](.agents/rules/) (project spec `10-…` wins over generic specs on smtgit-specific topics)
5. Living docs that match current code (`docs/`, README)
6. External references (advisory only)

If two authoritative sources conflict, **stop and report** — do not silently choose.

## Safety

- Do not add destructive git operations without Maintainer-approved RFC.
- Do not weaken release, security, or approval requirements.
- Do not modify application source or release workflows on documentation-only tasks unless explicitly asked.
- Do not fabricate licenses, security guarantees, tests, or compatibility claims.

## Handling uncertainty

1. Mark unknowns explicitly.
2. Record Maintainer decisions needed.
3. Continue only with work that does not require guessing high-impact policy.

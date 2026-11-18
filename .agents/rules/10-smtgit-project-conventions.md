# 10 — smtgit Project Conventions

## Purpose

Preserve and operationalize project-specific constraints originally maintained in root `AGENTS.md` (pre-governance-bootstrap).

This file is the detailed home for smtgit architecture, domain semantics, and documentation format rules. Root `AGENTS.md` keeps a short summary and links here.

## Scope

All code and documentation changes in this repository.

## Applicable tasks

- Implementing or refactoring bash code
- Adding subcommands
- Editing README / `docs/`
- Reviewing agent changes for architectural fit

## Normative requirements

### A. Repository layout

Expected layout:

```text
smtgit/
├── smtgit.sh                 # CLI entry: dispatch, parsing, exit codes
├── shared/                   # Reusable libraries by domain (no implicit side effects)
│   ├── log.sh                # Logging (diagnostics on stderr)
│   ├── path.sh               # Path normalization and directory checks
│   ├── git.sh                # Git primitives (worktree checks, pull)
│   └── scan.sh               # Discover Git repos by sdepth
├── docs/                     # Per-command / topic docs
│   ├── <command>.md
│   └── maintenance/          # Migration notes and retained implementation reports
├── RFCs/                     # Design / process proposals
├── .agents/
│   ├── rules/                # Agent and documentation rules
│   └── templates/            # Doc / RFC / review templates
├── .cursor/rules/            # Cursor Rules load entry → .agents/rules
├── .github/workflows/
│   └── release.yml           # push v* tag → package + GitHub Release
├── README.md                 # Overview only
└── AGENTS.md                 # Agent entry point
```

Constraints:

1. **Thin entry, thick shared:** `smtgit.sh` only dispatches and orchestrates; reusable logic belongs in `shared/`.
2. **One command, one doc:** full semantics in `docs/<command>.md`, not README.
3. **README is overview only:** intro, features, layout, shortest examples; no scan deep-dives.
4. **Pure bash + system git:** do not add other runtime dependencies; do not perform destructive git operations (currently only `pull`).

### B. Core design principle — stable domain helpers, not stopgaps

Prefer **stable, domain-named pure helpers** over transitional duck-typed stopgaps. Architecture and domain semantics below obey this principle.

Why stopgaps appear: migration dialects use loose probing and temporary names (`_raw_*`, `_mapped_*`) to bridge dual shapes. After dual paths disappear, those scaffolds are poor APIs.

**Do:**

- Define contracts first: parameters/returns express real domain objects (worktree root, sdepth, repo lists).
- Once a path is known to be a worktree root, treat it as such; use explicit checks such as `is_git_worktree` instead of speculative probing chains.
- Name by domain outcome (`discover_git_repos`, `is_git_worktree`, `git_pull`), not by migration story.
- Put reusable logic without I/O orchestration into `shared/`; do not keep private copies in the entry script.
- Keep one API per shape; delete migration names after dual paths are gone.

**Do not:**

- Keep stopgaps after the production contract is fixed because “loose probing is easier for fixtures.”
- Bury shared-worthy pure logic as `_` private duplicates in entry/feature scripts.
- Encode layering drama (`raw` / `mapped` / `compat`) in names after only one shape remains.

Abstract contrast:

```text
# Bad: migration naming, logic buried in entry, vague contract
_raw_find_repos() { ...; find ... -name .git; ... }

# Good: domain name, clear sdepth contract, lives in shared/scan.sh
discover_git_repos <root> <sdepth>   # one worktree root per line; excludes root itself
```

### C. Layering

| Layer | Location | Responsibility |
|-------|----------|----------------|
| CLI | `smtgit.sh` | Subcommands, option validation, orchestration, aggregate exit codes |
| Domain | `shared/git.sh`, `shared/scan.sh` | worktree / sdepth / discover / pull |
| Infrastructure | `shared/log.sh`, `shared/path.sh` | Logging, paths |

Additional rules:

1. `shared/` exports functions only; sourcing MUST NOT create global side effects.
2. One repo failure MUST NOT abort the whole batch; CLI aggregates success/failure for the exit code.
3. Every subcommand MUST implement `help` (and `help <command>`) with full options and examples.

### D. Domain semantics (mandatory)

1. **`sdepth`:** nesting depth of Git repos / submodules — **not** ordinary directory depth. Traversing non-Git directories does not consume depth; each worktree root counts as one layer.
2. **`sdepth` values:** CLI currently accepts only `0` (unlimited) and `1` (default). Scanner is written as max nesting layers (`0` → no limit) so future positive integers remain possible.
3. **Path scheme C:**
   - If `-p` is a Git worktree root → always pull itself; scan nested repos only when `sdepth=0`.
   - If `-p` is not a worktree root → discover repos under it per `sdepth` and pull each.
4. **Worktree root check:** `git rev-parse --show-toplevel` MUST equal the directory’s normalized path; support `.git` as directory or file (submodules). Do not treat ordinary in-repo subdirectories as independent repos.
5. **`discover_git_repos`:** emits only repos **under** `root`, never `root` itself; whether to pull `root` is decided by command-layer scheme C. Skip paths named `.git`.

### E. Extending subcommands

1. Add dispatch and `help` in `smtgit.sh`.
2. Put domain logic in `shared/` (reuse; do not copy).
3. Add `docs/<command>.md` and a README feature bullet.

### F. Documentation format

#### README.md section order

1. One-sentence introduction
2. **功能** (subcommand list)
3. **目录布局** (tree)
4. **快速开始** (shortest commands)
5. Links into `docs/`

#### `docs/<command>.md` section order

Align with [`docs/pull.md`](../../docs/pull.md):

1. Title = command name; one-line description
2. **命令** — usage block + options table
3. **关键语义** — comparison tables
4. **工作流程** — ordered steps; failure/continue policy
5. **示例** — default, boundaries, help
6. **退出码** — table
7. **相关代码** — entry + `shared/` files

Style: use comparison tables for branches; keep example trees semantically accurate; do not push implementation detail into README.

## Prohibited behavior

1. MUST NOT add non-bash runtime dependencies without an accepted RFC.
2. MUST NOT add destructive git operations without an accepted RFC and Maintainer approval.
3. MUST NOT violate path scheme C or `sdepth` semantics in code or docs.

## Required workflow

When changing architecture or CLI semantics:

1. Read this spec and matching `docs/`.
2. Decide whether an RFC is required ([`RFCs/README.md`](../../RFCs/README.md)).
3. Update code, `docs/<command>.md`, and README together when user-visible behavior changes.

## Verification criteria

- Layout and layering still match this spec.
- Domain semantics in docs match `smtgit.sh` + `shared/`.
- New helpers use domain names and live in the correct layer.

## Relationships

- Summarized in [`AGENTS.md`](../../AGENTS.md)
- Complements [`05-documentation-architecture.md`](05-documentation-architecture.md) and [`02-readme-writing.md`](02-readme-writing.md)
- Migration trace: [`docs/maintenance/agents-md-migration.md`](../../docs/maintenance/agents-md-migration.md)

## References

- Original root `AGENTS.md` (pre-2026-11-18 governance bootstrap)
- Implementation: `smtgit.sh`, `shared/*.sh`

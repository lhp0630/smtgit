# 02 — README Writing

## Purpose

Keep `README.md` accurate, scannable, and useful to first-time visitors without duplicating full command reference or agent governance.

## Scope

Root `README.md` only. Detailed command semantics belong in `docs/<command>.md`.

## Applicable tasks

- Creating or revising the project README
- Checking README / implementation drift

## Normative requirements

### Project-required section order (authoritative)

From legacy `AGENTS.md` / [`10-smtgit-project-conventions.md`](10-smtgit-project-conventions.md), the README MUST keep this order:

1. One-sentence project introduction
2. **功能** (feature / subcommand list)
3. **目录布局** (directory tree)
4. **快速开始** (shortest commands)
5. Links to `docs/`

Additional sections (release notes pointer, governance links, contribution, license) MAY follow those required sections when evidence supports them.

### Content rules

1. README MUST explain what smtgit does before deep implementation detail.
2. Quick Start commands MUST be verified against the CLI.
3. README MUST NOT absorb full `sdepth` / scan workflows — link to [`docs/pull.md`](../../docs/pull.md).
4. README MUST NOT invent badges, stars, benchmarks, license text, or maturity labels without evidence.
5. README SHOULD remain primarily aligned with the repository’s established reader language for product docs (currently Chinese for overview sections; CLI snippets may be English as in the script). Language policy conflicts MUST be escalated to Maintainers rather than silently rewritten.

## Prohibited behavior

1. MUST NOT duplicate the entire `.agents/rules` / RFC system in the README.
2. MUST NOT claim destructive git operations beyond what the code performs (currently `git pull` only).
3. MUST NOT list dependencies other than bash + system `git` unless the repo gains them.

## Required workflow

1. Confirm current subcommands from `smtgit.sh`.
2. Confirm layout from the repository tree.
3. Verify Quick Start commands.
4. Link detailed docs and, if useful, governance entry points (`AGENTS.md`, `RFCs/`, `.agents/rules/`).

## Verification criteria

- Section order matches project convention.
- Commands succeed or match `help` output.
- No unsupported superiority / compatibility claims.

## References

- [GitHub Open Source Guides](https://opensource.guide/)
- [Diátaxis](https://diataxis.fr/) (README ≈ orientation + quick how-to, not full reference)
- [`../templates/README.template.md`](../templates/README.template.md)

# README template checklist (smtgit)

Use this when creating or substantially revising `README.md`.

## Required section order

1. One-sentence project introduction
2. **功能** — subcommands actually implemented
3. **目录布局** — tree matching the repo
4. **快速开始** — shortest verified commands
5. Links to `docs/`

## Optional sections (after the required ones)

- Release / tag notes (only if matching `docs/release.md` + workflow)
- Link to `AGENTS.md` / `RFCs/` / `Rules Specs/` for contributors and agents
- Contribution pointer (only if `CONTRIBUTING.md` exists or draft status is explicit)
- License (only if a LICENSE file exists)

## Validation

- [ ] Commands match `bash smtgit.sh help` / `help pull`
- [ ] Features list matches `smtgit.sh` dispatch
- [ ] No fabricated badges, license, or platform matrix
- [ ] Detailed semantics deferred to `docs/<command>.md`

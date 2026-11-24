# README template checklist (smtgit)

Use this when creating or substantially revising `README.md`.

## Required section order

1. Title + one-sentence product positioning (+ short problem / audience / differentiation)
2. **Why smtgit?** — verified scenarios only
3. **Features** — capabilities (not a repository tree)
4. **Requirements** — verified dependencies only
5. **Quick Start** — obtain project + shortest verified commands
6. **How It Works** — conceptual `sdepth` + Path scheme C summary
7. **Usage** — common commands; link to `docs/<command>.md`
8. **Safety and Limitations** — evidence-backed only
9. **Documentation** — product docs; at most one contributor/agent line
10. **License** — real `LICENSE` link, or explicit “not provided” disclosure

## Optional (Documentation line only)

- Single pointer to `AGENTS.md` / `RFCs/` for contributors and agents
- Contribution pointer only if `CONTRIBUTING.md` exists or draft status is explicit

## Validation

- [ ] Section order matches [`.agents/rules/02-readme-writing.md`](../rules/02-readme-writing.md)
- [ ] Commands match `bash smtgit.sh help` / `help pull`
- [ ] Features / Usage match `smtgit.sh` dispatch
- [ ] No fabricated badges, license text, or platform matrix
- [ ] Full semantics deferred to `docs/<command>.md` (no full workflow / exit-code / related-code dump)
- [ ] No required repository directory-tree section

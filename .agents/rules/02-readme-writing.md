# 02 — README Writing

## Purpose

Keep `README.md` accurate, scannable, and useful to first-time visitors as a **product-oriented** entry: what problem smtgit solves and how to use it — without duplicating full command reference or agent governance.

## Scope

Root `README.md` only. Detailed command semantics belong in `docs/<command>.md`.

## Applicable tasks

- Creating or revising the project README
- Checking README / implementation drift

## Normative requirements

### Project-required section order (authoritative)

The README MUST keep this order (English section headings; see language rule below):

1. Title + one-sentence product positioning, plus a short paragraph on problem / audience / differentiation from uncontrolled batch `git pull`
2. **Why smtgit?**
3. **Features**
4. **Requirements**
5. **Quick Start**
6. **How It Works**
7. **Usage**
8. **Safety and Limitations**
9. **Documentation**
10. **License** (link real `LICENSE` text if present; otherwise disclose absence — do not invent license terms)

Section content bounds:

| Section | MUST | MUST NOT |
|---------|------|----------|
| Opening | Product positioning; problem; audience; differentiation | Repository tree; RFC / Agent governance dump |
| Why smtgit? | Verified scenarios (container of repos; nested / submodules; controlling discovery scope) | Unimplemented scenarios |
| Features | Capabilities (discovery, nested scan, configurable `sdepth`, batch pull, light dependencies) | Full subcommand encyclopedia; repository tree |
| Requirements | Verified dependencies only (bash, system git; bash ≥ 4.3 when documenting nameref use) | Unsupported OS / platform matrices |
| Quick Start | How to obtain the project + shortest verified commands | Release / tag publish procedures |
| How It Works | Conceptual `sdepth` illustration; Path scheme C **summary** | Full workflow, discovery-rule encyclopedia, exit-code table, related-code table (those stay in `docs/pull.md`) |
| Usage | Common commands / options + short examples; link to `docs/pull.md` | Full command reference copy |
| Safety and Limitations | Only `git pull`; batch failure aggregation; known limitations backed by evidence | Fabricated security or maturity guarantees |
| Documentation | Links to `docs/pull.md`, `docs/release.md`; at most one line for contributors / agents | RFC status blocks; Agent Rules tables; migration records |
| License | Actual license file or explicit “not provided” disclosure | Invented license text |

Repository layout trees belong in Spec [`10`](10-smtgit-project-conventions.md) / [`AGENTS.md`](../../AGENTS.md), not as a required README section.

Governance links (`AGENTS.md`, `RFCs/`, `.agents/rules/`) MAY appear as a single line under **Documentation**; they MUST NOT dominate the README body.

### Content rules

1. README MUST explain what problem smtgit solves before deep implementation detail.
2. Quick Start and Usage commands MUST be verified against the CLI.
3. README MAY include a **conceptual** `sdepth` / Path scheme C explanation under **How It Works**. README MUST NOT absorb the **full** scan workflow, discovery-rule list, exit-code table, or related-code table — those remain in [`docs/pull.md`](../../docs/pull.md).
4. README MUST NOT invent badges, stars, benchmarks, license text, or maturity labels without evidence.
5. Product README body SHOULD remain primarily Chinese; required section headings follow the English names above. CLI snippets may match the script (English). Other language policies MUST be escalated to Maintainers rather than silently rewritten.

## Prohibited behavior

1. MUST NOT duplicate the entire `.agents/rules` / RFC system in the README.
2. MUST NOT claim destructive git operations beyond what the code performs (currently `git pull` only).
3. MUST NOT list dependencies other than bash + system `git` unless the repo gains them.
4. MUST NOT require a repository directory tree as a README section.

## Required workflow

1. Confirm current subcommands from `smtgit.sh`.
2. Verify Quick Start / Usage commands against `bash smtgit.sh help` / `help pull`.
3. Keep conceptual README wording aligned with `docs/<command>.md` without copying the full reference.
4. Optionally confirm repository layout in Spec 10 / `AGENTS.md` when contributing (not a README section generator step).
5. Link product docs under **Documentation**; at most one line for contributor / agent entry points.

## Verification criteria

- Section order matches this spec.
- Commands succeed or match `help` output.
- No unsupported superiority / compatibility / license claims.
- Full command semantics remain in `docs/<command>.md`.

## References

- [GitHub Open Source Guides](https://opensource.guide/)
- [Diátaxis](https://diataxis.fr/) (README ≈ orientation + quick how-to + short explanation, not full reference)
- [`../templates/README.template.md`](../templates/README.template.md)
- Research: [`../../docs/research/2026-11-24-product-readme-outline-rule-conflicts.md`](../../docs/research/2026-11-24-product-readme-outline-rule-conflicts.md)

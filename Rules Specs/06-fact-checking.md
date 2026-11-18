# 06 — Fact Checking

## Purpose

Prevent plausible but false documentation claims.

## Scope

Any technical statement about smtgit behavior, requirements, release process, or governance status.

## Applicable tasks

- Documentation authoring and review
- README / help text synchronization
- RFC evidence sections

## Normative requirements

1. Every material technical claim MUST have evidence or be marked unknown / proposed.
2. Prefer primary evidence:
   - Functions: `is_git_worktree`, `git_pull`, `discover_git_repos` in `shared/`
   - CLI orchestration and path scheme C: `smtgit.sh`
   - Release packaging: `.github/workflows/release.yml` and `docs/release.md`
3. Agents MUST verify commands they document when practical.
4. Agents MUST compare README examples with `usage_pull` / `docs/pull.md` when either changes.
5. Status words matter:
   - `Proposed` ≠ `Accepted`
   - Documented desire ≠ implemented behavior
6. If sources conflict, agents MUST report the conflict; MUST NOT silently pick a side.

## Prohibited behavior

1. MUST NOT invent LICENSE, SECURITY, test suites, package managers, or supported OS matrices.
2. MUST NOT claim the tool performs git operations beyond what `shared/git.sh` implements.
3. MUST NOT claim RFC-DOC-001 is accepted unless Maintainers change its status.

## Required workflow

1. Extract claims from the draft.
2. Map each claim to evidence or mark unknown.
3. Run or read CLI help for usage claims.
4. Fix or qualify unsupported claims before finish.

## Verification criteria

- Claim/evidence table can be produced on request.
- No fabricated metadata.
- Governance status language is accurate.

## References

- [`01-repository-understanding.md`](01-repository-understanding.md)
- [`07-documentation-review.md`](07-documentation-review.md)

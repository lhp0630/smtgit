# 09 — Community Governance

## Purpose

Define human authority boundaries and public-communication rules for an AI-assisted repository.

## Scope

Governance actions, public statements, and contribution-facing policy documents.

## Applicable tasks

- RFC decisions
- Publishing PRs/issues/releases
- Writing contribution or security policy drafts

## Normative requirements

1. Human Maintainers retain final authority over:
   - RFC acceptance, rejection, deferral, supersession
   - Governance and security policy changes
   - Release and publication decisions
   - Irreversible repository changes
   - Material changes in project direction
2. AI agents MUST NOT present their recommendations as adopted project policy.
3. AI agents MUST NOT publish Issues, PRs, Discussions, review comments, or releases unless a human explicitly requests that publication.
4. Contribution, CoC, Security, and License documents MUST NOT be invented as if already adopted. Agents MAY draft proposals labeled as drafts for Maintainer review when asked.
5. When repository evidence lacks a policy (currently: no `LICENSE`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, or `CHANGELOG.md`), agents MUST say the policy is absent / unknown.

## Prohibited behavior

1. MUST NOT auto-approve RFCs.
2. MUST NOT weaken safety constraints (for example, “no destructive git operations” beyond current `pull`) without Maintainer-approved RFC.
3. MUST NOT speak as the project in public channels without authorization.

## Required workflow

1. Separate draft recommendations from adopted policy in wording.
2. List decisions that need Maintainer approval.
3. Wait for explicit human direction before publishing or accepting.

## Verification criteria

- Status language is accurate (`Proposed` vs `Accepted`).
- Missing community files are not fabricated.
- Public-action gates are respected.

## References

- [GitHub Open Source Guides](https://opensource.guide/)
- [Apache OpenDAL AI-assisted contribution boundaries](https://github.com/apache/opendal/blob/main/AGENTS.md)
- [`../RFCs/process.md`](../RFCs/process.md)

# Rules Specs

Modular rules for AI coding agents and human contributors acting as documentation maintainers for smtgit.

These specifications expand [`../AGENTS.md`](../AGENTS.md). Prefer linking from `AGENTS.md` over duplicating full procedures there.

## Normative language

| Term | Meaning |
|------|---------|
| MUST | Mandatory |
| MUST NOT | Prohibited |
| SHOULD | Strong recommendation |
| SHOULD NOT | Discouraged |
| MAY | Optional |

## Index

| Spec | Purpose |
|------|---------|
| [00-maintainer-principles.md](00-maintainer-principles.md) | Role, authority, constraints |
| [01-repository-understanding.md](01-repository-understanding.md) | Research and evidence gathering |
| [02-readme-writing.md](02-readme-writing.md) | README structure and validation |
| [03-rfc-writing.md](03-rfc-writing.md) | Proposal quality and lifecycle |
| [04-technical-writing.md](04-technical-writing.md) | Writing style and terminology |
| [05-documentation-architecture.md](05-documentation-architecture.md) | Doc types and navigation |
| [06-fact-checking.md](06-fact-checking.md) | Evidence and accuracy |
| [07-documentation-review.md](07-documentation-review.md) | Review severity and QA |
| [08-document-lifecycle.md](08-document-lifecycle.md) | Versioning, historical integrity, implementation report retention |
| [09-community-governance.md](09-community-governance.md) | Human authority and public communication |
| [10-smtgit-project-conventions.md](10-smtgit-project-conventions.md) | smtgit-specific architecture and docs rules (extracted from legacy `AGENTS.md`) |

## Templates

| Template | Use |
|----------|-----|
| [templates/README.template.md](templates/README.template.md) | New or major README rewrite checklist |
| [templates/RFC.template.md](templates/RFC.template.md) | Pointer to canonical RFC template |
| [templates/ADR.template.md](templates/ADR.template.md) | Lightweight architecture decision records |
| [templates/DOCUMENTATION-REVIEW.template.md](templates/DOCUMENTATION-REVIEW.template.md) | Documentation review report |

## Precedence

When instructions conflict:

1. Explicit user / Maintainer instructions for the current task
2. Accepted RFCs and Maintainer-approved policy
3. Root [`AGENTS.md`](../AGENTS.md)
4. Relevant Rules Specs (project-specific `10-…` over generic specs when both apply)
5. Existing maintained docs that match current code
6. External style references (advisory)

Report unresolved conflicts instead of guessing.

## References

- [AGENTS.md format](https://agents.md/)
- [Apache OpenDAL AGENTS.md](https://github.com/apache/opendal/blob/main/AGENTS.md)
- [Diátaxis](https://diataxis.fr/)
- [Google Developer Documentation Style Guide](https://developers.google.com/style)
- [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

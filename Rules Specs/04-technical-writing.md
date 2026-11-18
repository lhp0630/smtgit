# 04 — Technical Writing

## Purpose

Set clear, consistent writing expectations for smtgit documentation without copying an entire external style guide.

## Scope

User-facing and contributor-facing Markdown in this repository.

## Applicable tasks

- Writing or editing docs, README, RFCs, Rules Specs
- Terminology consistency passes

## Normative requirements

1. Prefer precise, direct sentences. Prefer active voice when it improves clarity (Google style influence).
2. Use consistent domain terms defined by the project:
   - `sdepth` — Git-repo nesting scan depth (not filesystem depth)
   - worktree root — directory where `git rev-parse --show-toplevel` equals the normalized path
   - Path scheme C — documented `-p` behavior for worktree vs non-worktree roots
   - `discover_git_repos` — discovery helper that never emits `root` itself
3. Expand uncommon abbreviations on first use in a document.
4. Prefer tables for branched behavior (project convention).
5. Example directory trees MUST match the semantics being explained.
6. Avoid marketing language and unsupported superlatives.
7. When product docs are written in Chinese and governance docs in English, keep each document internally consistent; do not mix languages inside a single normative sentence without need.

## Prohibited behavior

1. MUST NOT redefine `sdepth` as ordinary directory depth.
2. MUST NOT use migration-story names (`_raw_`, `_mapped_`, `_compat_`) in new public docs or APIs.
3. MUST NOT paste large excerpts from external style guides into the repo.

## Required workflow

1. Identify the document’s audience and type ([05-documentation-architecture.md](05-documentation-architecture.md)).
2. Align terminology with code and [`10-smtgit-project-conventions.md`](10-smtgit-project-conventions.md).
3. Prefer short sections and scannable tables over long prose.

## Verification criteria

- Terminology matches code and command docs.
- Examples are internally consistent.
- No unsupported promotional claims.

## References

- [Google Developer Documentation Style Guide](https://developers.google.com/style)
- [Apache OpenDAL documentation style notes](https://github.com/apache/opendal/blob/main/AGENTS.md)

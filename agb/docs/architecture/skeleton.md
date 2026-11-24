# agb architecture skeleton

- **Kind:** Implementation / architecture map (not an RFC; not Maintainer Accept)
- **Date:** 2026-11-24
- **Basis:** [`RFC-DOC-002`](../../../RFCs/RFC-DOC-002-agent-governance-bootstrap.md) (Status: Draft — product Accept still Maintainer-owned)
- **Scope:** Layout + CLI command surface + pack/schema/kit contracts only

## Boundary

```text
smtgit application (smtgit.sh / shared/)   ← untouched by this skeleton
        │
        │  staging only
        ▼
agb/   CLI stubs + pack SSOT layout + schemas + Prompt-only kit skeleton
        │
        ▼  (future, after DOC-002 Accept + Phase 0 extract)
standalone agb repository
```

## Tree

| Path | Role |
|------|------|
| `agb.sh` | Thin CLI entry; dispatch + help |
| `shared/` | log / ui_lang / usage (zh+en) / stub / pack / commands |
| `pack/` | Governance Pack SSOT skeleton + `manifest.yaml` |
| `schemas/` | Example lock / plan / research-review / kit state |
| `kits/prompt-only/` | Prompt-only kit skeleton (§7.8) |
| `prompts/` | Seed Research/RFC prompt drafts (pre-pack) |
| `examples/` | DOC-001 → pack mapping (design inventory) |
| `docs/research/` | agb research triad role |
| `docs/maintenance/reports/` | agb implementation reports |
| `docs/architecture/` | This map |

## Command map (§7.6)

| Command | Skeleton behavior | Phase |
|---------|-------------------|-------|
| `help` / `version` | Implemented; help zh/en per §7.14 (L1) | — |
| `init` `scan` `plan migrate` `validate` `research` `rfc` `pack fetch` `pack emit` | Stub → exit 2 | MVP |
| `plan approve` `apply` `rollback` | Stub → exit 2 | Phase 2+ |
| `update` `doctor` | Stub → exit 2 | Phase 4+ |

## Explicit non-goals of this drop

1. No portable rule body genericization (Phase 0 content).
2. No mutating `init` / `apply` / migration transaction runtime.
3. No change to `smtgit.sh`, `shared/`, or release workflows.
4. No license, remote, or production readiness claims.
5. Bash entry is **staging only**; standalone CLI language remains open (RFC §15).

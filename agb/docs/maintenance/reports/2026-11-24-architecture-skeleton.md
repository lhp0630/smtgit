# Implementation report: agb architecture skeleton

- **Date:** 2026-11-24
- **Related RFC:** RFC-DOC-002 (Draft) — skeleton landed under explicit Maintainer task direction; Draft Status alone is not treated as product Accept
- **Related research:** [`../../research/2026-11-19-repository-governance-bootstrap-tool-research.md`](../../research/2026-11-19-repository-governance-bootstrap-tool-research.md)
- **Question answered:** What did we actually do?

## Summary

Landed an architecture-only skeleton under `agb/`: CLI command surface, pack module layout + manifest, artifact schema examples, and a Prompt-only kit stub. No full MVP behavior and no smtgit application changes.

## Done

1. Added `agb.sh` + `shared/` stubs for all §7.6 commands (`help`/`version` work; others exit 2).
2. Added `pack/manifest.yaml` and per-class placeholders (Examples default off).
3. Added `schemas/*.example.yaml` and `kits/prompt-only/` stage placeholders.
4. Documented map in [`../../architecture/skeleton.md`](../../architecture/skeleton.md); updated `agb/README.md`.

## Not done (deferred)

- Phase 0 pack content genericization from reference origin
- Real `init` / `scan` / `plan` / `validate` / emit-first `research`/`rfc`
- Migration apply transaction, three-way update, multi-adapter parity
- Standalone repository extraction; license / remote decisions

## Verification

```bash
bash agb/agb.sh help
bash agb/agb.sh help validate
bash agb/agb.sh version
# stubs:
bash agb/agb.sh validate; echo exit:$?   # expect 2
bash smtgit.sh help
bash smtgit.sh help pull
```

## Follow-ups for Maintainers

1. Accept / Reject / Defer RFC-DOC-002 when ready.
2. Resolve §15 blocking product decisions before public stable pack.
3. Authorize Phase 0 extract + content fill when appropriate.

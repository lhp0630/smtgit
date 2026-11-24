# Prompt-only kit skeleton (RFC-DOC-002 §7.8)

Independent distribution mode: obtain a pinned kit, run staged prompts, pause/resume via `state.yaml`. Does not require a continuously running agb process or a vendor Agent CLI integration at apply time.

## Required kit contents (design)

| Item | This skeleton |
|------|----------------|
| Pack pin / lock | [`lock.yaml`](lock.yaml) |
| Vendored pack or URL+checksums | Point at `../../pack/` for local staging |
| Staged prompts | [`prompts/`](prompts/) placeholders |
| Schemas | See `../../schemas/` |
| `state.yaml` template | [`state.yaml`](state.yaml) |
| Human README | This file |

## Stages (placeholder order)

1. `00-fetch-verify` — verify pack integrity from lock
2. `10-inventory` — produce inventory
3. `20-plan` — produce immutable plan
4. `30-human-approve` — human gate
5. `40-apply` — apply steps (Phase 2+ automation)
6. `50-validate` — validate
7. `60-report` — migration report under `docs/maintenance/reports/`

`agb pack emit --prompt-only` (stub) will populate a concrete kit directory from a pinned pack version.

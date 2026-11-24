# Stage 00 — Fetch / verify pack

**Skeleton placeholder.** Full Prompt-only stage text ships with `pack emit --prompt-only`.

Instructions (design):

1. Read `lock.yaml` for `pack_version` and checksum.
2. Verify pack integrity (sha256) before any write to the target repository.
3. Record completion in `state.yaml` (`completed_stages`).

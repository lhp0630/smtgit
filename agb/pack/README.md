# Governance Pack (skeleton)

Versioned pack SSOT for agb. Semantic module classes follow RFC-DOC-002 §7.3.

| Directory | Class | Default on `init` |
|-----------|-------|-------------------|
| `core/` | Core Governance | On |
| `workflow/` | Workflow | On (minimal) |
| `prompts/` | Prompt Library | On (MVP subset) |
| `overlay/` | Project Overlay templates | Generated at init |
| `adapters/` | Agent Adapter shims | Opt-in |
| `examples/` | Examples | **Off** |

Manifest: [`manifest.yaml`](manifest.yaml). Product-specific source assets (smtgit Spec `10`, `smtgit.sh`, `docs/pull.md`, …) are **excluded**.

This skeleton holds layout and contracts only — portable file bodies are not copied yet.

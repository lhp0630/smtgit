# 07 — Documentation Review

## Purpose

Provide a repeatable review method and severity model for documentation changes.

## Scope

Reviews of README, `docs/`, RFCs, Rules Specs, and `AGENTS.md`.

## Applicable tasks

- PR review
- Pre-merge self-review by agents
- Governance bootstrap verification

## Normative requirements

### Severity levels

| Level | Meaning | Required action |
|-------|---------|-----------------|
| Blocker | False, misleading, or unsafe | Must fix before complete |
| Major | Important omission or conflict with project behavior | Must fix or explicitly defer with Maintainer note |
| Minor | Clarity / organization / consistency | Should fix |
| Suggestion | Optional improvement | May defer |

### Review checklist

1. Evidence: Are claims backed ([06-fact-checking.md](06-fact-checking.md))?
2. Consistency: Do AGENTS.md, Rules Specs, RFCs, and README agree?
3. Links: Do internal paths resolve?
4. Authority: Does the text preserve Maintainer control of acceptance / release / security?
5. Preservation: Were legacy `AGENTS.md` constraints retained, migrated, or explicitly deprecated?
6. Scope: Did a docs task improperly change application code?
7. Retention: For significant governance, policy migration, or RFC implementation work, is a report retained under `docs/maintenance/reports/` per [`08-document-lifecycle.md`](08-document-lifecycle.md)?

## Prohibited behavior

1. MUST NOT mark review complete while Blockers remain.
2. MUST NOT “resolve” missing Maintainer decisions by inventing policy.

## Required workflow

1. Read the change diff and related authoritative docs.
2. Apply the checklist.
3. File findings by severity using [`templates/DOCUMENTATION-REVIEW.template.md`](templates/DOCUMENTATION-REVIEW.template.md) when a formal review is requested.
4. Fix Blocker/Major issues in-scope before declaring done.

## Verification criteria

- Findings are specific and actionable.
- Severities are assigned consistently.
- Outstanding Maintainer decisions are listed separately from doc defects.

## References

- RFC-DOC-001 Phase 5 review model
- [`08-document-lifecycle.md`](08-document-lifecycle.md)

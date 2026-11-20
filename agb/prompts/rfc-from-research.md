# Prompt draft: Approved Research Task → RFC

- **Feature (design):** `agb rfc` (alias: `agb prompt rfc`)
- **Tool responsibility:** Accept a **review-approved** Research Task (and optional review notes); render this prompt; print/write. **Do not** call an Agent by default unless `--agent` is later specified.
- **Agent responsibility:** Draft an RFC from the Research Task using the project’s RFC template and process.
- **Status:** Draft research artifact for the future agb product (not production CLI output yet)

---

## CLI sketch

```bash
agb rfc --research ./tasks/research-task.md --out ./RFCs/RFC-DRAFT-prompt.md

# after human review annotations
agb rfc --research ./tasks/research-task.md \
  --review-notes ./tasks/research-task.review.md \
  --area GOV --sequence 001
```

**Gate:** Tool SHOULD refuse (or warn loudly) if the Research Task is not marked reviewed/approved via flag or frontmatter, e.g. `--i-approve-research` or YAML `status: approved_for_rfc`.

---

## Rendered prompt template

```markdown
# RFC Authoring Task

You are an RFC Authoring Agent. Follow the repository RFC process and template.

## Authority constraints

- You MAY draft or revise an RFC document.
- You MUST NOT set Status to Accepted, Rejected, Deferred, Implemented, or
  Superseded.
- Initial Status MUST be `Draft` (or `Proposed` only if the user explicitly
  requested submission-ready text **and** local process allows Agents to set
  Proposed — default to `Draft`).
- You MUST NOT fabricate reviewers, consensus, or Maintainer approval.
- Preserve historical integrity: do not delete prior RFCs.

## Preconditions (already satisfied by the human)

- A Research Task was completed and **review-approved** for RFC drafting.
- You must treat the Research Task as the primary requirements input.
- If research and review notes conflict, prefer review notes and list residual
  conflicts under Open questions.

## Approved Research Task

<<<RESEARCH_TASK>>>
{{RESEARCH_TASK_TEXT}}
<<<END_RESEARCH_TASK>>>

## Review notes (optional)

<<<REVIEW_NOTES>>>
{{REVIEW_NOTES_TEXT}}
<<<END_REVIEW_NOTES>>>

## RFC identity hints (optional tool inputs)

- Suggested RFC ID: {{RFC_ID_HINT}}
- Area: {{RFC_AREA_HINT}}
- Title hint: {{RFC_TITLE_HINT}}

## Canonical template and process

If present in the repository, you MUST follow:

1. `RFCs/TEMPLATE.md` (section structure)
2. `RFCs/process.md` (lifecycle and authority)
3. `.agents/rules/03-rfc-writing.md` and `09-community-governance.md`

If those files are missing, use the embedded minimal template compatible with
RFC-DOC-001 / smtgit `RFCs/TEMPLATE.md` structure: Summary, Context/Problem,
Motivation, Goals, Non-goals, Constraints, Proposed design, Alternatives,
Trade-offs, Compatibility, Security, Testing/validation, Rollout, Risks,
Open questions, References.

## Your job

1. Read the Research Task thoroughly.
2. Draft a complete RFC Markdown file that a Maintainer can review.
3. Map research findings into RFC sections; do not paste the Research Task
   wholesale without restructuring.
4. Include at least one meaningful alternative when design choices exist.
5. Mark unknowns explicitly; do not invent repository facts.
6. State Non-goals clearly, especially “no implementation in this RFC” when
   the research was design-only.

## Output

- Write the RFC body as Markdown.
- Recommend a file path such as `RFCs/RFC-<AREA>-<NNN>-kebab-title.md`.
- Append a short checklist: template coverage, alternatives present, status
  left as Draft, open questions listed.
```

## Placeholder contract

| Placeholder | Source |
|-------------|--------|
| `{{RESEARCH_TASK_TEXT}}` | `--research` file (required) |
| `{{REVIEW_NOTES_TEXT}}` | `--review-notes` or “(none)” |
| `{{RFC_ID_HINT}}` | `--id` / derived from `--area`+`--sequence` / “TBD by Maintainer” |
| `{{RFC_AREA_HINT}}` | `--area` or “TBD” |
| `{{RFC_TITLE_HINT}}` | `--title` or derived from Research Task title |

## Acceptance for the tool feature

- Requires explicit research input file.
- Encourages/requires human approval gate before emit.
- Output is an Agent prompt, not an auto-committed RFC.
- Aligns with human-final authority over RFC acceptance.

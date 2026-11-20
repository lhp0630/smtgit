# Prompt draft: Idea → Research Task

- **Feature (design):** `agb research` (alias: `agb prompt research`)
- **Tool responsibility:** Read user idea text + optional context files; render this prompt with filled placeholders; print to stdout / write a file. **Do not** call an Agent by default unless `--agent` is later specified.
- **Agent responsibility:** Execute the rendered Research Task; produce a reviewable Research Task document.
- **Status:** Draft research artifact for the future agb product (not production CLI output yet)

---

## CLI sketch

```bash
# stdin
echo "We should productize our agent rules for other repos" | agb research

# file
agb research --idea ./notes/fuzzy-idea.md --out ./tasks/research-task.md

# with repo hints
agb research --idea idea.txt --context AGENTS.md --context README.md
```

Tool output = the filled prompt below (plus a short human preamble: “Paste this into your Agent”).

---

## Rendered prompt template

```markdown
# Research Task

You are a Documentation / Product Research Agent working under the repository’s
governance rules (read `AGENTS.md` and the relevant `.agents/rules` specs first
if they exist).

## Authority constraints

- You MAY research, inventory evidence, compare alternatives, and draft designs.
- You MUST NOT mark RFCs Accepted, invent licenses/tests/security guarantees, or
  claim Maintainer approval.
- You MUST distinguish **Verified facts**, **Survey findings**, **Design proposals**,
  and **Open assumptions**.
- You MUST NOT start product implementation unless the Research Task explicitly
  authorizes an implementation phase (this task does not).

## User idea (raw input)

<<<IDEA>>>
{{IDEA_TEXT}}
<<<END_IDEA>>>

## Optional context provided by the user / tool

{{CONTEXT_EXCERPTS}}

## Your job

Turn the raw idea into a **complete, executable Research Task document** that
another human or Agent can follow without guessing the author’s intent.

## Required Research Task structure

Produce a Markdown document with at least these sections:

1. Title
2. Background / problem context
3. Research goals
4. Non-goals / task boundary (what must not be built or changed yet)
5. Scope of repository or system under study
6. Evidence gathering method (which paths, commands, external docs to check)
7. External references to investigate (if any)
8. Design questions that must be answered
9. Required deliverables (files, diagrams, inventories, comparisons)
10. Acceptance / completion checklist
11. Risks and open Maintainer decisions
12. Suggested follow-on (e.g. whether an RFC should be drafted after review)

## Quality bar

- Make fuzzy goals concrete and testable.
- Prefer repository evidence over speculation.
- If the idea implies a product, state whether work belongs in the current repo
  or a new repository.
- If information is missing, list explicit questions instead of inventing answers.
- Keep the Research Task actionable: a later Agent should know exactly what to
  produce and what not to touch.

## Output

Return only the Research Task Markdown document (no implementation code).
```

## Placeholder contract

| Placeholder | Source |
|-------------|--------|
| `{{IDEA_TEXT}}` | User stdin/file (required) |
| `{{CONTEXT_EXCERPTS}}` | Optional `--context` files, truncated with paths cited; or “(none)” |

## Acceptance for the tool feature

- Deterministic render for the same inputs.
- Never silently drops the user’s idea text.
- Emits prompt even when no Agent CLI is installed.

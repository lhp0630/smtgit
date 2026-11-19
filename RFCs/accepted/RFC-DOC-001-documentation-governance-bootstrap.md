# RFC: Establish a Documentation Governance System for AI-Assisted Open-Source Project Maintenance

- **RFC ID:** RFC-DOC-001
- **Title:** Documentation Governance Bootstrap
- **Status:** Accepted
- **Accepted:** 2026-11-19
- **Accepted-by:** Project Maintainers
- **Type:** Process / Documentation Architecture
- **Target Audience:** Project Maintainers, Contributors, AI Coding Agents
- **Primary Language:** English
- **Agent Compatibility:** Agent-neutral (Codex, Claude Code, Cursor, GitHub Copilot, OpenCode, and other compatible agents)
- **Author:** Project Maintainers
- **Date:** 2026-11-18

---

## 1. Summary

This RFC proposes establishing a comprehensive, maintainable, and agent-neutral documentation governance system for an open-source software repository.

The system will enable AI Coding Agents to act as responsible documentation maintainers, capable of researching, drafting, reviewing, validating, and maintaining project documentation.

The implementation MUST produce four primary deliverables:

1. **AGENTS.md** — A unified entry point defining agent responsibilities, repository instructions, documentation workflows, and governance boundaries.
2. **README.md** — The project's public-facing introduction, providing accurate project information, installation instructions, and a practical quick start.
3. **RFCs/** — A structured RFC governance system, including RFC authoring rules, templates, lifecycle conventions, and decision-making procedures.
4. **Rules Specs/** — A comprehensive set of documentation agent rules covering repository understanding, technical writing, documentation architecture, fact-checking, review, and lifecycle management.

The Agent MUST research established open-source projects and authoritative documentation standards before drafting these deliverables.

The objective is not merely to generate documents, but to establish a documentation system that remains accurate, consistent, discoverable, and maintainable as the project evolves.

## 2. Motivation

Open-source projects frequently suffer from documentation problems:

- README content becomes inconsistent with actual implementation.
- Technical documentation contains unsupported assumptions.
- RFCs describe solutions without adequately explaining alternatives and trade-offs.
- Different contributors use inconsistent terminology and writing styles.
- Documentation structure becomes difficult to navigate.
- AI-generated documentation introduces plausible but incorrect technical claims.
- Project decisions are not preserved as reliable historical records.
- Different AI agents follow inconsistent instructions.

A conventional README or a collection of prompts cannot adequately address these problems.

We need a repository-level governance system that establishes:

- Consistent documentation responsibilities.
- Explicit evidence requirements.
- Standardized document structures.
- Repeatable authoring and review workflows.
- Clear decision-making authority.
- Cross-agent compatibility.
- Long-term documentation maintenance practices.

## 3. Goals

This RFC establishes the following goals.

### 3.1 Documentation governance

Define a unified documentation governance model that AI agents and human contributors can follow.

### 3.2 Agent interoperability

Use plain Markdown as the canonical rule format and minimize dependencies on proprietary agent-specific features.

### 3.3 Evidence-driven documentation

Ensure that technical claims are supported by repository evidence, including source code, tests, configurations, specifications, and accepted design decisions.

### 3.4 Consistent technical writing

Establish English technical writing conventions suitable for an international open-source developer community.

### 3.5 Structured RFC processes

Provide a consistent mechanism for proposing, discussing, evaluating, accepting, rejecting, and recording technical design decisions.

### 3.6 Maintainability

Make the documentation system easy to extend, review, and maintain without duplicating rules across different files.

## 4. Non-Goals

This RFC does not intend to:

- Replace the project's existing technical architecture.
- Modify application source code or public APIs.
- Introduce new product features.
- Automatically approve or merge RFCs.
- Allow AI agents to make binding project governance decisions.
- Force every project to adopt an identical documentation directory structure.
- Reproduce entire external writing guides inside the repository.
- Require a particular commercial AI agent or model.
- Rewrite all existing documentation without first evaluating its relevance and accuracy.

## 5. Reference Sources and Research Requirements

Before implementation, the Agent MUST investigate the following reference sources.

These references serve different purposes. They MUST NOT be treated as interchangeable or blindly copied.

### 5.1 Agent instruction standards

**Primary reference: AGENTS.md**

- Official website: https://agents.md/
- GitHub: https://github.com/agentsmd/agents.md

Purpose:

- Repository-level agent instructions.
- Agent behavior constraints.
- Project context and workflow definitions.
- Hierarchical instruction organization.

Expected adoption:

- Use AGENTS.md as the canonical repository entry point.
- Keep the primary instructions concise and actionable.
- Reference specialized rule files rather than placing every instruction in one oversized file.
- Do not assume that every agent automatically discovers nested rule directories.

### 5.2 Open-source agent governance and documentation practices

**Primary reference: Apache OpenDAL**

- Repository: https://github.com/apache/opendal
- Agent instructions: https://github.com/apache/opendal/blob/main/AGENTS.md

Purpose:

- Real-world repository-level agent instructions.
- Documentation consistency with implementation.
- Contribution quality requirements.
- Technical terminology and documentation conventions.
- Human review of AI-assisted contributions.

Expected adoption:

- Study how the repository expresses concrete engineering constraints.
- Examine its documentation organization and contribution workflow.
- Identify applicable rules for preventing unsupported technical claims.
- Adapt useful practices to the target project's architecture and conventions.

Do not copy OpenDAL-specific implementation or project policies.

### 5.3 RFC governance and proposal structure

**Primary reference: Kubernetes Enhancement Proposals (KEP)**

- Repository: https://github.com/kubernetes/enhancements
- KEP process: https://github.com/kubernetes/enhancements/blob/master/keps/README.md
- KEP templates: https://github.com/kubernetes/enhancements/tree/master/keps

Purpose:

- RFC lifecycle management.
- Proposal structure.
- Design review.
- Goals and non-goals.
- Risks and mitigations.
- Testing and graduation criteria.
- Implementation and compatibility planning.

Expected adoption:

- Establish a clear RFC lifecycle.
- Provide a structured proposal template.
- Require explicit design goals and non-goals.
- Include testing, compatibility, rollout, and risk analysis.
- Distinguish proposal acceptance from implementation completion.

### 5.4 Technical design reasoning

**Primary reference: Rust RFCs**

- Repository: https://github.com/rust-lang/rfcs
- RFC Book: https://rust-lang.github.io/rfcs/

Purpose:

- Technical argumentation.
- Alternative design analysis.
- Explicit trade-offs.
- Community discussion.
- Historical integrity of accepted proposals.

Expected adoption:

- Require meaningful alternatives.
- Explain why a particular proposal is preferable.
- Document disadvantages and limitations.
- Preserve accepted decisions as historical records.
- Use new or superseding proposals for significant design changes.

### 5.5 Documentation information architecture

**Primary reference: Diátaxis**

- Website: https://diataxis.fr/

Purpose:

- Documentation categorization.
- Reader-oriented information architecture.
- Separation of tutorials, how-to guides, references, and explanations.

Expected adoption:

Organize project documentation around four content types:

1. Tutorials.
2. How-to guides.
3. Reference documentation.
4. Explanation documentation.

Do not force an existing repository into an unnecessary new directory structure.

### 5.6 English technical writing

**Primary reference: Google Developer Documentation Style Guide**

- Website: https://developers.google.com/style

Purpose:

- English technical writing.
- Clarity and conciseness.
- Terminology consistency.
- Grammar and editorial conventions.
- Accessibility and inclusive language.

Expected adoption:

- Use clear, precise English.
- Prefer active voice where appropriate.
- Avoid unsupported marketing language.
- Use consistent technical terminology.
- Explain uncommon abbreviations.
- Follow the target project's existing writing conventions when they are authoritative.

Do not duplicate the entire Google style guide.

### 5.7 Open-source community documentation

**Primary reference: GitHub Open Source Guides**

- Website: https://opensource.guide/
- Repository: https://github.com/github/opensource.guide

Purpose:

- README structure.
- Contribution documentation.
- Community participation.
- Open-source project communication.

Expected adoption:

- Make the README useful to first-time visitors.
- Provide clear contribution entry points.
- Link to relevant governance and community policies.
- Distinguish project introduction from contributor documentation.

### 5.8 Changelog management

**Primary reference: Keep a Changelog**

- Website: https://keepachangelog.com/en/1.1.0/

Purpose:

- Changelog organization.
- User-visible change descriptions.
- Release history.

Expected adoption:

- Follow the project's existing release policy.
- Keep released and unreleased changes distinct.
- Avoid fabricating release information.

## 6. Target Repository Investigation

Before generating any deliverables, the Agent MUST inspect the target repository.

The Agent MUST NOT assume that the target project has the same architecture, conventions, or governance model as the reference projects.

### 6.1 Repository reconnaissance

Inspect the following where available:

- Existing README files.
- Existing AGENTS.md or equivalent agent instructions.
- Source code and package structure.
- Tests and examples.
- Build and CI configurations.
- Dependency manifests.
- API definitions and schemas.
- Existing RFCs and ADRs.
- Architecture documentation.
- CONTRIBUTING.md.
- CODE_OF_CONDUCT.md.
- LICENSE.
- SECURITY.md.
- CHANGELOG or release notes.
- Existing documentation websites and navigation.

### 6.2 Evidence requirements

For every material technical claim, identify its supporting evidence.

Prioritize:

1. Current source code and tests.
2. Accepted technical specifications and design decisions.
3. Official release notes.
4. Maintainer-authored documentation.
5. Relevant issues, pull requests, and discussions.
6. External references as supplementary information.

If sources conflict, report the discrepancy.

Do not silently resolve contradictions by guessing.

### 6.3 Repository context report

Before drafting, create a temporary investigation report containing:

- Project purpose and target audience.
- Main technical capabilities.
- Architecture overview.
- Main components and dependencies.
- Supported platforms and versions.
- Installation and execution requirements.
- Existing documentation structure.
- Existing design decisions.
- Documentation gaps and inconsistencies.
- Unresolved technical questions.

The report MUST distinguish verified information from assumptions and unknowns.

Do not commit temporary investigation artifacts unless requested.

## 7. Required Deliverables

The Agent MUST produce the following four primary deliverables.

### 7.1 Deliverable A: AGENTS.md

**Purpose**

Establish the unified instruction entry point for AI Coding Agents.

**Reference sources**

- AGENTS.md official standard.
- Apache OpenDAL AGENTS.md.
- Target repository's existing agent instructions.
- Target repository's CONTRIBUTING.md and governance policies.

**Required content**

1. Agent role and responsibilities.
2. Repository understanding requirements.
3. Documentation accuracy requirements.
4. Source-of-truth hierarchy.
5. Documentation writing conventions.
6. RFC authoring and review requirements.
7. Documentation validation requirements.
8. Human approval requirements.
9. Applicable specialized rules.
10. Conflict resolution and instruction precedence.

**Important constraints**

- Keep AGENTS.md concise.
- Avoid duplicating specialized rules.
- Explicitly reference applicable Rules Specs files.
- Make instructions executable and unambiguous.
- Preserve existing project-specific instructions unless they are demonstrably obsolete or contradictory.

**Acceptance criteria**

- A compatible Coding Agent can identify its responsibilities.
- Required research and validation steps are explicit.
- Specialized rules can be located.
- Human Maintainer authority is preserved.
- No project-specific facts are invented.

### 7.2 Deliverable B: README.md

**Purpose**

Create or improve the public-facing project introduction.

**Reference sources**

- GitHub Open Source Guides.
- Apache OpenDAL README and documentation.
- Google Developer Documentation Style Guide.
- Diátaxis.
- Target repository's actual source code, tests, examples, and package metadata.

**Required content**

Adapt the following structure to the project:

1. Project name.
2. Concise project description.
3. Problem statement and intended audience.
4. Key features.
5. Project status or maturity, if verified.
6. Installation requirements.
7. Installation instructions.
8. Quick Start.
9. Configuration and common usage.
10. Examples.
11. Documentation links.
12. Contribution instructions.
13. Security information, if available.
14. License information.

**Important constraints**

- Explain the problem before implementation details.
- Prioritize a runnable Quick Start.
- Validate commands and code examples.
- Avoid unsupported performance or superiority claims.
- Do not invent project status, community metrics, badges, or compatibility guarantees.
- Avoid duplicating detailed API and architecture documentation.
- Use the project's actual license and contribution policy.

**Acceptance criteria**

A new developer should be able to:

- Understand what the project does.
- Determine whether it fits their use case.
- Identify prerequisites.
- Follow the Quick Start.
- Find further documentation.
- Understand how to contribute.

### 7.3 Deliverable C: RFCs/

**Purpose**

Establish a standardized technical proposal and decision-recording system.

**Reference sources**

- Kubernetes KEP.
- Rust RFC.
- Target repository's existing RFCs, ADRs, issues, discussions, and governance procedures.

**Required structure**

The Agent MUST establish an RFC directory appropriate to the repository.

Recommended structure:

```text
RFCs/
├── README.md
├── TEMPLATE.md
├── process.md
├── accepted/
├── rejected/
├── deferred/
└── superseded/
```

The directory names may be adapted to existing repository conventions.

**RFCs/README.md**

Must explain:

- What an RFC is.
- When an RFC is required.
- How to propose an RFC.
- How to review an RFC.
- How decisions are made.
- How accepted RFCs are maintained.
- How implemented decisions are tracked.

**RFCs/TEMPLATE.md**

Must include, where applicable:

1. RFC ID.
2. Title.
3. Status.
4. Authors.
5. Creation and update dates.
6. Summary.
7. Context and problem statement.
8. Motivation.
9. Goals.
10. Non-goals.
11. Constraints and assumptions.
12. Proposed design.
13. Alternatives considered.
14. Trade-off analysis.
15. Compatibility and migration.
16. Security and privacy.
17. Testing and validation.
18. Rollout and rollback.
19. Risks and mitigations.
20. Open questions.
21. References.

**RFC lifecycle**

Define the project's actual lifecycle.

If no existing lifecycle exists, propose a model such as:

```text
Draft
  |
  v
In Review
  |
  +------> Rejected
  |
  +------> Deferred
  |
  v
Accepted
  |
  v
In Progress
  |
  v
Implemented
  |
  +------> Superseded
```

The exact statuses and transitions MUST be approved by project Maintainers.

**Important constraints**

- An AI-generated RFC is never automatically accepted.
- A merged PR does not necessarily imply that an RFC was accepted.
- Accepted RFCs must preserve historical decision integrity.
- Significant design changes should follow an explicit amendment or superseding RFC process.
- The Agent must not invent reviewers, approvals, or community consensus.

**Acceptance criteria**

- A contributor can understand how to propose a design.
- Reviewers can evaluate the proposal systematically.
- Alternatives and trade-offs are explicit.
- Decision status is unambiguous.
- Accepted and superseded decisions remain traceable.

### 7.4 Deliverable D: Rules Specs/

**Purpose**

Define the detailed responsibilities, workflows, and quality requirements of Documentation Maintainer Agents.

**Reference sources**

- AGENTS.md.
- Apache OpenDAL AGENTS.md.
- Kubernetes KEP.
- Rust RFC.
- Diátaxis.
- Google Developer Documentation Style Guide.
- GitHub Open Source Guides.
- Keep a Changelog.
- Target repository-specific documentation and governance policies.

**Recommended structure**

```text
Rules Specs/
├── README.md
├── 00-maintainer-principles.md
├── 01-repository-understanding.md
├── 02-readme-writing.md
├── 03-rfc-writing.md
├── 04-technical-writing.md
├── 05-documentation-architecture.md
├── 06-fact-checking.md
├── 07-documentation-review.md
├── 08-document-lifecycle.md
├── 09-community-governance.md
└── templates/
    ├── README.template.md
    ├── RFC.template.md
    ├── ADR.template.md
    └── DOCUMENTATION-REVIEW.template.md
```

This is a logical structure, not a mandatory filesystem name. The Agent MUST respect existing repository naming conventions.

**Rules specifications**

Each rules file MUST define:

- Purpose.
- Scope.
- Applicable tasks.
- Normative requirements.
- Prohibited behavior.
- Required workflow.
- Verification criteria.
- Expected output, where applicable.

Use clear normative language:

- MUST: mandatory requirement.
- MUST NOT: prohibited behavior.
- SHOULD: strong recommendation.
- SHOULD NOT: discouraged behavior.
- MAY: optional behavior.

Avoid vague instructions such as "write good documentation" without explaining measurable expectations.

**Required rule responsibilities**

| Rules Spec | Responsibilities |
|---|---|
| Maintainer Principles | Role, authority, constraints |
| Repository Understanding | Research and context gathering |
| README Writing | README structure and validation |
| RFC Writing | Proposal quality and lifecycle |
| Technical Writing | English writing and terminology |
| Documentation Architecture | Diátaxis and navigation |
| Fact Checking | Evidence and technical accuracy |
| Documentation Review | Quality assurance and severity |
| Document Lifecycle | Versioning and historical integrity |
| Community Governance | Human authority and public communication |

**Acceptance criteria**

- Rules are independently understandable.
- Rules do not contradict AGENTS.md.
- External standards are referenced rather than unnecessarily duplicated.
- Project-specific rules are separated from generic rules.
- All rules are actionable and testable.
- No unnecessary duplication exists between rule files.

## 8. Cross-Document Consistency

The four deliverables MUST be treated as one integrated system.

The Agent MUST verify the following relationships:

| Component | Must remain consistent with |
|---|---|
| AGENTS.md | Rules Specs/, repository governance |
| README.md | Actual implementation, examples, package metadata |
| RFCs/README.md | RFC process and governance |
| RFCs/TEMPLATE.md | RFC Writing Rules |
| Rules Specs/ | AGENTS.md and external references |
| Documentation templates | Corresponding Rules Specs |
| Documentation policy | Repository conventions and accepted decisions |

Specific requirements:

1. AGENTS.md must point to the correct Rules Specs files.
2. README documentation links must point to actual documents.
3. RFC process documentation must agree with the RFC template.
4. RFC lifecycle definitions must agree with the project's governance policy.
5. Documentation terminology must be consistent across all deliverables.
6. No document may describe a proposed capability as an implemented capability.
7. Existing authoritative project policies must not be contradicted.

## 9. Implementation Workflow

The Agent MUST execute the work in the following phases.

### Phase 1: Discovery

- Inspect the target repository.
- Read existing instructions and documentation.
- Identify authoritative technical evidence.
- Research the external reference sources.
- Record existing conventions and unresolved questions.

Output:

- Repository investigation report.
- Reference-source mapping.
- Documentation gap analysis.

### Phase 2: Design

- Propose the documentation directory structure.
- Define document responsibilities.
- Define rule hierarchy.
- Identify project-specific policies.
- Identify decisions requiring Maintainer approval.

Output:

- Proposed documentation architecture.
- Deliverable outline.
- Outstanding decisions list.

### Phase 3: Drafting

Create:

- AGENTS.md.
- README.md.
- RFCs/README.md.
- RFCs/TEMPLATE.md.
- RFCs/process.md.
- Rules Specs/README.md.
- All required Rules Specs files.
- Supporting templates.

Do not fabricate project-specific information.

### Phase 4: Verification

Perform the following checks:

**Structure checks**

- All required files exist.
- Internal links resolve.
- Cross-references are correct.
- Templates follow the documented process.

**Technical checks**

- Commands are verified where practical.
- Code examples match the implementation.
- API and configuration names are correct.
- Compatibility claims are supported.
- Project status and license information are verified.

**Governance checks**

- RFC statuses are defined.
- Decision authority is explicit.
- Human approval requirements are preserved.
- Existing policies are respected.

**Writing checks**

- English grammar and readability.
- Consistent terminology.
- Correct Markdown structure.
- No unsupported marketing claims.
- No contradictory instructions.

### Phase 5: Review

Perform a final independent review of all deliverables.

Use the following severity levels:

- Blocker: materially false, misleading, or unsafe documentation.
- Major: important omissions or conflicts with project behavior.
- Minor: clarity, organization, or consistency issues.
- Suggestion: optional improvements.

Fix Blocker and Major findings before declaring the implementation complete.

### Phase 6: Reporting

Produce a final implementation report containing:

- Files created or modified.
- Reference sources consulted.
- Repository evidence inspected.
- Validation commands executed.
- Validation results.
- Unresolved questions.
- Maintainer approvals required.
- Known limitations.

## 10. Repository and Governance Constraints

The Agent MUST follow these constraints:

1. Do not modify application source code as part of this RFC unless explicitly requested.
2. Do not delete existing documentation without identifying its purpose and dependencies.
3. Do not overwrite existing RFCs or accepted decisions.
4. Do not silently change project contribution or release policies.
5. Do not invent project-specific technical facts.
6. Do not create false badges, metrics, benchmark results, or compatibility statements.
7. Do not automatically publish documentation or submit public communications.
8. Do not mark an RFC as Accepted without authorization.
9. Preserve the project's license and attribution requirements.
10. Report any conflict between proposed documentation governance and existing project policy.

When a necessary governance decision cannot be inferred from repository evidence, create a clearly identified proposal and request human Maintainer approval.

## 11. Validation and Definition of Done

The implementation is complete only when all of the following conditions are met.

### Required files

- [ ] AGENTS.md exists and is actionable.
- [ ] README.md accurately represents the project.
- [ ] RFCs/README.md exists.
- [ ] RFCs/TEMPLATE.md exists.
- [ ] RFCs/process.md exists.
- [ ] Rules Specs/README.md exists.
- [ ] All ten Rules Specs files exist.
- [ ] Required supporting templates exist.

### Quality

- [ ] Every material technical claim has evidence or is explicitly qualified.
- [ ] All four deliverables are mutually consistent.
- [ ] External references are correctly attributed and linked.
- [ ] No fabricated project capabilities exist.
- [ ] All generated examples and commands have a verification status.
- [ ] RFC lifecycle and decision authority are unambiguous.
- [ ] Rules are compatible with the intended agent-neutral Markdown approach.
- [ ] Existing project conventions have been respected.

### Governance

- [ ] Human Maintainer approval requirements are documented.
- [ ] No AI-generated decision is represented as an approved project decision.
- [ ] Outstanding questions are explicitly reported.

### Final recommendation

The Agent must classify the result as one of:

- **Ready for Maintainer Review:** All required deliverables and checks are complete.
- **Needs Maintainer Input:** The structure is complete, but policy or technical decisions remain unresolved.
- **Incomplete:** Required deliverables or essential validation are missing.

The Agent MUST NOT claim that the system has been officially adopted or approved unless the authorized Maintainers have confirmed it.

## 12. Future Considerations

The following improvements may be considered separately after the initial implementation:

- Automated Markdown linting.
- Automated link checking.
- Documentation build validation.
- API documentation generation.
- RFC metadata validation.
- Documentation freshness checks.
- CI checks for documentation/source consistency.
- Automated glossary consistency checks.
- Dedicated documentation review agents.
- Multi-agent workflows for independent technical and editorial review.

These enhancements are not required for the initial implementation.

## 13. Decision Requested

Project Maintainers are requested to review and approve the following:

1. Adoption of a unified, agent-neutral documentation governance system.
2. The proposed four-part documentation architecture.
3. The external reference-source selection.
4. The proposed RFC structure and lifecycle.
5. The Documentation Maintainer Rules Specs.
6. The human approval and governance boundaries.

Upon approval, the Agent may execute the implementation workflow described in this RFC.

---

## Appendix A: Reference-to-Deliverable Mapping

| Deliverable | Primary references | Repository evidence |
|---|---|---|
| AGENTS.md | AGENTS.md, OpenDAL | Existing instructions and governance |
| README.md | GitHub Guides, Google Style Guide, Diátaxis | Source, tests, examples, metadata |
| RFCs/ | Kubernetes KEP, Rust RFC | Existing proposals and decisions |
| Rules Specs/ | AGENTS.md, OpenDAL, Diátaxis, Google Style Guide | Existing documentation and contribution policy |

## Appendix B: Implementation Philosophy

This RFC adopts five principles:

1. **Evidence before assertion:** Technical documentation must reflect verifiable project behavior.
2. **Governance before automation:** Agents assist maintainers; they do not replace project authority.
3. **Consistency before duplication:** Maintain one authoritative source for each important rule or fact.
4. **Reader needs before document volume:** Every document must have a clear audience and purpose.
5. **Human accountability:** AI-generated documentation remains subject to human review and approval.

These principles apply to every deliverable produced under this RFC.

## Appendix C: Normative Language

The terms MUST, MUST NOT, SHOULD, SHOULD NOT, and MAY are to be interpreted as normative requirement levels within this RFC.

Where repository-specific governance conflicts with this RFC, the existing authorized project governance takes precedence until the conflict is resolved by Maintainers.

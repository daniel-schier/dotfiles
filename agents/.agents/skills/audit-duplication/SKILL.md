---
name: audit-duplication
description: >
  Audits a codebase for duplication: structural clones, exact and near
  duplicates, and duplicated data or literals. Prefers a clone-detection
  tool and interprets its output. Use when explicitly asked for a
  duplication, clone, or copy-paste review.
argument-hint: "[path-or-scope]"
agent: auditor
disable-model-invocation: true
---

# Duplication audit

Audit duplication in **$ARGUMENTS** (if no path or scope is given, the whole
project). Tag each finding's Category as `Structural`, `Exact/Near`, or `Data`.

| Category | What it is |
|---|---|
| `Structural` | Same logic or shape, written independently. Parallel control flow, copy-paste with renamed identifiers, semantic clones. |
| `Exact/Near` | Identical blocks (exact) or blocks differing only by small edits (near). Classic copy-paste. |
| `Data` | Repeated literals, magic values, duplicated fixtures or config, repeated data structures. |

## Prefer a tool

Duplication detection by reading alone is unreliable: recall across a large
codebase is partial and clones drift out of attention. Use a clone-detection
tool whenever one fits the codebase.

1. Identify the language and pick a detector:
   - Go: `dupl`, also available as a `golangci-lint` linter. For repeated
     literals, `goconst`.
   - Multi-language: `jscpd` or PMD CPD (Copy/Paste Detector). Both take a
     configurable similarity threshold for near-duplicates.
2. If the tool is installed, run it over the scope and interpret the output.
3. If the tool is not installed, recommend it, give the install command, and
   ask the user to install it. Do not install it yourself. Once it is
   installed, run it and interpret the output.
4. If no tool fits the codebase, decide whether a manual review is worthwhile.
   If you proceed manually, state plainly in the report that recall is partial:
   this is a smell-finder, not a complete clone census.

## Interpret, do not just relay

Tools over-report. A raw clone list is not an audit.

- Exclude vendored dependencies, generated code, and usually test fixtures and
  table-driven test data before judging.
- Rank findings by risk, not by count. Duplicated business logic across
  modules is high severity; a repeated three-line guard is often acceptable.
- For each kept finding, name the locations, the category, and a concrete
  consolidation: extract a shared function, lift a common type, introduce a
  constant.

## Data duplication and conventions

This audit detects duplicated data and reports it as a finding. It does not
restate the fix rule. Where a language convention already governs the
remediation (for example, the Go convention's "extract to named constants"
rule), point at that convention rather than re-deriving the rule here. One
source of truth for the rule; this skill for the detection.

## Report

Use the worst finding to justify the report's **Overall rating**: weigh how
widespread the duplication is and how risky the duplicated code is to maintain
in parallel.

Format the report using the template at
`${CLAUDE_SKILL_DIR}/../../templates/audit.md`. Write it to
`audits/duplication-<YYYY-MM-DD>.md`.

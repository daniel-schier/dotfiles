---
name: audit-code-quality
description: >
  Audits code quality metrics: cyclomatic and cognitive complexity, size
  metrics, coupling, and cohesion. Use when explicitly asked for a code-quality
  or complexity review.
argument-hint: "[path-or-scope]"
agent: auditor
disable-model-invocation: true
---

# Code quality audit

Audit the code quality of **$ARGUMENTS** (if no path or scope is given, the
whole project). Tag each finding's Category as `Complexity`, `Size`,
`Coupling`, or `Cohesion`.

## Cyclomatic complexity

- Functions with complexity > 10, deep nested if/else, and complex switch
  statements.

## Cognitive complexity

- How hard the code is to follow: nested loops and conditions, recursion, and
  mixed levels of abstraction.

## Size metrics

- Functions over 50 lines, files over 300 lines, classes over 500 lines. Flag
  split candidates.

## Coupling

- Afferent coupling (dependents on a module), efferent coupling (a module's
  dependencies), and instability index. Identify tightly coupled modules.

## Cohesion

- Are related functions grouped together? Single-responsibility adherence and
  module focus clarity.

Provide specific refactoring recommendations for the most complex areas. Use
the worst complexity/cohesion you find to justify the report's
**Overall rating**.

Format the report using the template at
`${CLAUDE_SKILL_DIR}/../../templates/audit.md`. Write it to
`audits/code-quality-<YYYY-MM-DD>.md`.

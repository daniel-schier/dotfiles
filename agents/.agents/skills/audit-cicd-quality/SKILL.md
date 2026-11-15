---
name: audit-cicd-quality
description: >
  Audits CI/CD pipeline definitions and config for structure, conventions,
  missing tooling, test integration, build/artifact quality, deployment, and
  maintainability. Tool-agnostic. Use when explicitly asked for a CI/CD or
  pipeline review.
argument-hint: "[path-or-scope]"
agent: auditor
disable-model-invocation: true
---

# CI/CD quality audit

Audit the CI/CD setup of **$ARGUMENTS** (if no path or scope is given, examine
all pipeline definitions, workflow files, and related configuration in the
project). Be tool-agnostic: do not assume GitHub Actions, GitLab CI, Jenkins,
or any specific platform. Tag each finding's Category with the relevant heading
below.

## Pipeline structure

- Logical stage separation (build, test, lint, deploy); missing or redundant
  stages; stages doing too much or too little; parallel vs. sequential
  execution where appropriate.

## Conventions and consistency

- Consistent naming of jobs, stages, and variables; reuse of templates,
  anchors, or shared config; DRY violations (repeated job definitions that
  should be extracted); inconsistent formatting or style across files.

## Missing tooling

- No lint stage or linter config; no SAST/static analysis; no dependency (SCA)
  scanning; no test-coverage reporting; no artifact generation or publishing
  where expected.

## Test integration

- Tests present but not wired into the pipeline; missing unit/integration/e2e
  stages; failures not blocking the pipeline; missing or inconsistent test
  reporting.

## Build and artifact quality

- No versioning or tagging of artifacts; missing or inconsistent retention
  policies; fragile or environment-dependent build steps; missing dependency
  or build-output caching.

## Environment and deployment

- No dev/staging/prod separation; missing approval gates before production; no
  rollback mechanism or strategy; non-idempotent deployment steps.

## Maintainability

- Overly complex or deeply nested logic; hardcoded values that should be
  variables or parameters; missing comments/docs for non-obvious steps;
  outdated or deprecated syntax.

Format the report using the template at
`${CLAUDE_SKILL_DIR}/../../templates/audit.md`. Write it to
`audits/cicd-quality-<YYYY-MM-DD>.md`.

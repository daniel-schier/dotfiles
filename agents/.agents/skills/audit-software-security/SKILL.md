---
name: audit-software-security
description: >
  Security audit: maps the project's structure and attack surface, then
  reports vulnerabilities with CWE, exploitability, and prioritized fixes. Use
  when explicitly asked for a security review or audit.
argument-hint: "[path-or-scope]"
agent: auditor
disable-model-invocation: true
---

# Security audit

Audit the security of **$ARGUMENTS** (if no path or scope is given, the whole
project).

## Map the attack surface first

Identify: entry points (e.g. app.js, server.js), routes and endpoints, the
middleware chain and its order, external service integrations, database
connection points, the authentication/authorization flow, file-upload
handling, and rate-limiting. Begin from the dependency manifest (e.g.
package.json) to check for vulnerable dependencies, then the main
server/middleware config, then everything in routes/ and middleware/.

Tag each finding's Category with the relevant area (e.g. `AuthN/Z`,
`Input validation`, `Dependencies`, `Config`, `Upload`, `Rate limiting`).

## Format

Format the report using the template at
`${CLAUDE_SKILL_DIR}/../../templates/audit.md`. On top of that template, add
the security-specific fields and sections below.

For EACH finding, add these two fields:

- **CWE:** the CWE id(s) where applicable.
- **Exploitability:** how it could be exploited and, only where safe, a minimal
  PoC or reproduction steps. Never include real secrets.

After the findings, add these sections:

- **## Risk score** — an overall 0-10 risk score with a one-line rationale.
- **## Top fixes** — the 3-5 fixes that reduce risk fastest, in priority
  order.
- **## Checklist** — a Pass / Fail / N/A line for each area listed under
  "Map the attack surface".

Use WebFetch only if you need to confirm a CWE reference or a known-vulnerable
version.

Write the report to `audits/security-<YYYY-MM-DD>.md`.

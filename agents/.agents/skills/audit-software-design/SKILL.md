---
name: audit-software-design
description: >
  Audits software design across three lenses: architecture (separation of
  concerns, layering, dependency flow), design-pattern usage, and SOLID
  adherence. Use when explicitly asked for a software-design or architecture
  review.
argument-hint: "[path-or-scope]"
agent: auditor
disable-model-invocation: true
---

# Software design audit

Audit the software design of **$ARGUMENTS** (if no path or scope is given, the
whole project). Cover the three lenses below, and tag each finding's Category
as `Architecture`, `Design Patterns`, or `SOLID`.

## Architecture

- Is there clear separation of concerns?
- Which architectural pattern is in use (MVC, Layered, Microservices, etc.)?
- Are there God objects or modules doing too much?
- Is the dependency flow clean (no circular dependencies)?
- Anti-patterns: spaghetti code, copy-paste programming, God classes/modules,
  tight coupling, missing abstractions.
- Note layer dependencies, data flow, external service integrations, and
  potential bottlenecks (describe in text; a diagram is optional).
- Rate overall modularity 1-10 with justification, and use that as the
  report's **Overall rating**.

## Design patterns

- Creational: Singleton, Factory, Builder.
- Structural: Adapter, Facade, Decorator, Proxy.
- Behavioral: Strategy, Observer, Chain of Responsibility, Command.
- Domain: Repository, Service layer, DTO/Value object, Domain model.
- For each pattern found: is it appropriate for the use case, implemented
  correctly, could a simpler solution work, and are there missing patterns
  that would improve the code?

## SOLID

- SRP: does each module have one reason to change?
- OCP: can behavior be extended without modification (watch for hardcoded
  switch / if-else chains that should be polymorphic)?
- LSP: do derived types properly substitute their base types?
- ISP: are interfaces too large; do clients depend on methods they don't use?
- DIP: dependence on abstractions vs. concretions; proper injection vs. `new`
  usage.

Format the report using the template at
`${CLAUDE_SKILL_DIR}/../../templates/audit.md`. Write it to
`audits/software-design-<YYYY-MM-DD>.md`.

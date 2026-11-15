---
name: audit-business-logic
description: >
  Audits the integrity and security of critical business logic: payment,
  transfer, pricing, and state-changing operations. Checks race conditions,
  idempotency, atomicity, authorization, workflow bypass, calculation and
  money-precision errors, and time-based vulnerabilities. Judgment-based with
  tool assists. Use when explicitly asked for a business-logic, payment-flow,
  or transaction-integrity review.
argument-hint: "[path-or-scope]"
agent: auditor
disable-model-invocation: true
---

# Business logic integrity audit

Audit the integrity and security of business logic in **$ARGUMENTS** (if no
path or scope is given, the whole project). Tag each finding's Category as
`Concurrency`, `Idempotency`, `Atomicity`, `Authorization`, `Workflow`,
`Calculation`, or `Time`.

First identify the critical operations in scope: anything that moves money,
grants access, changes inventory, or transitions a resource through a
sensitive state (payment, transfer, refund, pricing, tax, eligibility,
approval, order state). Audit each identified operation against the categories
below.

## Method and limits

This audit is mostly judgment. Tools catch a thin mechanical slice; the rest
is reasoning about adversarial and concurrent conditions. Use a tool where it
helps and reason about the rest.

A finding-free section means "no issue found in review", not "this code is
safe". Frame findings as areas needing verification, and recommend the test
that would prove the property (a concurrent test, a replay test) rather than
asserting safety.

## Concurrency

- Concurrent requests to the same resource: lost updates, double-spend, or
  oversell of limited inventory.
- TOCTOU (time of check, time of use): a check and the action it guards are
  not atomic, and state changes in between.
- Look for read-modify-write without a lock, a transaction, or an
  atomic/compare-and-swap.
- Tool: run the Go race detector (`go test -race`) over concurrent paths. It
  finds data races that execute, not logical double-spend; reason about the
  latter.

## Idempotency

- A retried, replayed, or duplicated request executing its effect more than
  once: double charge, double shipment.
- Look for an idempotency key, a dedup window, or a unique constraint that
  makes replay safe.
- Webhooks and client retries are the common triggers.

## Atomicity

- A multi-step operation that fails partway and leaves inconsistent state:
  debited but not credited, order created but payment not captured.
- Look for a transaction boundary around the steps, or a compensation path
  (saga) when steps span services.
- Audit the failure and rollback path, not just the happy path.

## Authorization

- Object-level authorization: can a caller act on a resource they do not own
  by supplying its ID (IDOR)? This is authorization, not authentication, so it
  hides from login checks.
- Sensitive operations (refund, transfer, approval) gated by both role and
  ownership, checked server-side on every call.

## Workflow

- State-machine integrity: can a resource reach a state by skipping a required
  step (paid without authorized, shipped without paid)?
- Status fields set directly from client input.
- Approval or validation steps bypassed by calling a later endpoint directly.

## Calculation

- Price, discount, coupon, and currency computed and validated server-side.
  Never trust a client-supplied price or total.
- Discount and coupon abuse: stacking, reuse beyond a limit, negative or zero
  edge cases.
- Integer overflow and underflow, and negative-value handling, in quantities
  and amounts.
- Money precision: amounts as integer minor units or a decimal type, never
  float. Rounding direction defined and consistent; watch accumulation drift.
  The remediation rule lives in the language convention; point at it rather
  than restating it here.
- Tool: `gosec` and `staticcheck` catch a thin mechanical slice (some
  overflow, unchecked conversions). The manipulation logic is reasoning.

## Time

- Expiration enforced server-side against a trusted clock: tokens, sessions,
  offers, holds.
- Timezone handling consistent; no window bypass by shifting timezone.

## Report

List the critical operations identified in scope, then the findings, each
tagged with its Category. Use the worst finding to justify the report's
**Overall rating**: weigh exploitability and blast radius, that is, whether the
issue moves money, grants access, or corrupts state.

Format the report using the template at
`${CLAUDE_SKILL_DIR}/../../templates/audit.md`. Write it to
`audits/business-logic-<YYYY-MM-DD>.md`.

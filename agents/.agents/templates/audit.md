# <Audit name> <scope or "whole project">

**Date:** <YYYY-MM-DD>
**Scope:** <path audited, or "whole project">
**Overall rating:** <N>/10 — <one-line justification>

## Summary

| #  | Category    | Finding       | Severity (1-10) | Location              | Effort | Status |
|----|-------------|---------------|-----------------|-----------------------|--------|--------|
| 1  | <category>  | <short title> | <N>             | `path/to/file:line`   | S/M/L  | Open   |

<!-- Effort: S (<1h) | M (~half day) | L (>1 day).
     Status: Open | In progress | Done. -->

## Findings

### #1 — <short title>

**Category:** <category>
**Severity:** <N>/10
**Location:** `path/to/file:line`
**Effort:** S | M | L

**Why it's an issue:**
<what it is and why it matters>

**Where it occurs:**
<exact identifiers / call sites>

**Proposed fix:**
<precise, drop-in remediation; prefer a snippet>

```<lang>
// minimal fix snippet
```

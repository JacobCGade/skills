---
name: tdd
description: Use when building a feature or fixing a bug test-first, when the user mentions red-green-refactor, TDD, or a regression test, or when a slice needs a test at a seam before its code.
---

# TDD

The loop is **red → green**, one vertical slice at a time. Each test is a tracer bullet that answers to what the last cycle taught you.

## A good test

- **Observes behaviour at a seam.** It goes through the public interface a caller uses: an endpoint, a command handler, a component's rendered output, a module's exported function. It survives a refactor of the internals.
- **Reads like a spec.** `rejects_expired_voucher_at_checkout` names a capability. Use the glossary's terms.
- **Has an independent oracle.** The expected value comes from the spec, a worked example or a known-good literal. It is never recomputed the way the code computes it.
- **Mocks only at system boundaries.** Fake the network, the clock, the payment provider. Use the real collaborators inside the boundary.

## The loop

1. **Agree the seam** before the first test. Use the one from the ticket. If there is none, propose it in one line (what it catches, what it misses).
2. **Red.** Write one test. Run it and **watch it fail for the expected reason**: an assertion message, not a compile error or a missing fixture. A test you never saw fail proves nothing.
3. **Green.** Write the least code that passes it. Leave out the next test's feature.
4. **Repeat** with the next behaviour of the slice.

Refactoring is not part of the loop. It belongs to the lean pass and to review, where the whole diff is visible.

## Bug fixes

The first commit is the test that reproduces the bug, failing. The fix lands on top, so the history proves the fix.

## Tells that a test is wrong

| Tell | Problem |
|---|---|
| It breaks on a refactor that keeps the behaviour | Coupled to implementation |
| It passes when you delete the code under test | Tautological, or tests a mock |
| You wrote five tests before any code | Horizontal slicing. You are testing imagined behaviour |
| It needs the database queried directly to assert | Verifying through a side channel. Observe through the seam |

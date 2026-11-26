---
name: debug
description: Use when something is broken, a test fails unexpectedly, behaviour is intermittent or flaky, there is a regression, or a first fix attempt didn't work.
---

# Debug

No theory before a **red loop**: one command that fails on *this* bug, every time, in seconds.

## Phases

Finish each phase before you start the next.

1. **Reproduce.** Build the red loop: a failing test at the nearest seam, a script, or a `checks.app` journey. If it won't fire, tighten the conditions, synthesise the trigger, or add logging until it does. Ask the user only for what you cannot reach, and say why.
2. **Minimise.** Strip inputs, steps and config until removing anything more turns the loop green. The smallest repro usually names the cause.
3. **Hypothesise.** List every candidate cause. Rank them by how much problem space each one rules out.
4. **Bisect with evidence.** Test the top hypothesis with instrumentation, a log line, a debugger or `git bisect` against a known-good commit. Read the output and eliminate. Revert what a refuted hypothesis made you change.
5. **Fix at the root.** Fix the first place the system went wrong, not the place it crashed. A guard is a fix only when the state it guards is legitimate.
6. **Lock it.** The red loop becomes a regression test. Commit it failing first, then the fix. See [tdd](../tdd/SKILL.md).
7. **Verify** with the original symptom, not a proxy. See [verify](../verify/SKILL.md).

## Two failed fixes

Two fixes that share a premise and both failed mean the premise is wrong. Write the premise down and test it directly before you write a third fix.

## Report

What was broken, the root cause, the fix, the red-then-green output verbatim, and what would have prevented it (input for `/retro`).

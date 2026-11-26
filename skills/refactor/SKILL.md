---
name: refactor
description: Restructure code or migrate to a new API, library or pattern without changing behaviour. Pins the current behaviour with tests, works in small green steps, moves callers over, then deletes the old path. Run /refactor <target or ticket> [mode=…].
disable-model-invocation: true
---

# Refactor

**Behaviour stays fixed, structure changes.** If you find a bug on the way, log it as a follow-up ticket and leave it alone. Fixing it here would hide a behaviour change inside a refactor.

## 0. Frame

Follow [implement](../implement/SKILL.md) step 0 (mode, read-ticket when there's a ref, brief, branch). Then state:
- the **current shape** and the **target shape**, in a 5-node diagram of each if structure is changing
- why the target is better: what gets simpler, deeper, or safe to change

## 1. Pin the behaviour

Find the seams that observe the code being moved, and confirm the tests there cover the behaviour. Where they don't, add **characterisation tests** that assert what the code does today.

**Prove each pin.** Break the code under it on purpose (invert a condition, return early), watch the test go red, then restore the code. A pin you never saw fail pins nothing.

## 2. Plan the steps

Plan steps that each leave every check green and could ship alone. For a migration, use this order:
1. Add the new path next to the old one.
2. Move the callers over in waves, one module or folder per step.
3. Delete the old path, in the same PR whenever possible. The task isn't finished while the old path remains.

**Build the lever.** When a step repeats across many files, write a codemod or script (Roslyn, `dotnet format` rules, jscodeshift, or `sed` with a review) and commit it with the step it produced, so a reviewer can rerun it.

Write the steps into the brief's **Plan**, and get approval according to the mode.

## 3. Per step

Change, run `checks.test` and `checks.typecheck`, then check against [lean](../lean/SKILL.md). Commit as `refactor(scope): …`, or `chore` for a migration. Add the build-log entry and the Progress line. The pinned tests stay **unchanged** and green. If you have to edit a pinned test, the behaviour changed: stop and ask.

## 4. Close

The full checks pass. A search for the old API or pattern returns nothing (show the command). Then point the user to `/review` and `/open-pr`.

**Done when** the pins are unchanged and green, nothing calls the old path, and every step has a commit and a log entry.

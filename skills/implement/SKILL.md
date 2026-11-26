---
name: implement
description: Build a ticket, an epic's tickets, or the change agreed in conversation, one verified slice at a time, in a chosen autonomy mode. Run /implement <ref | nothing> [mode=collaborative|balanced|autopilot].
disable-model-invocation: true
---

# Implement

## 0. Frame

1. **Mode.** Resolve it with [autonomy](../workflow/references/autonomy.md) and state it: "Mode: balanced."
2. **Read the ticket.** For a ref, follow [read-ticket](../read-ticket/SKILL.md). If it isn't ready, stop and suggest `/refine-ticket <ref>`. In autopilot, skip that ticket and report it. For an epic or parent, list its children in blocking order and read each one when its turn comes. With no ref, treat the agreed change as a single ticket and keep its brief in conversation.
3. **Read the brief** (`docs.briefs/<ref>.md`) before touching code. The ticket's acceptance criteria are the bar, and the brief tells you how.
4. **Restate** the goal and the **smallest change that meets it**, in three lines or fewer. [lean](../lean/SKILL.md) holds you to this.
5. **Branch** from `branch.base`, named with `branch.naming`. Call `transition in-progress`.
6. **Plan the slices.** Give each slice an outcome, a seam and an estimated diff size, and write them into the brief's **Plan**. Collaborative and balanced: get approval once. Autopilot: proceed.

## 1. Per slice

1. **Red.** Follow [tdd](../tdd/SKILL.md): one test at the slice's seam, seen failing for the right reason.
2. **Green.** Write the minimal code that passes it. Run `checks.test-one`, then `checks.typecheck`.
3. **Lean.** Hold the diff against [lean](../lean/SKILL.md) and cut what the slice's outcome doesn't need.
4. **Verify.** Follow [verify](../verify/SKILL.md) for the slice's claim.
5. **Commit.** One commit per slice: `type(scope): subject`, with the ticket ref in the body.
6. **Log.** Append the [build-log](../workflow/references/build-log.md) entry and a line in the brief's **Progress**, then post the slice digest.
7. **Mode gate.** Collaborative: wait for "go". Balanced and autopilot: continue.

If the actual diff grows past twice the estimate, stop the slice. Split it or simplify it, and update the Plan.

## 2. Parallel tickets (autopilot only)

Tickets with no open blockers that touch disjoint modules can run in parallel. Use `/fleet`, or delegate each one to the `implementer` agent. Its kickoff contains the ticket's title, overview and acceptance criteria verbatim, the brief's path, the bindings path, and this skill's path. Tickets that share files run serially.

Only this session touches the tracker, the build log and the briefs' Progress sections. You own every delegated diff: read it and rerun [verify](../verify/SKILL.md) yourself. A subagent's "done" is a claim, not evidence.

## 3. Close

1. Run every `checks` command once, in full.
2. Tell the user to run `/review`, then `/open-pr`. In autopilot, follow their steps yourself. Then follow [catch-me-up](../catch-me-up/SKILL.md) for the run's range and present the result as the final report.

**Done when** every slice has a commit, a build-log entry, a Progress line and verify evidence, the full checks pass, and the user knows the next step.

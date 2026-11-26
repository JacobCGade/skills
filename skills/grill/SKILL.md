---
name: grill
description: Use when the user wants a plan, idea, feature or design stress-tested before building, says "grill me", or when a request leaves non-trivial decisions open (scope, behaviour, edge cases, data shape, ownership).
---

# Grill

Interview the user relentlessly until you share one understanding of what to build and why. Map the work as a **design tree**: every decision branches into the decisions that hang off it.

## Before the first round

Read what the user pointed at, plus the code it touches, until you can explain how it works today. Read `docs.glossary` and the ADRs in that area. Never ask what the code or the docs already answer.

## Rounds

The **frontier** is every open decision whose prerequisites are settled. Ask the whole frontier in one round. Number each question and give your recommended answer:

```
❓ **Q1 · <title>**: <question, with options if it branches>
➡️ <recommended answer and the one-line reason>
```

Word each question so that "yes" accepts your recommendation. Recompute the frontier after each answer. A question that depends on another open question waits for a later round.

**Facts are yours, decisions are theirs.** Find facts yourself, and hand big lookups to a subagent while you keep asking the questions that don't depend on them. When a question can only be settled by running something (a library's real behaviour, how a UI feels), follow [prototype](../prototype/SKILL.md) instead of debating it.

Probe for these:
- the smallest version that still delivers the value
- what is explicitly out of scope
- the edge cases a user would hit
- the modules touched, and the seam where tests will observe the behaviour

## Paper trail

- **Glossary:** when a term is used loosely, or two terms are used for one thing, settle on one. Add it to `docs.glossary` with a one-line definition and an `_Avoid:_` list.
- **ADR:** when a decision is hard to reverse (a schema, a public contract, a dependency, a cross-module boundary), write a short ADR in `docs.adr` covering context, decision, consequences and the rejected options.

## Done

The frontier is empty: every branch is visited and nothing is silently assumed. Play the understanding back in ten lines or fewer (goal, scope, out of scope, key decisions, test seams) and wait for the user's confirmation. Then suggest the next step: `/to-tickets` for work that spans tickets, `/implement` for a small change.

---
name: spike
description: Timeboxed investigation of an open question before committing to build. Ends in a cited findings note and your decision, recorded as an ADR or as tickets. Run /spike <question>.
disable-model-invocation: true
---

# Spike

A spike buys a decision, not code.

## 1. Frame, and confirm with the user

```
Question:    <one sentence>
Decision it informs: <what we'll choose between>
Budget:      <e.g. 3 probes and 30 lookups, or "until the options are clear">
Exit when:   <the evidence that would settle it>
```

## 2. Investigate

- **Primary sources first:** the code in this repo, official docs, library source, specs, real API responses. Write down the source behind each claim. Hand bulk reading to a subagent and keep its summaries.
- **Run what can be run.** Follow [prototype](../prototype/SKILL.md) for questions that need observed behaviour.
- **Count against the budget.** When it runs out, stop and report what you know and what you don't.

## 3. Write the findings note

Write it to `docs.spikes/<YYYY-MM-DD>-<slug>.md`, at most one screen:

```markdown
# Spike: <question>
**Answer:** <one paragraph, or "not settled" + why>
## Options
| Option | For | Against | Evidence |
## Recommendation
<option + the one-line reason + what would change the call>
## Sources
- <claim> — <URL or file:line>
## Unknowns
```

## 4. Decide, then hand off

Present the recommendation and wait, because the decision is the user's. Then:
- a decision that is hard to reverse → write an ADR in `docs.adr` and link the note
- work to do → tell the user to run `/to-tickets`, carrying the note as the alignment

**Done when** the note exists with a source for every claim, and the user's decision is recorded as an ADR, as tickets, or as "no action" with a reason.

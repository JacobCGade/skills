---
name: workflow
description: Router over this skill set. Run /workflow to see the map or to ask which skill or flow fits the situation.
disable-model-invocation: true
---

# Workflow

The map of this skill set and the rules every skill shares. Read a skill's own SKILL.md before you recommend it or skip one of its steps. The summaries here are for orientation.

## Main flow: idea → merged

1. **Align.** `/grill` interviews you until no decision is left to assume. When a question needs a runnable answer, it takes a detour through [prototype](../prototype/SKILL.md).
2. **Tickets.** `/to-tickets` turns the alignment into a ticket plan (types, content, links). It creates the tickets after you approve the plan.
3. **Build.** `/implement <ref> [mode=collaborative|balanced|autopilot]`. It runs `read-ticket` first, then works slice by slice. Each slice goes red → green → lean → verify → commit → log.
4. **Review.** `/review` runs two fresh-context reviewers, one for the spec and one for the standards.
5. **Ship.** `/open-pr`, then `/pr-feedback` when reviewers comment.
6. **Learn.** `/retro` turns mistakes into checks, types or sharper skills.

Small change? Skip step 2 and run `/implement` straight from the conversation.

## Other flows

| Situation | Flow |
|---|---|
| A ticket someone else wrote | `/read-ticket <ref>` → `/refine-ticket <ref>` if it has gaps → `/implement` |
| Something is broken | [debug](../debug/SKILL.md) → `/review` → `/open-pr` |
| Restructure or migrate without changing behaviour | `/refactor` → `/review` → `/open-pr` |
| An open question to investigate first | `/spike` → ADR, or `/to-tickets` |
| Ship a version | `/release` |
| You lost track of what was built | `/catch-me-up [since <ref> \| <ticket> \| today \| explain <thing>]` |
| The session is full or you're switching agents | `/handoff` |
| A new repo | `/setup-workflow` |
| Writing or changing a skill or adapter | `/writing-skills` |

## Shared kernel

Each reference below is the single source of truth for its topic:

- [references/ports.md](references/ports.md): how skills reach the tracker and the code host through swappable adapters, and how skills compose.
- [references/autonomy.md](references/autonomy.md): the three autonomy modes and the hard stops.
- [references/agent-brief-template.md](references/agent-brief-template.md): the local, agent-facing companion to each ticket.
- [references/build-log.md](references/build-log.md): the per-slice log that keeps you oriented.
- [references/bindings-template.md](references/bindings-template.md): the per-repo config.

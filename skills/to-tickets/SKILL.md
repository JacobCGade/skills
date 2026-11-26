---
name: to-tickets
description: Turn an alignment (a grill session, a spec, a conversation) into a ticket plan with types, content and links, then create the tickets and their agent briefs after you approve. Run /to-tickets [under <ref>].
disable-model-invocation: true
---

# To tickets

Tickets are human-facing, so you always present the plan and wait for approval before creating anything, in every mode. See [autonomy](../workflow/references/autonomy.md).

## 1. Find the anchor

Ask where the work goes, and recommend one option:
- under an existing ticket the user names (`under <ref>`), which you read with `get`, or
- as a new top-level item.

## 2. Size the hierarchy

Read the allowed types and parent rules with the tracker's `types` operation (see [ports](../workflow/references/ports.md)). Propose the smallest hierarchy that fits the work:

| The work | Typical shape |
|---|---|
| A multi-ticket feature | Epic → Stories (→ Sub-tasks if needed) |
| One user-facing behaviour | A Story, maybe with Sub-tasks |
| A small piece of an existing Story | Sub-tasks under that Story |

Cut **vertical slices**: each Story or Task is a thin path through every layer it needs, observable on its own. Order the slices by risk, riskiest first. Mark `blocks` edges only where one slice truly can't start without another, so that more tickets can run in parallel.

## 3. Present the ticket plan and wait

Write each ticket's body with [ticket-template.md](ticket-template.md), then show the plan in this format:

```
Ticket plan · <project> · under <anchor or "new top level">

#1  <Type>  <Title>
    Parent: <ref or #n>   Blocks: <#n>   Blocked by: <#n>   Relates: <ref>
    Overview: <first sentence>
    Acceptance: 1) … 2) …

#2  …

Coverage: <each alignment criterion → #n> · Links: <counts by kind>
Reply "create", or edit, e.g. "#2 → Task", "drop #3", "#3 under SHOP-215", "split #1".
```

Apply the edits and show the plan again until the user replies "create". An alignment criterion with no ticket is a gap. Show it as a gap; don't hide it.

## 4. Create

1. Call `create` in dependency order: parents before children. Map `#n` to the real refs as you go.
2. Call `link` for every `blocks` and `relates` edge.
3. For each ticket, write a brief from the [agent brief template](../workflow/references/agent-brief-template.md). Fill Context, Decisions, Domain terms and Constraints from the alignment and the code. Set `ticket-updated` from `get`.
4. If any call fails, stop. Report which tickets were created, which weren't, and the error.

**Done when** every alignment criterion maps to a ticket, every ticket and link exists, every ticket has a brief, and the user has the refs in build order.

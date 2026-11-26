---
name: refine-ticket
description: Make a ticket ready. Interviews you on its gaps, rewrites it to the ticket template, and writes it back only after you approve the change. Run /refine-ticket <ref>.
disable-model-invocation: true
---

# Refine ticket

## Steps

1. **Read** the ticket by following [read-ticket](../read-ticket/SKILL.md). Its gaps are your agenda. If it is already ready, say so and stop.
2. **Grill the gaps only.** Follow [grill](../grill/SKILL.md), but scope the frontier to the failed readiness items and the decisions they hang on. Don't reopen what the ticket already settles.
3. **Rewrite** the ticket body with [ticket-template.md](../to-tickets/ticket-template.md). Keep the author's wording where it already meets the rules. If the ticket fails readiness item 5 (too big), propose a split into child tickets using the [to-tickets](../to-tickets/SKILL.md) plan format.
4. **Present the change and wait.** Show a before/after of the body, plus any type, parent, link or split change, and the readiness re-check. Write nothing until the user approves.
5. **Write it back.** Call `update` (and `create` and `link` for any split). Add one `comment` saying what changed and why. Then update the brief's Decisions and Domain terms from the interview, and set `ticket-updated`.

**Done when** the user approved the change, the tracker holds it, and a re-run of read-ticket's readiness check passes.

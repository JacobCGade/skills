---
name: read-ticket
description: Read a ticket with its parent, children, links and comments, check it against the definition of ready, and create or refresh its agent brief. Run /read-ticket <ref>. implement runs it automatically.
disable-model-invocation: true
---

# Read ticket

## Steps

1. **Fetch** the ticket with the tracker's `get` (see [ports](../workflow/references/ports.md)). Then fetch its parent, its blockers, and any linked ticket whose summary matters to its scope.
2. **Check readiness** against every item in the [definition of ready](../to-tickets/ticket-template.md#definition-of-ready). Quote the ticket text behind each failed item.
3. **Sync the brief** at `docs.briefs/<ref>.md` (template: [agent brief](../workflow/references/agent-brief-template.md)):
   - If it's missing, create it. Explore the code the ticket touches and fill Context, Domain terms and Constraints. Write `n/a: <reason>` where a section doesn't apply.
   - If it's stale (the ticket's `updated` is newer than `ticket-updated`), show what changed in the ticket, update the affected sections, and flag any Plan or Progress entries the change invalidates.
   - If the brief contradicts the ticket, the ticket wins. Report the conflict.
4. **Report.**

## Report

```
<ref> · <type> · <title> · <state>
Parent: … · Blocked by: … (states) · Children: …
In short: <2 sentences in your own words>
Ready: yes | no
Gaps: <failed checklist items with the quoted text>
Risks: <what in the code makes this harder than it looks>
Brief: created | refreshed (<what changed>) | current
Next: /implement <ref> | /refine-ticket <ref>
```

**Done when** every checklist item has a verdict backed by the ticket text, and the brief is current.

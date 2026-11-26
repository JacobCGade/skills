# Ticket template

Every ticket uses this template, whatever its type, so tickets look alike and can be skimmed in seconds. It is written for humans. Agent-only detail goes in the brief (see [agent brief template](../workflow/references/agent-brief-template.md)).

## Template

```markdown
## Overview
<2–3 sentences: what changes for the user, and why now. Plain words, glossary terms.>

## Acceptance criteria
1. <one observable outcome: who does what, and what they see or get>
2. …

## Out of scope
- <one line each; omit the section if empty>

## Notes
<≤3 lines: links, a constraint a human reviewer must know; omit if empty>
```

## Writing rules

- **The overview says why.** If it only restates the title, rewrite it.
- **Each acceptance criterion is observable and testable.** Write "a checkout with an expired voucher shows 'This voucher has expired'", not "handle expired vouchers". Use Given/When/Then only when the precondition matters.
- **Size by type:**
  - An Epic or Feature lists the outcomes its children deliver.
  - A Story or Task has 1–5 criteria.
  - A Sub-task has 1–2 criteria.

  More than that means split the ticket.
- **Keep implementation out.** No file paths, class names or code. Those go in the brief.
- **The whole ticket fits on one screen.**

## Definition of ready

`read-ticket` checks every item. A ticket is ready when all of them hold:

1. The overview states the user-facing change and the reason for it.
2. Every acceptance criterion is observable and testable.
3. The scope is unambiguous: anything a reader might assume is listed under Out of scope.
4. Its blockers are done, or explicitly accepted as parallel work.
5. It fits one `/implement` run. A Story or Task needs no more than 5 criteria.
6. No unanswered questions remain in its comments.
7. Its type and parent agree with the project's hierarchy (tracker `types`).

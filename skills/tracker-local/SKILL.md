---
name: tracker-local
description: Offline tracker port adapter. Tickets are Markdown files on the local filesystem, modelled on Jira (types, parents, links, statuses) so they can be imported later. Reached through the bindings (ports.tracker = tracker-local), not invoked directly.
disable-model-invocation: true
---

# tracker-local

Implements the `tracker` contract in [ports](../workflow/references/ports.md) with no network access.

**Config:** `tracker-local.dir` (default `.agents/tickets`, gitignored), `.prefix`, `.types`, `.parents` and `.states` from the bindings.
**Layout:** one file per ticket, `<dir>/<prefix>-<n>.md`, plus `<dir>/index.md`. The script regenerates the index. Never edit `index.md` by hand.

## Ticket file

```markdown
---
ref: L-2
type: Sub-task
title: Add expiry to the Voucher model
state: To Do
parent: L-1
blocks: []
blocked-by: []
relates: []
created: 2026-11-25T11:30:00Z
updated: 2026-11-25T11:30:00Z
jira-key:
---
<body in the ticket template>

## Comments
- 2026-11-25T11:40:00Z · <text>
```

Keep the frontmatter flat: scalars, and lists written inline as `[L-1, L-3]`.

## Operations

| Port op | Implementation |
|---|---|
| get | Read the file. Children are the tickets whose `parent` is this ref |
| search | Search the frontmatter and bodies in `dir` |
| types | `types` and `parents` from the bindings |
| create | Next free `<prefix>-<n>`. Write the file with `state: states.ready` and `created` and `updated` set to now |
| update | Rewrite the title, type or body. Keep the `## Comments` section |
| link | `blocks`: add the target to this ticket's `blocks` and this ticket to the target's `blocked-by`. `relates`: add to both. `parent`: set `parent` on the child |
| comment | Append `- <now> · <text>` under `## Comments` |
| transition | Set `state` to `states[canonical]` |

After every write, set `updated` on each file you touched and regenerate the index:

`python3 <this skill dir>/scripts/tickets.py index <dir>`

## Moving to Jira

Moving the tickets is the user's step, not a port operation:

`python3 <this skill dir>/scripts/tickets.py export-jira-csv <dir> > tickets.csv`

The script prints the column mapping to use with Jira's CSV importer. After the import, record each `jira-key`, and switch `ports.tracker` to `tracker-jira`.

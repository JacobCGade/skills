---
name: tracker-jira
description: Tracker port adapter for Jira Cloud. Reached through the bindings (ports.tracker = tracker-jira), not invoked directly.
disable-model-invocation: true
---

# tracker-jira

Implements the `tracker` contract in [ports](../workflow/references/ports.md).

**Config:** `tracker-jira.site`, `.project` and `.states` from the bindings.
**Tool:** the Atlassian Rovo MCP tools when connected. Otherwise `acli jira`, checking flags with `--help`. If neither is available or authenticated, return `unsupported: no Jira access` and suggest switching to `tracker-local`.

| Port op | MCP | acli |
|---|---|---|
| get | get issue, with comments and links | `workitem view <KEY> --json --fields "*all"` |
| search | JQL search, scoped to `project` | `workitem search --jql "…" --json` |
| types | the project's issue types | none: read them from a recent issue, or ask once and cache them in the bindings |
| create | create issue, with parent | `workitem create`, with type, summary, parent and a body file |
| update | edit issue | `workitem edit --key <KEY>` |
| link | parent: set on the child; blocks/relates: issue link | `workitem link create`; parent via `workitem edit` |
| comment | add comment | `workitem comment create --key <KEY>` |
| transition | transition to `states[canonical]` | `workitem transition --key <KEY> --status "…"` |

Jira stores descriptions in its own rich format, so keep bodies to paragraphs and lists, which survive the conversion. If a transition is not allowed from the current status, report both statuses and stop.

# Ports, adapters and composition

Process skills never name Jira or GitHub. They call a **port**, which is an abstract capability with a fixed contract. The **bindings** choose which **adapter** skill implements each port in this repo. To switch tools, change one line in the bindings.

## Resolving a port

1. Read the bindings: `.agents/workflow.md` in the repo, or `~/.agents/workflow.md` when the repo has none. Repo values win, key by key.
2. Under `ports:`, find the adapter name, for example `tracker: tracker-local`.
3. Read the adapter's SKILL.md through the sibling path `../<adapter>/SKILL.md` from any skill. From this file the path is `../../<adapter>/SKILL.md`.
4. Call only the operations below, with the adapter's config block from the bindings.

If a port is unbound, tell the user to run `/setup-workflow` and stop.

## `tracker`

| Operation | Input | Output |
|---|---|---|
| `get` | ref | title, type, state, body, parent, children, links, comments, `updated` timestamp |
| `search` | query in plain words | list of ref, title, type and state |
| `types` | none | the issue types the project allows, and which can be parents of which |
| `create` | type, title, body, parent ref? | ref + location (URL or path) |
| `update` | ref, any of title, type or body | ok |
| `link` | from ref, kind (`blocks`, `relates` or `parent`), to ref | ok |
| `comment` | ref, Markdown body | ok |
| `transition` | ref, canonical state | ok + the real state name |

The canonical states are `ready`, `in-progress`, `in-review` and `done`. Each adapter maps them to real states through its config.

## `code-host`

| Operation | Input | Output |
|---|---|---|
| `open-pr` | branch, base, title, body file | PR URL |
| `get-pr` | PR ref, or none for the current branch | title, state, URL, checks |
| `review-threads` | PR ref | open threads: id, file:line, author, comments, resolved? |
| `reply` | thread id, body | ok |
| `checks` | PR ref | per check: name, state, log URL |
| `merged-prs` | since a tag or ref | number, title, author, labels, merge commit |
| `create-release` | tag, target, title, notes file | release URL |

## Adapter rules

- An adapter is lean: config keys, the preferred tool, and an operation-to-tool mapping table. Exact flags come from the tool's `--help` or the MCP tool's description, never copied into the skill.
- It implements every operation of its port and nothing else. When the tool can't do an operation, it returns `unsupported: <reason>` and does not improvise.

## Composition rules

These are the layers, from outside in. A layer may call only the layers below it.

1. **Orchestrators** run only when the user types them: `workflow`, `setup-workflow`, `to-tickets`, `read-ticket`, `refine-ticket`, `implement`, `refactor`, `spike`, `review`, `open-pr`, `pr-feedback`, `release`, `catch-me-up`, `handoff`, `retro` and `writing-skills`.
2. **Disciplines** can also be invoked by the model, and they hold reusable judgment: `grill`, `prototype`, `tdd`, `lean`, `verify` and `debug`.
3. **Adapters** implement ports and call only their tool.

Some orchestrators run another's steps as a fixed sub-step: `implement` runs `read-ticket`, and `refine-ticket` runs `read-ticket`. Otherwise an orchestrator hands off by telling the user what to run next, which keeps the human at the phase boundaries. Autopilot is the exception: no one is there to run the next command, so the orchestrator follows the next SKILL.md itself. One skill reaches another by reading its SKILL.md through the sibling path, so composition works whether or not the harness exposes the skill to the model.

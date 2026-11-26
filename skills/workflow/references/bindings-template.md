# Bindings template

`/setup-workflow` writes this file to `.agents/workflow.md` in a repo, or to `~/.agents/workflow.md` for personal defaults. Repo values override personal ones key by key. Delete the keys you don't use.

````markdown
# Workflow bindings

```yaml
ports:
  tracker: tracker-local           # switch to tracker-jira once the MCP or acli is approved
  code-host: code-host-github

autonomy: balanced                 # collaborative | balanced | autopilot

checks:                            # verify runs these. Fast ones first. Match what CI runs.
  format: dotnet format --verify-no-changes && npm run format:check
  typecheck: npm run typecheck
  build: dotnet build -warnaserror
  test-one: dotnet test --filter "{name}"     # {name} = test or class name
  test: dotnet test && npm test
  lint: npm run lint
  app: ""                          # optional: a command or project skill that drives the real app

docs:
  briefs: .agents/briefs           # gitignored
  build-log: .agents/build-log.md  # gitignored
  adr: docs/adr
  glossary: GLOSSARY.md
  spikes: docs/spikes
  prototypes: .agents/prototypes   # gitignored

branch:
  base: main
  naming: "{type}/{ticket}-{slug}" # e.g. feat/L-2-expired-vouchers

tracker-local:
  dir: .agents/tickets             # gitignored
  prefix: L
  types: [Epic, Story, Task, Bug, Sub-task]
  parents: { Epic: [Story, Task, Bug], Story: [Sub-task], Task: [Sub-task], Bug: [Sub-task] }
  states: { ready: "To Do", in-progress: "In Progress", in-review: "In Review", done: "Done" }

tracker-jira:
  site: your-org.atlassian.net
  project: SHOP
  states: { ready: "To Do", in-progress: "In Progress", in-review: "In Review", done: "Done" }

code-host-github:
  repo: your-org/shop              # optional; defaults to the current repo
```
````

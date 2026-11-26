---
name: setup-workflow
description: Configure a repo (or personal defaults) for this skill set. Writes the port bindings, check commands, autonomy default, doc locations and gitignore entries. Run /setup-workflow once per repo, or /setup-workflow personal.
disable-model-invocation: true
---

# Setup workflow

Write `.agents/workflow.md` from [the template](../workflow/references/bindings-template.md). With the argument `personal`, write `~/.agents/workflow.md` instead. Explore first, present what you found, confirm with the user, then write.

## 1. Explore

Answer from the repo. Ask the user only for what you can't observe.

- **Existing bindings:** do they exist already? Then update them, don't start over.
- **Code host:** `git remote -v` should point at GitHub. Confirm with `gh auth status`.
- **Tracker:** is the Atlassian MCP connected in this session, or is `acli` installed and logged in? If neither, recommend `tracker-local`.
- **Checks:** read `*.sln`, `*.csproj`, `Directory.Build.props`, the `package.json` scripts and the CI workflows. Take each command from what CI runs, so local and CI agree.
- **Docs:** an existing ADR folder, glossary, `AGENTS.md` (plus any harness-specific files such as `CLAUDE.md`, `.github/copilot-instructions.md` or `.github/instructions/`).

## 2. Confirm, one section at a time

Lead each section with your recommendation, so the user can accept it in one word:

1. **Ports.** Which tracker adapter, and the code host.
2. **Tracker config.** For Jira: the project and the state names, read from a real ticket (don't guess them). For local: the prefix, the types and the parent rules.
3. **Checks.** Run each one once now and show its exit code. A check that fails on a clean checkout gets fixed or flagged before anything else.
4. **Autonomy default.** `balanced` unless they say otherwise.
5. **Doc locations.**

## 3. Write

- The bindings file.
- `.gitignore` entries for every local path: `docs.briefs`, `docs.build-log`, `docs.prototypes`, and `tracker-local.dir` when it is bound. Add each path on its own line. Never ignore `.agents/` as a whole, because harnesses load project skills from `.agents/skills`.
- A two-line pointer in `AGENTS.md`, created if missing. It is loaded on every turn, so keep it this short:

  ```markdown
  ## Agent workflow
  Bindings (tracker, checks, autonomy, docs) live in `.agents/workflow.md`. Coding conventions are below.
  ```

- Create the tickets dir with an empty `index.md`, the briefs dir and the build log, each if missing.

**Done when** the bindings exist, every check has run with its exit code shown, the ignored paths show up in `git check-ignore -v <path>`, and the tracker's `get` or `search` returned a result (an empty local index counts).

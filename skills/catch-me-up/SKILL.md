---
name: catch-me-up
description: Rebuild your understanding of what was built, why, and where to start reading. Also explains a single thing in plain words. Run /catch-me-up [since <ref> | <ticket> | today | explain <thing>].
disable-model-invocation: true
---

# Catch me up

The reader stepped away while agents built faster than they could follow. Give them the **overview** first, then the detail. Build it from the primary sources, never from memory of the session.

## Sources

- `git log --oneline <range>` and `git diff --stat <range>`. The default range is the merge-base with `branch.base` up to HEAD. "today" means `--since=midnight`. A ticket ref means the commits that mention it.
- The build-log entries in the range (`docs.build-log`), including rulings.
- The tickets (tracker `get`) and their briefs' Decisions and Progress sections.
- The code itself, wherever the diff summary doesn't explain a module.

## Output

At most one screen plus the diagram:

1. **In one paragraph:** what exists now that didn't before, and why. Use the glossary's terms.
2. **Map:** one mermaid diagram of the touched modules and how they connect. Mark new ones `:::new` and changed ones `:::changed`, and declare both with `classDef`.
3. **By module:** a table with module, what changed, why, and risk (low, medium or high).
4. **Decisions to confirm:** every ruling and every one-way-door decision, each with its cost if wrong.
5. **Read next:** 2–3 files in order, each with what to look for.
6. **Open questions:** from the build log's Open lines and the briefs.

## `explain <thing>`

The user didn't follow something: a message, a module, a term. Explain it again for someone without the context. Say what problem it solves, how it works in 3–5 plain steps, and where it lives (`file:line`). Add a diagram of at most 5 nodes if the thing is structural. Define each term the first time you use it, and use the glossary's term over a new one.

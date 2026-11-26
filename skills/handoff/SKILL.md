---
name: handoff
description: Compact the current session into a handoff document so a fresh session or another agent can continue. Run /handoff [what the next session will do].
disable-model-invocation: true
---

# Handoff

Write a handoff for an agent that has seen nothing of this session. Save it to `$TMPDIR` (or `/tmp`) as `handoff-<branch>-<timestamp>.md`, not in the repo, and print the path.

## Contents

1. **Goal:** the outcome and the smallest change that meets it.
2. **Where things are:** branch, last commit, mode, and the ticket refs with their brief paths. The briefs hold the plan, progress and decisions, so point to them rather than repeating them.
3. **Session-only knowledge:** decisions, rulings and gotchas that aren't yet in a brief, the build log or an ADR. Write them into the relevant brief first, then list what you added.
4. **Next step:** the exact next action, and which skill to read for it.

Redact secrets and personal data. If the user passed an argument, tailor the document to that next task.

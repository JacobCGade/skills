---
name: review
description: Two-axis review of the changes since a fixed point. The spec axis asks whether it does what the ticket asked. The standards axis asks whether it follows the repo's standards and stays lean. Each axis runs in a fresh-context reviewer agent. Run /review [fixed point].
disable-model-invocation: true
---

# Review

The implementer has the most context pressure and the least distance from its own code. Reviews therefore run in **fresh context**: each reviewer sees only the diff, its sources and its brief, never this session's reasoning.

## 1. Pin the fixed point

Use the argument if one was given. Otherwise use the merge-base with `branch.base`. Confirm that `git rev-parse <point>` resolves and that `git diff <point>...HEAD --stat` is non-empty. Fail here, not inside two reviewers.

## 2. Gather sources

- **Spec:** the ticket refs from commit messages or the branch name. Fetch each with the tracker's `get` (see [ports](../workflow/references/ports.md)) for its acceptance criteria, and read the Decisions and Constraints in its brief. For a change agreed in chat, use the agreed summary. If there is no spec at all, the spec axis reports "no spec".
- **Standards:** `AGENTS.md`, `.github/copilot-instructions.md`, `.github/instructions/*.instructions.md`, `CONTRIBUTING.md`, `CODING_STANDARDS.md` and the ADRs in the touched area, with [lean](../lean/SKILL.md) as the baseline. A documented repo standard overrides the lean baseline.

## 3. Dispatch both reviewers in parallel

- `spec-reviewer` agent: the diff command, the acceptance criteria verbatim, and the brief's path.
- `standards-reviewer` agent: the diff command and the list of standards file paths.

Pass file paths and commands. The acceptance criteria are the one thing you paste in full, because local tickets aren't reachable from the agent.

## 4. Aggregate

Merge duplicates. Drop any finding that has no `file:line`. Reread each **blocker** against the code yourself.

```markdown
### Spec: <n> findings
| Sev | Where | Finding | Criterion |
### Standards: <n> findings
| Sev | Where | Finding | Rule or smell |
### Verdict
Ready / Fix blockers first / Rethink: <one line>
```

Severity is **blocker** (wrong behaviour, a missing criterion, a broken standard), **should** (a lean smell, unclear naming) or **nit**.

This skill fixes nothing. In collaborative and balanced modes, offer to fix the blockers. In autopilot, fix them, rerun [verify](../verify/SKILL.md), and rerun the affected axis once.

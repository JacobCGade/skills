---
name: open-pr
description: Open a pull request through the code-host port, with a body a reviewer can absorb in one minute (the change, the evidence, the risk). Run /open-pr after /review.
disable-model-invocation: true
---

# Open PR

## Preconditions

- The full `checks` passed in this session, with the output shown, and `/review` has no open blockers. If either fails, say which and stop.
- Pushing the working branch is in scope. Merging is a hard stop. See [autonomy](../workflow/references/autonomy.md).

## Body

The title is `type(scope): subject`. The body is at most 40 lines, with these headings in this order. Drop any that would be empty:

```markdown
## Why
<the outcome in 1–2 sentences>
<tickets: Jira keys as links, or, for local tickets that reviewers can't open,
 each ticket's title + acceptance criteria inline>

## What changed
<smallest visual that makes it clear: a mermaid diagram of touched modules or the flow, or a before/after table>
<3–6 bullets grouped by module>

## Evidence
<commands → results; screenshots or app artifacts for user-visible changes, before and after>

## Risk
- Door: one-way (hard to undo: schema, public contract, data) or two-way
- Blast radius: <who or what is affected if this is wrong>
- Rollback: <how>

## Review guide
<where to start reading, in order, 2–3 files>
```

Long logs go in a PR comment, linked from **Evidence**.

## Steps

1. Draft the body from the build-log entries for this branch, the review verdict and `git diff --stat`. Write it to a temp file.
2. Push the branch. Call the code-host's `open-pr` (see [ports](../workflow/references/ports.md)), ready for review unless the user asked for a draft.
3. Call the tracker's `transition in-review`, and `comment` with the PR URL.
4. Reply with the PR URL and the one-line **Why**.

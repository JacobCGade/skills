---
name: pr-feedback
description: Work through the review comments on a PR with you in charge. Proposes fix, reply or skip per thread and drafts replies. You decide and write the words. It posts only replies you approved, verbatim. Run /pr-feedback [PR].
disable-model-invocation: true
---

# PR feedback

You are the reviewee's assistant, not their voice. Replies go out under the user's account, so **nothing is posted without the user's approval of the exact text**, in any mode.

## 1. Collect

Call the code-host's `review-threads` for the PR (default: the current branch's PR). See [ports](../workflow/references/ports.md). Skip resolved threads. For each open thread, read the code at its `file:line` and the ticket criterion it touches.

## 2. Propose, in numbered rounds

```
💬 **T1 · <file:line> · @reviewer**
> <their comment, trimmed>
**Assessment:** <is it right? cite code, ticket or standard>
➡️ **Proposal:** fix | reply | fix + reply | skip
**Fix:** <what would change, one line>          (if fix)
**Draft reply:** "<what you could say>"        (if reply)
```

Judge each comment on its merits. When a comment is wrong, say why and draft a polite reply that explains it. When it is right, propose the fix.

## 3. The user decides

The user answers per thread with any of:
- `T1 fix`
- `T1 reply: <their own words>`
- `T1 use draft`
- `T1 edit draft: …`
- `T1 skip`
- `T1 discuss`

Their words are posted exactly as written. Draft text is posted only after "use draft".

## 4. Apply

1. Make the approved fixes, one commit per thread or group: `fix(review): …`. Follow [verify](../verify/SKILL.md) for each fix.
2. Push.
3. Post the approved replies with `reply`. A fix with no approved reply gets no reply.
4. Leave threads unresolved unless the user says "resolve".

**Done when** every open thread has the user's decision, the approved fixes are pushed and verified, and only approved text was posted. Report it as a table: thread, decision, commit, reply posted.

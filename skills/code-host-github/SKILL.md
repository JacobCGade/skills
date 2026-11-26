---
name: code-host-github
description: Code-host port adapter for GitHub. Reached through the bindings (ports.code-host = code-host-github), not invoked directly.
disable-model-invocation: true
---

# code-host-github

Implements the `code-host` contract in [ports](../workflow/references/ports.md).

**Config:** `code-host-github.repo`, which defaults to the current repo.
**Tool:** `gh`. Confirm `gh auth status` first, and check flags with `gh <cmd> --help`.

| Port op | gh |
|---|---|
| open-pr | `gh pr create --base … --head … --title … --body-file …` |
| get-pr | `gh pr view [<ref>] --json number,title,state,url,statusCheckRollup` |
| review-threads | `gh api graphql`: `pullRequest.reviewThreads` (id, isResolved, path, line, comments) |
| reply | `gh api graphql`: `addPullRequestReviewThreadReply` |
| checks | `gh pr checks <ref>` (non-zero while pending: read the output) |
| merged-prs | `gh pr list --state merged --search "merged:>=<tag date>" --json number,title,author,labels,mergeCommit` |
| create-release | `gh release create <tag> --target <sha> --title … --notes-file …` |

Always pass bodies and notes as files. Inline strings mangle backticks and newlines.

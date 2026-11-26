---
name: release
description: Prepare and publish a GitHub release. Collects merged PRs since the last tag, drafts notes and a semver version, and publishes only after you approve. Run /release [since <tag>] [version].
disable-model-invocation: true
---

# Release

Publishing is visible to everyone, so it always waits for your approval, in every mode.

## Steps

1. **Range.** The default is the latest tag (`git describe --tags --abbrev=0`) to `branch.base`. Confirm that `branch.base` is up to date with its remote and that its CI checks are green. Report any check that isn't.
2. **Collect** merged PRs with the code-host's `merged-prs` (see [ports](../workflow/references/ports.md)). Pull the ticket refs from their titles and bodies.
3. **Version.** Propose the semver bump from the PRs: a breaking change (`!` or a `BREAKING CHANGE` note) is major, `feat` is minor, everything else is patch. An explicit argument wins.
4. **Draft notes** into a temp file:

   ```markdown
   ## <version> · <date>
   ### Breaking changes   (what users must do)
   ### Features
   - <user-facing sentence> (#PR, ticket)
   ### Fixes
   ### Internal          (one line per PR, or omitted)
   ```

   Write each entry for a user, not as the PR title. Every merged PR appears in exactly one section.

5. **Present and wait.** Show the version, the tag, the target commit and the notes.
6. **Publish** with `create-release` once approved. Then offer to `transition done` or `comment` the version on the included tickets.

**Done when** the release URL exists and every merged PR in the range is in the notes.

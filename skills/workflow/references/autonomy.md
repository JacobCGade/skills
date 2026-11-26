# Autonomy modes

One mode governs a run. Resolve it in this order: a `mode=` argument, then `autonomy:` in the bindings, then `balanced`. State the mode in your first message: "Mode: balanced."

| | collaborative | balanced (default) | autopilot |
|---|---|---|---|
| Before building | Approve the plan, and read-ticket must pass | Approve the plan once | Read-ticket must pass. No approval needed |
| Between slices | Post the digest, then **wait** for "go" | Post the digest, keep going | Append to the log and the brief, keep going |
| Open question mid-run | Ask | Make a ruling if reversible, ask if not | Make a ruling |
| Parallelism | One slice at a time | One slice at a time | Independent tickets in parallel via `/fleet` or `implementer` agents |
| Gates (tdd, lean, verify, review) | All | All | All. Autonomy never removes a gate |

## Rulings

A **ruling** is a decision you made in place of asking. Write it in the build log and in the brief's Progress section:

`Ruling: <what you decided> | why: <reason> | cost if wrong: <what the human must undo>`

Pick the option that is cheapest to reverse. The ticket's acceptance criteria are the authority, and your judgment settles what they don't answer.

## Always needs your approval, in every mode

- **Creating or rewriting tickets** (`to-tickets`, `refine-ticket`). Tickets are human-facing. Comments and transitions on the ticket being built are fine.
- **Anything posted under your name** on a PR (`pr-feedback`), and publishing a release (`release`).

## Hard stops

In every mode, stop and ask before any of these:

- An irreversible or destructive operation: deleting data, rewriting shared history, a destructive migration.
- Anything security-sensitive: credentials, auth logic, permissions, secrets.
- A side effect outside the working branch that the plan didn't name: pushing to a shared branch, merging, deploying, or messaging people.
- A plan so broken that every path forward is a guess.

Present the decision, the options and your recommendation, then wait.

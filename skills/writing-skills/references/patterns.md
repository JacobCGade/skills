# Patterns from the leading skill sets

This is the research behind this skill set. Sources were read in November 2026: obra/superpowers, mattpocock/skills, addyosmani/agent-skills, Lauren Tan's pstack (cursor/plugins), anthropics/skills (skill-creator), multica-ai/andrej-karpathy-skills, affaan-m/everything-claude-code and github/awesome-copilot.

## Shape of the sets

| Set | Skills | Median SKILL.md lines | Style |
|---|---|---|---|
| pstack | 59 | 19 | One router (`/poteto-mode`) plus 22 playbooks. 58 of 59 skills are user-invoked principle and tool leaves, read by path |
| mattpocock | 39 | 75 | Small composable primitives. User-invoked orchestrators over model-invoked disciplines |
| superpowers | 15 | 205 | A mandatory methodology. A bootstrap skill forces skill checks before any action |
| awesome-copilot | 478 | 138 | A catalog of domain and tool skills |
| addyosmani | 26 | 304 | Lifecycle phases (define → ship) with a fixed section template and evals in CI |

All of them converge on the same spine: **align → spec → slice → TDD build → verify → fresh-context review → PR → retro**. They differ in how much they enforce it and how much they let you swap it.

## Patterns adopted here

1. **The description is a trigger.** "Use when …" plus symptoms. Superpowers measured that a description summarising the workflow makes the agent follow the summary and skip the body. Anthropic adds that agents under-trigger, so make the triggers concrete and slightly pushy.
2. **Two invocation tiers.** User-invoked orchestrators cost no context. Model-invoked disciplines cost context on every turn, so keep them few and sharp (Matt's split, and pstack's extreme version of it).
3. **A router skill** cures "I can't remember which skill" (ask-matt, poteto-mode, using-superpowers). Here it is `workflow`.
4. **Composition by primitive.** Matt's `grill-me` is 7 lines that delegate to `grilling`. Shared reference lives in one place (Addy's `references/`, Matt's model-invoked reference skills).
5. **Ports and adapters** (this set's addition). Matt's per-repo `docs/agents/issue-tracker.md` hints at it. Here every external tool sits behind a contract, so process skills stay tool-agnostic. An offline `tracker-local` adapter stands in until Jira access is approved. **Two audiences per ticket:** The tracker ticket is short and templated for humans. A local agent brief holds the detail a fresh-context agent needs. The ticket wins any conflict.
6. **Progressive disclosure.** SKILL.md stays under 500 lines, references sit one level deep, and scripts are preferred to inline code (Anthropic, Addy).
7. **Evidence gates.** superpowers `verification-before-completion`, pstack `prove-it-works`, plus a per-repo verification skill that drives the real app (pstack `create-verification-skill`, the `app-driver` port here).
8. **Fresh-context review.** Matt's two-axis review (spec and standards) runs in parallel subagents. pstack's `interrogate` keeps only findings proven by a run. Addy's doubt-driven development reviews decisions mid-flight.
9. **The form fits the failure.** Rationalization tables and red flags suit discipline failures (superpowers, Addy). Positive recipes suit shape failures, because a prohibition puts the banned behaviour in context (Matt's "negation" and superpowers' A/B tests). Explain why instead of shouting MUST (Anthropic).
10. **Encode lessons in structure.** pstack `correct` and Matt `retro`: architecture, then types, then lint, then test, then docs, in that order.
11. **An explicit autonomy contract.** superpowers' "rulings, not stalls" and its four stop conditions. pstack's "never block on the human" for reversible work.
12. **Test skills like code.** Run a baseline without the skill (red), then with it (green), then with pressure scenarios (superpowers `writing-skills`). Addy adds trigger and collision evals in CI. Anthropic's skill-creator adds blind A/B comparison.
13. **Leading words.** Compact pretrained concepts (tracer bullet, red loop, seam, deep module) anchor behaviour in few tokens (Matt `writing-for-agents`).
14. **The environment is the source of truth.** Don't copy `--help` or `package.json` into a skill, because copies go stale (Matt).

## Patterns deliberately not adopted

- **Adversarial "prove it with a run" review** (pstack `interrogate`). It overlaps the two-axis review, and you chose the latter.
- **Mandatory skill checks before every message** (superpowers `using-superpowers`). That is heavy context load on every turn, and it fights a selectable-autonomy design.
- **Refactor inside the TDD loop.** Like Matt Pocock, this set keeps refactoring out of the loop: the loop is red, green, lean, and structural change goes to `/refactor` or to review.
- **Per-vendor model routing** (pstack). Copilot CLI picks the model per custom agent. Set `model:` on an agent if you need it.
- **Large monolithic skills** (Addy's ~300 lines). They are harder to compose and harder to keep relevant.

## Copilot CLI facts these skills rely on

- Personal skills live in `~/.copilot/skills` or `~/.agents/skills`. Project skills live in `.github/skills`, `.claude/skills` or `.agents/skills`.
- The documented frontmatter is `name`, `description`, `license` and `allowed-tools`. `disable-model-invocation` is honoured in practice and documented for custom agents. Confirm a skill's state with `/skills info`.
- You invoke a skill explicitly by typing `/skill-name` in a prompt. `/skills reload` picks up changes.
- Custom agents are `~/.copilot/agents/<id>.agent.md`, with frontmatter `name`, `description`, `tools`, `model`, `disable-model-invocation` and `user-invocable`. Tool aliases: `read`, `edit`, `search`, `execute`, `agent`, `web`, `todo`. The main agent can delegate to them as subagents with their own context window.
- Built-ins worth composing with, not duplicating: `/plan`, `/fleet` (parallel subagents), `/review`, `/research`, `/autopilot`, `/compact`, `/share`.

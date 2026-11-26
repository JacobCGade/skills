---
name: writing-skills
description: Create, change or test a skill in this set, or add an adapter for a new tool (Linear, GitLab, and so on). Run /writing-skills <what you want>.
disable-model-invocation: true
---

# Writing skills

A skill is a pointer (its description) and a body. Both are prompts, so write them like code: small, single-purpose and tested. The patterns behind these rules, and where they come from, are in [references/patterns.md](references/patterns.md). Read it before you write a new skill.

## 1. Decide that it should be a skill

| The need | Put it in |
|---|---|
| A rule a tool can enforce | A check (analyzer, lint, test), not prose |
| A repo convention (naming, folders, stack) | `AGENTS.md` |
| A specialist with its own tools or model | A custom agent in `agents/` (see the README for per-harness install) |
| A repeatable process or a judgment call | A skill |
| A new external tool behind an existing port | An adapter skill. See [ports](../workflow/references/ports.md) |

## 2. Pick the layer and the invocation

- **Orchestrator** (a multi-step process the user starts): `disable-model-invocation: true`. The description is a human-facing summary that ends with "Run /name …".
- **Discipline** (judgment the agent must apply on its own): model-invoked. The description starts "Use when …" and lists the triggers and symptoms only. Never summarise the steps: the agent follows the summary and skips the body.
- **Adapter:** `disable-model-invocation: true`. It is reached only through a port. Keep it lean: config keys, the tool (MCP first, then CLI), and a table mapping each port operation to the tool. Use `tracker-jira` as the model. Flags come from `--help`, never copied in. A script is the one addition, and only when the work must be deterministic (see `tracker-local/scripts`).
- **Templates and shared formats:** a template used by one skill family sits beside that skill (`to-tickets/ticket-template.md`). One used across the set goes in `workflow/references/`.

Respect the layering in [ports](../workflow/references/ports.md). Reach another skill by its sibling path, `../<name>/SKILL.md`.

## 3. Write the body

- Open with the core principle as one **leading word** or line ("Evidence before claims", "red loop").
- Write steps that each end in a checkable **Done when**.
- Choose the form that fits the failure. For a rule the agent skips under pressure, use a short rationalization table. For output with the wrong shape, give a positive template of what the output *is*. For a missing element, add a required slot in the template.
- State the positive target, not the ban. Explain *why* where the reason changes behaviour. Drop ALL-CAPS MUSTs.
- Keep it under 100 lines when you can and under 500 always. Move branch-specific reference into `references/`, one level deep, linked with the condition for reading it.
- Don't restate what the environment answers (`--help`, `package.json`, the build files). Cache only what no lookup reveals.
- Delete every sentence that doesn't change behaviour compared with the default.

## 4. Test it like code

1. **Red.** Run a realistic prompt in a fresh session in your harness without the skill. Note what goes wrong, verbatim.
2. **Green.** Run the same prompt with the skill. The failure is gone.
3. **Trigger check** (disciplines only): three prompts that should fire it and two that shouldn't. Fix the description, not the body, when triggering is wrong.
4. **Pressure check** for disciplines: add "quick, just ship it" to the prompt. The gate still holds.

Then reload skills in your harness and confirm the skill is listed.

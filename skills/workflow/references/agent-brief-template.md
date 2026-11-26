# Agent brief template

A ticket is written for humans, so it stays short. The **brief** is its local, agent-facing companion. It carries what an agent starting from a fresh context needs and the ticket leaves out. There is one brief per ticket, at `<docs.briefs>/<ref>.md` (default `.agents/briefs/`, gitignored).

## Rules

- **The ticket wins.** The ticket's acceptance criteria are the authority. If the brief contradicts the ticket, follow the ticket and flag the conflict to the user.
- **Pointers, not copies.** Hold what the code can't tell you (decisions, reasons, gotchas) and point to `file:line` for everything else. A copied snippet goes stale. A pointer doesn't.
- **Fixed headings.** Every heading is present. A section that doesn't apply says `n/a: <reason>`, so a skipped section never looks forgotten.
- **Each skill writes only its own sections:**
  - `to-tickets`, `read-ticket` and `refine-ticket` write Context, Decisions, Domain terms and Constraints.
  - `implement` writes Plan and Progress.
- **Freshness:** `ticket-updated` holds the ticket's `updated` timestamp as of the last time the brief was synced. `read-ticket` compares it with the live ticket and refreshes the brief when the ticket is newer.

## Template

```markdown
---
ticket: <ref>
ticket-updated: <ISO timestamp from tracker get>
---
# Brief: <ref> · <ticket title>

## Context
- Modules and entry points involved: `path/File.cs:42` (what it does here)
- Seams to test at: <public interface> (what it catches)
- Related tickets: <parent / blockers / siblings and why they matter>

## Decisions
- <decision> | why: <reason> | source: grill <date> / refine / ADR-0007

## Domain terms
- **<term>**: <one-line meaning in this ticket>. Avoid: <rejected synonyms>

## Constraints
- <standard, invariant, or "don't touch X because Y">
- Gotchas: <the thing you'd only learn the hard way>

## Plan
| # | Slice outcome | Seam | Est. diff | State |
|---|---|---|---|---|

## Progress
- <date> slice 1 done → build log "<entry title>"; evidence: <command → result>
- Ruling: … | why: … | cost if wrong: …
- Open: <question for the human>
```

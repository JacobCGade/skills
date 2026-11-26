---
name: prototype
description: Use when a design question can be settled faster by running throwaway code than by discussion (library behaviour, performance shape, an API's real responses, how a UI flow feels), or when the user asks to prototype, spike in code, or try something out.
---

# Prototype

**Settle it by running it.** A prototype answers one question, and then it is thrown away.

## Steps

1. **Write the question** in one sentence, plus what answer would change the decision. For example: "Does EF Core translate this LINQ to one query? If not, we need a view."
2. **Pick the smallest form** that answers it: a script, a console app, a single HTML file, or a scratch test. Put it in `docs.prototypes/<slug>/` (gitignored), never in `src`.
3. **Run it and observe.** Capture the output, a measurement or a screenshot. When the question is about feel ("which layout reads better?"), build 2-3 variants side by side.
4. **Report the answer** with its evidence, and the decision it implies.

## Rules

- Don't put prototype code into the product. If the answer is "yes, do it this way", the real implementation goes through `/implement` with tests.
- Don't polish it: no error handling, no structure, no tests beyond what answers the question.
- Record the result where it will be read: in the grill conversation, in the brief's **Decisions** section, or in an ADR if the decision is hard to reverse.

**Done when** the question has an observed answer, the decision is recorded, and the prototype folder is either deleted or noted as kept for reference.

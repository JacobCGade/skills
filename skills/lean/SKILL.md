---
name: lean
description: Use when writing, changing or reviewing code, when a diff grows larger than expected, or when tempted to add an abstraction, interface, layer, option, helper, base class or "future-proofing".
---

# Lean

Write the **smallest change that meets the outcome**. Every changed line traces back to the ticket. Code you didn't write has no bugs, needs no review, and costs the reader nothing.

## The recipe

1. **Subtract first.** Before adding, look for dead code, one-caller wrappers or duplicate paths you can delete so the change lands on a simpler base.
2. **Use what exists.** Extend the existing module, pattern or library before you create a new one. Match the surrounding style.
3. **Inline until the third use.** Extract a shared helper or abstraction when a third real caller appears, not before. Two similar blocks are cheaper than the wrong abstraction.
4. **Make modules deep.** Put a lot of behaviour behind a small interface. A new type, interface or layer earns its place by hiding complexity, not by forwarding calls.
5. **Apply SOLID at seams that exist today.** Use dependency inversion at real boundaries (I/O, external services, the clock). Add an interface when there is a second implementation or a test seam that needs it. Single responsibility means one reason to change, not one method per class.
6. **Handle only possible failures.** Guard at system boundaries (user input, network, files). Trust your own internal types.
7. **Touch only what the ticket needs.** When you spot something else, note it in the build log's **Open** line and don't fix it.

## Smells to cut

- **Speculative generality:** parameters, options, hooks or generics no caller uses today.
- **Middle man:** a class or function that only delegates.
- **One-implementation interface** with no test seam need.
- **Configuration for a value that never changes.**
- **Shotgun surgery:** one logical change spread over many files. Gather what changes together.
- **Defensive checks** for states your types already rule out.

## Rationalizations

| Thought | Reality |
|---|---|
| "We'll need it later" | Later has its own ticket. Delete it now and it's free to add then |
| "It's more SOLID / cleaner this way" | Indirection is not clean. Count the layers a reader must follow |
| "Just a small helper" | A helper with one caller is a function the reader must jump to |
| "Might as well fix this while I'm here" | It widens review and blast radius. Log it and move on |
| "Enterprise code has these layers" | The codebase's own patterns set the bar, not a template |

## Self-check before commit

- Diff size against the estimate. More than double means simplify or split.
- For each new type, file or interface: what complexity does it hide? No answer means inline it.
- Would a senior engineer say "this could be half the size"? Then make it half the size.

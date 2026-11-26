# Build log

Agents build faster than a human can follow. The build log keeps you oriented. Every slice adds one entry, written for a reader who skipped the session. It lives at `docs.build-log` (default `.agents/build-log.md`), with the newest entry at the top.

## Entry shape

At most 15 lines. If it needs more, the slice was too big, so split the next one.

```markdown
## 2026-11-25 · L-2 · Reject expired vouchers at checkout
- **Intent:** a checkout with an expired voucher fails with a clear error, not a 500.
- **Changed:** `Checkout` module (VoucherPolicy, CheckoutEndpoint); `web/checkout` (error toast).
- **Decision:** validate in VoucherPolicy, not the endpoint, so the batch importer gets the rule too. Rejected: a DB constraint (no user-facing message).
- **Evidence:** `dotnet test --filter Voucher` → 14 passed; UI journey "apply expired voucher" shows the toast.
- **Diagram:** (only when structure or flow changed)
  ```mermaid
  flowchart LR
    CheckoutEndpoint --> VoucherPolicy --> VoucherRepo
  ```
- **Open:** should expired vouchers still show in the wallet?
```

A ruling is a one-line entry: `Ruling: … | why: … | cost if wrong: …` (see [autonomy.md](autonomy.md)).

## Slice digest

The digest is what you post in chat after each slice. It contains the entry's Intent, Changed, Evidence and Open lines and nothing else.

## Rules

- Group **Changed** by module, never as a flat file list.
- **Evidence** is a command and its result, or an artifact path. Write no adjectives.
- Add a **Diagram** only when a boundary, a dependency or a flow changed. Use the smallest one that shows it.
- When a decision is hard to reverse (a schema, a public contract, a dependency), write an ADR in `docs.adr` and link it from **Decision**.

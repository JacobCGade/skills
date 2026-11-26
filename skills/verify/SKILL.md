---
name: verify
description: Use before claiming any work is done, fixed, passing or working, before committing, opening a PR, or reporting a subagent's result as complete.
---

# Verify

**Evidence before claims.** A claim is only as good as the fresh command output behind it.

## The gate

1. **Name the claim.** For example: "expired vouchers are rejected at checkout."
2. **Pick the proof** that observes the real thing. The commands come from `checks` in the bindings (see [ports](../workflow/references/ports.md)):

   | Claim | Proof | Not proof |
   |---|---|---|
   | Tests pass | `checks.test` output, 0 failures, exit 0 | An earlier run, "should pass" |
   | It builds | `checks.build` exit 0 | Lint passing |
   | The bug is fixed | The original repro now passes | The code changed |
   | The user can do X | `checks.app` driving the journey, with an artifact | Unit tests alone |
   | The subagent finished | Your own read of the diff plus your own check run | Its report |
   | The ticket is met | Each acceptance criterion with its evidence | Green tests |

3. **Run it now**, in full. Read the whole output and the exit code.
4. **Report** the claim with its evidence: the command and its result, or an artifact path. If the proof failed or was inconclusive, say so plainly. "Inconclusive" is not a pass.

## Words that mean you skipped the gate

"Should work", "probably", "looks right", "I'm confident", "Done!" with no output above it. Replace each with a command and its result.

## When the check itself is suspect

If a result surprises you, suspect the observation before the system: wrong directory, a stale build, a filtered test run, cached output. Rerun it clean.

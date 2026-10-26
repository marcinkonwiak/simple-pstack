---
name: playbook-feature
description: "Use when adding or changing behavior: a new feature, component, endpoint, option, or flow."
---

# Feature

**You own the design. Plan, review, verify.**

1. `how` over the affected subsystem.
2. Design before implementing. Sketch types, function signatures, class shapes, and module boundaries with `not implemented` bodies and pseudocode. Synthesize across multiple model perspectives, then fill in code against the chosen sketch. If implementation proves the sketch wrong, throw it out and redesign. Build a real mental model of every system the new code touches.
3. Screen the design with the **playbook-design-red-flags** skill before continuing.
4. Implement against the sketch. Make surgical edits, and re-ground against the source for upstream-derived files. Port shared-primitive improvements to all consumers and verify each. Commit liberally.
5. Verify on the matching surface. "Inconclusive" or wrong-surface is not a pass. Flag it.
6. Rebase into small, ordered commits. Stack follow-ups. For bigger changes, stack PRs.
   Use the **sequence-verifiable-units** principle skill, building, verifying, and committing each small unit before the next.
7. Run the **playbook-opening-a-pr** skill.

**Reply:** what you built, what you chose and why, open decisions. Tables for design alternatives.

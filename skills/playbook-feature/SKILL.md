---
name: playbook-feature
description: "Use when adding or changing behavior: a new feature, component, endpoint, option, or flow."
---

# Feature

**You own the design. Plan, review, verify.** Delegate implementation. Stay in the lead.

1. `how` over the affected subsystem.
2. Design before implementing. Sketch types, function signatures, class shapes, and module boundaries with `not implemented` bodies and pseudocode. Synthesize across multiple model perspectives, then fill in code against the chosen sketch. If implementation proves the sketch wrong, throw it out and redesign. Build a real mental model of every system the new code touches.
3. Screen the design with the **playbook-design-red-flags** skill before continuing.
4. Delegate code-writing to a subagent with a specific scope (file paths, named data shape and its organizing structure per **principle-model-the-domain**, a state machine over scattered booleans, a table/registry over branching, a typed model over repeated shape assumptions, chosen before the delegate writes logic, and success criteria). Mandatory: no skip-with-reason escape, and Laziness Protocol does not override it (the gain is review separation, not lines saved). A subagent forbidden to spawn satisfies this by owning the diff directly with the same review separation. No "standing by" reply that waits on a nested agent. Surgical edits, re-ground against the source for upstream-derived files. Port shared-primitive improvements to all consumers and verify each. Commit liberally.
5. Verify on the matching surface. "Inconclusive" or wrong-surface is not a pass. Flag it.
6. Rebase into small, ordered commits. Stack follow-ups. For bigger changes, stack PRs.
   Use the **sequence-verifiable-units** principle skill, building, verifying, and committing each small unit before the next.
7. Run the **playbook-opening-a-pr** skill.

**Reply:** what you built, what you chose and why, open decisions. Tables for design alternatives.

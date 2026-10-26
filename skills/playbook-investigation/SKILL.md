---
name: playbook-investigation
description: "Use when the task is a read-only question: how does X work, why was Y built this way, are we sure about Z, should we do X or Y."
---

# Investigation

**You own the answer. Plan, route, write.**

Investigation requests are read-only. They produce a cited explanation or a recommendation, not a code change.

1. Route through the **how** skill. For motivation questions, also route through the **why** skill.
2. Produce the `how`-shaped output (Overview / Key Concepts / How It Works / Where Things Live / Gotchas), or a recommendation with a tradeoffs table if the request is a decision between alternatives.
3. Apply the **unslop** skill to the reply.

No commit, no PR unless the investigation precedes a code change. If it does, hand back to the user and re-route to the **playbook-bug-fix** or **playbook-feature** skill.

**Reply:** the investigation output. For "are we sure?" answers, include your real judgment with reasons. Push back if the premise is wrong (see Autonomy).

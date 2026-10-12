---
name: how
description: "Use for \"how does X work\", code walkthroughs before changing something, and placement / ownership / layering questions (\"where should this live\", \"which package owns this\", \"is this the right layer\"). Explains subsystem architecture, runtime flow, onboarding mental models. Use why for motivation."
---

# How

Explore the codebase to answer "how does X work?" questions. Produce architectural explanations at the level of a senior engineer onboarding onto a subsystem, enough to build a working mental model, not so much that it reads like annotated source code.

## Step 1. Assess Complexity

If the scope is ambiguous, state your interpretation and explore. The user can redirect.

- **Simple** (a single module, a small utility, a narrow question such as "how does function X work"): no explorers. Explore and explain in a single pass yourself. Go to Step 2a.
- **Complex** (a subsystem spanning multiple services, a cross-cutting feature, a full architectural overview): spawn parallel explorers first, then synthesize their findings. Go to Step 2b.

When in doubt, take the simple path.

## Step 2a. Direct Explain (simple questions)

Explore it inline by yourself. Follow the Exploration Instructions in `references/explorer-prompt.md`. Skip its Output section, and write the explanation directly in the Output Format below. Go to Step 4.

## Step 2b. Explore (complex questions only)

Decompose the question into 2 to 4 exploration angles, each a distinct slice of the subsystem. Spawn all explorer subagents in a single message.

Each explorer gets the prompt in `references/explorer-prompt.md` with its angle filled in. Then go to Step 3.

## Step 3. Synthesize (complex questions only)

Once all explorers have returned, synthesize their findings into one explanation yourself. Follow the Instructions and Communication Style in `references/explainer-prompt.md`.

## Step 4. Present

Present the output to the user.

## Output Format

The explanation uses the sections defined in `references/explainer-prompt.md`, dropping any that do not apply: Overview, Key Concepts, How It Works, Where Things Live, Gotchas.

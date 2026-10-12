---
name: why
description: "Use for 'why does X work this way', 'why we picked Y', design rationale, regressions, postmortems, or data-backed thresholds. Use `how` for runtime behavior."
---

# Why

Investigate the motivation and intent behind code.

Companion to the `how` skill. `how` answers what the code does and how it works. `why` answers what forces led to its shape.

## Operating Posture

Operate as a **careful, cautious, and precise investigator**. Be honest about what you know vs what you're inferring. Read `references/epistemics.md` for the full confidence framework and phrasing guide.

## Step 1. Understand the Target and the Question

Parse what the user is asking. The **target** is usually a chunk of code, a pattern, a feature, or a named design decision. The **question** is usually a design rationale, a tradeoff, a motivating edge case, an external constraint, dead code, or a broad history sweep.

If the target is vague ("why do we do it this way?" with no clear referent), make your best guess from conversation context (open files, recent edits, cursor location, what was just discussed). State your interpretation briefly so the user can redirect if you're off, then proceed.

## Step 2. Establish the Code Anchor

Before investigating, anchor the investigation in concrete code. You need:

- The relevant file path(s) and line range(s)
- The key symbols (function names, class names, constants)
- An initial commit list. The last few commits touching the target.
- PR numbers from merge commits (pattern `(#1234)` in the subject line)

Build this inline.

```bash
# Blame target lines for last-touch commits
git blame -L <start>,<end> <file>

# Full file history, with patches, through renames
git log --follow -p -- <file>

# Last N commits touching the file, PR numbers visible
git log --oneline -20 -- <file>

# Extract PR numbers from a commit message
git log -1 --format=%B <commit>
```

Pull PR bodies and discussion via `gh` for any substantive commits:

```bash
gh pr view <number> --json title,body,author,createdAt,mergedAt,labels,closingIssuesReferences,comments,reviews
```

Capture this as seed context (file paths, symbols, commits, PR numbers, linked ticket IDs).

## Step 3. Investigate

Investigate from the code anchor, then synthesize the evidence yourself. Search every source you can reach: git history, PRs and issues through `gh`, code comments, tests, and docs in the repository. Name the sources you could not reach.

## Step 4. Present

Use these sections in order. Keep the confidence tiers from `references/epistemics.md` on every claim.

- **The Question.** Restate it in one or two sentences.
- **The Code in Question.** File paths, line ranges, key symbols.
- **What We Found.** Claims with direct evidence, one per bullet, each tagged `[Direct]` or `[Supported]` and cited (PR, issue, commit hash, or file:line).
- **What We Can Reasonably Infer.** `[Inferred]` claims in hedged language, with the inference chain visible. Skip if there is nothing to infer.
- **Competing Hypotheses.** When the evidence fits more than one story, give each with its evidence for and against. Skip if there is a single clear answer.
- **What We Don't Know.** Specific unanswered questions and the searches that returned nothing.
- **Sources Consulted.** One line per source, including the ones that returned nothing or could not be searched, with the reason.
- **Confidence Summary.** One or two sentences on overall confidence.

If the question is a precursor to changing this code, end with a Preserve / Change / Avoid / Risk constraint set for planning the change.

## Common Failure Modes to Avoid

- **Recency bias**. Assuming the most recent commit is authoritative. The current shape is often the accretion of many earlier decisions. Trace back.


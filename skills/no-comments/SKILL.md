---
name: no-comments
description: "Delete comments from the current diff or the named files, keeping only the few that code cannot replace. Use for /no-comments, 'strip the comments', or before review."
---

# No comments

Delete comments yourself. When in doubt, the comment dies.

## Scope

Use the caller's files or diff. Otherwise use the current diff against the base branch, default `main`, including the working tree. In a diff, touch only comments on added or changed lines.

## Keep

Only these survive.

- Legal or license headers.
- Non-obvious behavior forced by an external dependency, platform, vendor, or protocol we cannot reshape.
- `// prettier-ignore`, and lint suppressions whose rule is faulty, pedantic, or style-only.
- Doc comments that define a public API contract.
- Issue or RFC links that explain a constraint code cannot express.

Everything else goes: narration, banners, commented-out code, TODOs without an issue link, workaround explanations, and restatements of what the code does.

## Steps

1. List every comment in scope. Read the code around each one before judging it.
2. Delete each comment that has no keep clause. Never shorten or reword a comment to save it. It stays as written or it goes.
3. `eslint-disable`, `@ts-ignore`, `@ts-expect-error`, and similar suppressions: look up the rule. If it catches real bugs or protects correctness or safety, remove the suppression and fix the code it hid. If the fix is not small or leaves the scope, keep the suppression and flag it.
4. Run the project's typecheck, lint, and tests that cover the touched files.
5. Report the deletion count, the comments kept with the clause each one met, the code fixes made, and the flags left open, one line each.

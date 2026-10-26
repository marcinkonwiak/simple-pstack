#!/usr/bin/env bash
# Copy every skill into Claude Code and Codex. Safe to re-run.
# Usage: ./install.sh            install or update skills
#        ./install.sh --remove   remove the skills this repo installed
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST=".simple-pstack-installed"
TARGETS=("$HOME/.claude/skills" "$HOME/.agents/skills")
# Extra Claude config dirs get skills only when they already exist.
for config in .claude_personal .claude_work; do
  if [[ -d "$HOME/$config" ]]; then TARGETS+=("$HOME/$config/skills"); fi
done
REMOVE=0
[[ "${1:-}" == "--remove" ]] && REMOVE=1

for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  manifest="$target/$MANIFEST"
  count=0

  # Drop every skill the last install recorded, so renamed or deleted skills don't linger.
  if [[ -f "$manifest" ]]; then
    while IFS= read -r name; do
      [[ -n "$name" && "$name" != */* && "$name" != .* ]] || continue
      [[ -e "$target/$name" || -L "$target/$name" ]] || continue
      rm -rf "${target:?}/$name"
      [[ "$REMOVE" -eq 1 ]] && count=$((count + 1))
    done < "$manifest"
    rm "$manifest"
  fi

  if [[ "$REMOVE" -eq 0 ]]; then
    for skill in "$ROOT"/skills/*/; do
      skill="${skill%/}"
      name="$(basename "$skill")"
      if [[ -e "$target/$name" || -L "$target/$name" ]]; then
        printf 'skip %s (already exists in %s)\n' "$name" "$target"
        continue
      fi
      cp -R "$skill" "$target/$name"
      printf '%s\n' "$name" >> "$manifest"
      count=$((count + 1))
    done
    printf 'installed %d skills into %s\n' "$count" "$target"
  else
    printf 'removed %d skills from %s\n' "$count" "$target"
  fi
done

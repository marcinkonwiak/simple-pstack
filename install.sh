#!/usr/bin/env bash
# Link every skill into Claude Code and Codex. Safe to re-run.
# Usage: ./install.sh            link skills
#        ./install.sh --remove   remove the links this repo owns
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGETS=("$HOME/.claude/skills" "$HOME/.agents/skills")
REMOVE=0
[[ "${1:-}" == "--remove" ]] && REMOVE=1

for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  count=0

  # Drop links that point into this repo, so renamed or deleted skills don't linger.
  for link in "$target"/*; do
    [[ -L "$link" ]] || continue
    source="$(readlink "$link")"
    [[ "$source" == /* ]] || source="$(dirname "$link")/$source"
    [[ "$(dirname "$source")" -ef "$ROOT/skills" ]] || continue
    rm "$link"
    [[ "$REMOVE" -eq 1 ]] && count=$((count + 1))
  done

  if [[ "$REMOVE" -eq 0 ]]; then
    for skill in "$ROOT"/skills/*/; do
      skill="${skill%/}"
      name="$(basename "$skill")"
      if [[ -e "$target/$name" || -L "$target/$name" ]]; then
        printf 'skip %s (already exists in %s)\n' "$name" "$target"
        continue
      fi
      ln -s "$skill" "$target/$name"
      count=$((count + 1))
    done
    printf 'linked %d skills into %s\n' "$count" "$target"
  else
    printf 'removed %d links from %s\n' "$count" "$target"
  fi
done

#!/usr/bin/env bash
# Fail if any .claude/commands/*.md is missing name or description in YAML frontmatter.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CMD_DIR="${ROOT}/.claude/commands"
FAILED=0

for f in "${CMD_DIR}"/*.md; do
  [[ -e "$f" ]] || { echo "No command files in ${CMD_DIR}" >&2; exit 1; }
  fm="$(awk '/^---$/{if (++n == 2) exit; next} n == 1' "$f")"
  if ! grep -qE '^name:' <<<"$fm"; then
    echo "error: missing 'name' in frontmatter: $f" >&2
    FAILED=1
  fi
  if ! grep -qE '^description:' <<<"$fm"; then
    echo "error: missing 'description' in frontmatter: $f" >&2
    FAILED=1
  fi
done

if [[ "$FAILED" -ne 0 ]]; then
  exit 1
fi

echo "ok: all command files have name and description in frontmatter" >&2

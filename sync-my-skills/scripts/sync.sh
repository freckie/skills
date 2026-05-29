#!/usr/bin/env bash
#
# sync.sh — Symlink skills from the `skills` repo into a local LLM skills directory.
#
# Usage:
#   ./sync.sh [local-skills-path]
#
#   local-skills-path   Target skills dir. Defaults to ~/.claude/skills.
#                       For Codex, pass ~/.codex/skills.
#
# Environment:
#   SKILLS_REPO         Repo location. Defaults to ~/prj/skills.
#
# Behavior:
#   - git pull origin main in the repo
#   - symlinks every skill folder (a directory containing SKILL.md) that is
#     missing in the local path
#   - never overwrites a real (non-symlink) directory of the same name
#   - reports broken symlinks pointing into a now-removed skill (does NOT delete
#     them — review and remove manually)

set -eo pipefail

REPO="${SKILLS_REPO:-$HOME/prj/skills}"
LOCAL="${1:-$HOME/.claude/skills}"

if [[ ! -d "$REPO" ]]; then
  echo "error: skills repo not found at $REPO (clone it yourself first)" >&2
  exit 1
fi

mkdir -p "$LOCAL"

echo "==> git pull in $REPO"
git -C "$REPO" pull origin main

linked=()
conflicts=()
broken=()

# 1) Link skills that are missing locally.
for dir in "$REPO"/*/; do
  name="$(basename "$dir")"
  [[ -f "$dir/SKILL.md" ]] || continue          # skip non-skill folders
  target="$LOCAL/$name"
  if [[ -L "$target" ]]; then
    continue                                     # already linked
  elif [[ -e "$target" ]]; then
    conflicts+=("$name")                         # real dir/file blocks linking
    continue
  fi
  ln -s "${dir%/}" "$target"
  linked+=("$name")
done

# 2) Detect broken symlinks (target no longer exists in the repo).
for link in "$LOCAL"/*; do
  [[ -L "$link" && ! -e "$link" ]] && broken+=("$(basename "$link")")
done

# 3) Report.
report() { if [[ $# -le 1 ]]; then echo "$1: (none)"; else local l="$1"; shift; echo "$l: $*"; fi; }
echo
report "newly linked" "${linked[@]}"
report "conflicts (real dir, skipped)" "${conflicts[@]}"
report "broken symlinks (review/remove manually)" "${broken[@]}"

---
name: sync-my-skills
description: Sync local LLM skills (Claude / Codex) with the `skills` repo — pulls latest and symlinks any missing skills.
user-invocable: true
---

# Sync My Skills

Keep the LLM's local skills directory in sync with the user's `skills` repository by creating symlinks for any skill folders that exist in the repo but not yet under the local skills path.

## Prerequisites: `skills` Repository

- Expected location: `~/prj/skills`
- Skills live at the repo root: `~/prj/skills/` (one directory per skill, each containing a `SKILL.md`)
- **If `~/prj/skills` does not exist**, stop and ask the user to clone it themselves. Do NOT clone it directly — the user manages repo placement and remote URLs.

## Detect Which LLM

Determine the current LLM context and the matching local skills directory:

| LLM    | Local skills path     |
| ------ | --------------------- |
| Claude | `~/.claude/skills`    |
| Codex  | `~/.codex/skills`     |

If unsure, infer from the environment (e.g. you are running as Claude Code → use `~/.claude/skills`).

## Sync Procedure

1. **Pull the latest `skills`:**
   ```bash
   git -C ~/prj/skills pull origin main
   ```

2. **Diff the two directories.** For each skill folder at the root of `~/prj/skills/`, check whether a corresponding symlink exists in the local skills path. Skip `.git` and any non-skill entries (a skill folder is a directory containing a `SKILL.md`; ignore top-level files like `README.md`).
   ```bash
   ls ~/prj/skills/
   ls -la <local-skills-path>/
   ```
   Note: a regular directory (non-symlink) with the same name should NOT be overwritten — surface it to the user instead.

3. **Create symlinks for missing skills:**
   ```bash
   ln -s ~/prj/skills/<skill-name> <local-skills-path>/<skill-name>
   ```

4. **Also clean up broken symlinks** (target no longer exists in the repo, e.g. skill was removed upstream). List them to the user before deleting, and only remove with confirmation.

5. **Report the result** to the user:
   - Newly linked skills
   - Broken/removed symlinks (if any)
   - Any conflicts (non-symlink directories that block linking)

## Example: One-Shot Sync Script

For a non-interactive run, `scripts/sync.sh` performs the whole procedure above —
pull, link missing skills, skip real-dir conflicts, and report broken symlinks
(it does **not** delete them, so review the reported list yourself).

```bash
# Claude (default target: ~/.claude/skills)
./scripts/sync.sh

# Codex
./scripts/sync.sh ~/.codex/skills

# Override the repo location if it is not at ~/prj/skills
SKILLS_REPO=~/code/skills ./scripts/sync.sh
```

Prefer this script for a quick sync; fall back to the manual steps above when you
need to inspect or resolve conflicts and broken links case by case.

## Out of Scope

- DO NOT modify the contents of skill folders.
- DO NOT push changes to `skills`.
- DO NOT sync settings, hooks, or other non-skill assets — this skill is scoped to skill folders in the `skills` repo only.

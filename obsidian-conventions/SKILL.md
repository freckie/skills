---
name: obsidian-conventions
description: Personal Obsidian vault conventions. Use when accessing, reading, creating, or editing notes in the user's Obsidian vault — covers vault location, folder indexing, naming rules, and the special `90 Common` topic folder used for backlinks. Applies on top of obsidian-markdown / obsidian-cli / obsidian-bases skills.
user-invocable: false
---

# Obsidian Conventions

Personal conventions for the user's Obsidian vault. Load alongside `obsidian-markdown`, `obsidian-cli`, or `obsidian-bases` when working with the vault.

## Access Method (IMPORTANT)

- **Default to the `obsidian-cli` skill** for all vault access — reading, creating, editing, searching, and managing notes.
- DO NOT access the vault directly through the filesystem without explicit user permission.
  - e.g. Read/Write/Edit/Bash on vault paths
  - It could be corrupt iCloud sync, Obsidian's index, and plugin state.
- If a task genuinely requires direct filesystem access (e.g. bulk operations not supported by `obsidian-cli`), **ask the user first** and explain why.

## Vault Location

- Vault root: `<iCloud Drive>/Obsidian/Personal`
- On macOS, iCloud Drive path is typically `~/Library/Mobile Documents/com~apple~CloudDocs`.

## Folder Structure

- Maximum depth is **2** under the vault root.
  - Exception: `Topic` folders under `90 Common` may go deeper.
- All folders follow the naming pattern: `{two-digit index} {folder name}`.
  - **1-depth folders** use indices of the form `x0`: `00`, `10`, `20`, `30`, ...
  - **2-depth folders** use indices of the form `xy` where `x` matches the parent's tens digit: e.g. `01`, `02` under `00`; `11`, `12`, `13` under `10`.

### Folder Reference by Number

When the user refers to a folder by a two-digit number (e.g. "24번 폴더"), interpret it as the 2-depth folder whose index starts with the same tens digit.

- Example: "24번 폴더" → look under `20 ...` for `24 ...` (e.g. `/20 Work/24 Troubleshooting`).
- If the number ends in `0` (e.g. "20번 폴더"), it refers to the 1-depth folder itself.

If the exact folder cannot be located, list the vault root and the relevant parent before guessing.

## File Naming

- Keep filenames **within 40 bytes**.
- If 40 bytes is genuinely insufficient, **ask the user first**, then extend up to **60 bytes maximum**.
- Note: Korean characters in UTF-8 are 3 bytes each.

## The `90 Common` Folder (Special)

`/90 Common` is reserved for shared, cross-cutting reference content.

- `91`, `92`, `93` folders hold **Topic notes** that other documents reference via backlinks rather than being read top-down.
  - Example: when writing a study note about networking, link out to topic notes like `[[BGP]]`, `[[ARP]]` in `92` so the topic page accumulates backlinks over time.
- `99 Templates` stores note templates. When creating a new note that matches an existing template, use it instead of writing from scratch.

When creating a new note that mentions a concept likely to recur (a technology, a person, a company, a term), prefer linking with `[[Wikilinks]]` to a Topic note under `90 Common` — create the topic stub if it does not yet exist.

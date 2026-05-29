---
name: git-commit
description: Prepare and create safe, consistent git commits. Use when AI is asked to commit changes, write a commit message, inspect staged changes before committing, or verify that a repository is ready to commit.
---

# Git Commit

## Workflow

Use this workflow before running `git commit`.

1. Inspect repository state with `git status --short`.
2. Inspect staged changes with `git diff --cached --stat` and `git diff --cached`.
3. If there are unstaged changes, determine whether they are relevant to the requested commit. Do not stage unrelated changes without explicit user intent.
4. Verify that no `.env` file is staged. If any `.env` file is staged, stop and unstage it unless the user explicitly asks for a different non-secret env example file.
5. Verify `.env` is ignored by checking `.gitignore` or the repository's ignore rules. If it is missing, add an ignore entry only when doing so is within the user's requested change scope; otherwise mention it before committing.
6. Scan staged changes for likely secrets, credentials, tokens, private keys, and hardcoded connection strings. Stop if a likely secret is present.
7. Run the smallest relevant verification for the staged changes when practical, such as focused tests, lint, typecheck, or build. If verification cannot be run, mention why in the final response.
8. Create the commit only after the staged diff, safety checks, and message are aligned.

## Safety Checks

Treat these as blockers unless the user explicitly resolves them:

- Staged `.env`, private key, certificate, credential file, or generated secret material.
- Hardcoded password, API key, token, database URL, cloud credential, SSH key, or signing key.
- Staged unrelated edits that would make the commit misleading.
- Commit message that does not match the user's required convention.

Prefer concrete commands:

```bash
git status --short
git diff --cached --stat
git diff --cached
git diff --cached --name-only
git diff --cached --check
```

Use additional secret scanning when useful:

```bash
git diff --cached | rg -i "api[_-]?key|secret|token|password|passwd|private key|BEGIN .*PRIVATE KEY|DATABASE_URL|AWS_ACCESS_KEY|AWS_SECRET"
```

## Commit Message

Use the user's repository convention when present.
default to:

```text
{commit_type}({scope}): {message}

- {detail}
- {detail}
```

Allowed `commit_type` values:

- `feat`
- `update`
- `chore`
- `delete`
- `docs`

Choose `scope` from the main area changed, such as `ui`, `api`, `infra`, `docs`, `test`, `config`, or a package/module name already used in the repository.

Write `{message}` as a short imperative or noun-style summary in English. Write detail bullets in English, focusing on what changed and why it matters. Do not mention unrelated cleanup.

## Commit Execution

When the message is ready, use a non-interactive commit command:

```bash
git commit -m "type(scope): summary" -m "- Detail one
- Detail two"
```

After committing, report:

- The commit hash from `git rev-parse --short HEAD`.
- The final commit subject.
- Verification that was run, or why it was not run.
- Any relevant files intentionally left unstaged.

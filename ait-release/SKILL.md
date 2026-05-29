---
name: ait-release
description: "Use for Apps in Toss release and operations tasks and trigger when the request mentions 앱인토스, app-in-toss, ait, Apps in Toss, or AppsInToss with launch review, game/non-game checklist, app bundle upload, review request, release, rollback, hotfix, in-app functions, emergency maintenance, monitoring, post-review, or service termination needs."
---

# Apps in Toss Release

Use this skill for Apps in Toss launch readiness, review submission, release, version operations, emergency maintenance, in-app functions, and service termination. Source references are Korean Markdown files downloaded from the Apps in Toss developer docs; load only the files needed for the current task.

## Reference Map

- `references/game-release-checklist.md`: Game release guide entry page. The downloaded Markdown currently contains only the intro; confirm the live docs if detailed checklist items are needed.
- `references/nongame-release-checklist.md`: Non-game release guide entry page. The downloaded Markdown currently contains only the intro; confirm the live docs if detailed checklist items are needed.
- `references/miniapp-release.md`: Release process: pre-check, bundle size/resource guidance, review request, rejection handling, release, updates, rollback, hotfix, monitoring, post-review.
- `references/in-app-functions.md`: In-app function setup for new and already released apps, bundle registration, WebView/RN feature configuration, review status.
- `references/emergency-maintenance.md`: Console emergency maintenance schedule setup, modification/end, and maintenance exposure screen.
- `references/service-termination.md`: Service termination types, 30-day notices, partner obligations, refunds, Toss Login withdrawal handling, and terms withdrawal.

## Workflow

1. Identify whether the task is pre-release review, app bundle/release flow, app feature registration, emergency maintenance, post-release operation, rollback/hotfix, monitoring, or service termination.
2. For pre-release work, load `miniapp-release.md` plus the game or non-game checklist entry. If detailed checklist content is required, note that the local Markdown is incomplete and verify the live checklist page.
3. Before review request, confirm at least one Toss app test has been completed, only one version is submitted at a time, and the app bundle is under the documented uncompressed size limit.
4. For live release, warn that approved releases and rollbacks apply to all users immediately.
5. For live-environment bugs, check CORS origin, memory/resource usage, permissions, login/session behavior, actual payment/auth behavior, external resource/CDN loading, logs, Sentry, and user reports.
6. For feature deep links or entry points, load `in-app-functions.md` and distinguish new-app registration from updates after release.
7. For emergency downtime, load `emergency-maintenance.md` and guide the console schedule, modification, or termination flow.
8. For service shutdown, load `service-termination.md` and clarify whether it is partner-requested, improvement-failure, or immediate legal/policy termination.

## Output Guidance

- Separate launch blockers, review risks, operational risks, and follow-up tasks.
- Route implementation testing details to `ait-development`, design review details to `ait-design`, service eligibility/policy entry questions to `ait-start`, and API-specific behavior to `ait-api-sdk` when available.
- Do not promise approval. State what the docs require and what should be confirmed with Apps in Toss/Toss when the local checklist is incomplete.

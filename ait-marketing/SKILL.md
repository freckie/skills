---
name: ait-marketing
description: "Use for Apps in Toss marketing, growth, analytics, and messaging tasks and trigger when the request mentions 앱인토스, app-in-toss, ait, Apps in Toss, or AppsInToss with segment, smart message, push/notification, promotion, Toss points, game center, leaderboard, share reward, OG image, dashboard, event logging, conversion metrics, user acquisition, retention, viral sharing, or growth insight needs."
---

# Apps in Toss Marketing

Use this skill for Apps in Toss marketing and growth planning: segmentation, smart messaging, promotions, game center, share rewards, OG images, analytics, logging, conversion metrics, traffic, retention, viral loops, and growth insight. Source references are Korean Markdown files downloaded from the Apps in Toss developer docs; load only the files needed for the current task.

## Reference Map

- `references/overview.md`: Marketing section hub. Usually empty, kept for source completeness.
- `references/segment-intro.md`: Segment purpose, condition categories, console setup, category/condition settings.
- `references/smart-message-intro.md`: Smart send concepts, push vs notification, ad/functional campaigns, notification agreement, message writing guide, prohibited expressions, checklist.
- `references/promotion-intro.md`: Toss Points promotions, preparation, business/settlement/wallet setup, allowed/disallowed promotion types, registration, testing, operation, dashboard, required user notice, settlement rules.
- `references/game-center-intro.md`: Game profile and leaderboard concepts, benefits, notes, and development handoff.
- `references/share-reward-intro.md`: Share reward concept, benefits, send limits, reset 기준, console setup, reward screen, registration checks, development handoff.
- `references/open-graph.md`: OG image purpose, size, quality, text/sensitive-word rules, UX writing link, application steps.
- `references/analytics-dashboard.md`: Dashboard metrics: DAU, OS/app version, gender, age, referrer, retention.
- `references/analytics-logging.md`: Event logging principles, prerequisites, click/exposure examples, parameters, console display, best practices, troubleshooting.
- `references/conversion-metrics.md`: Conversion metric concept, why it matters, template/custom setup, dashboard confirmation.
- `references/growth-intro.md`: Growth guide overview: acquisition, retention, viral sharing, dashboard insight.
- `references/growth-traffic.md`: Acquisition tactics using segments, push/notifications, and promotions.
- `references/growth-retention.md`: Retention tactics using segments, push/notifications, and Toss home ads.
- `references/growth-share.md`: Viral sharing tactics using share and share rewards.
- `references/growth-insight.md`: Data-based growth insight using DAU, retention, and next-action planning.

## Workflow

1. Identify the goal: acquisition, retention, reactivation, viral sharing, promotion, campaign messaging, analytics instrumentation, dashboard analysis, or asset/OG setup.
2. Load growth overview first for strategy requests; load specific tool references for execution.
3. Use segments to define target users before messaging, promotion, or retention plans.
4. For smart messages, distinguish advertising campaigns from functional campaigns; check notification agreement and message writing constraints.
5. For promotions, verify business registration, settlement info, Biz Wallet, allowed reward type, per-user point limits, test flow, user notice, and settlement/operation rules.
6. For games, load game center and share reward references when leaderboards, game profiles, or viral invitation loops are relevant.
7. For analytics, load dashboard, logging, and conversion metric references; define events and parameters before interpreting growth results.
8. For share previews, load OG image rules and route visual/copy quality checks to `ait-design` when needed.

## Output Guidance

- Separate strategy, console setup, development handoff, copy/design requirements, and measurement.
- Route implementation APIs to `ait-api-sdk` when available, revenue settlement/payment details to `ait-revenue`, and UX writing/OG visual quality to `ait-design`.
- Be careful with promotional and message copy: if the reference disallows a phrase or requires notice text, state it explicitly.
- When proposing a growth loop, include the target segment, entry channel, user action, reward/message, measurement metric, and follow-up experiment.

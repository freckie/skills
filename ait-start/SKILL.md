---
name: ait-start
description: "Use for Apps in Toss onboarding and service-start decisions, and trigger when the request mentions 앱인토스, app-in-toss, ait, Apps in Toss, or AppsInToss with overview, policy, console registration, business registration, minor workspace access, or launch preparation needs."
---

# Apps in Toss Start

Use this skill for early Apps in Toss decisions: what Apps in Toss is, whether a service is allowed, how the open process works, and how to register a workspace, app, business, or minor member in the console. Source references are Korean Markdown files downloaded from the Apps in Toss developer docs; load only the files needed for the current task.

## Reference Map

- `references/overview-card.md`: Start-section hub. Usually empty, kept for source completeness.
- `references/intro-overview.md`: Apps in Toss concept, partner value, provided SDK/API/design/marketing/revenue tools, exposure, and FAQ.
- `references/onboarding-process.md`: End-to-end service open process: start, design, development, review, release.
- `references/service-open-policy.md`: Service eligibility, restricted services/content, categories requiring review, abuse prevention, external-link/app-install policy, AI service notices, login/payment/ad policy.
- `references/service-caution.md`: Service-type caution hub. Short source page; use with `service-open-policy.md`.
- `references/console-workspace.md`: Console signup, workspace setup, member invitation, representative admin transfer, app registration, app metadata, game rating, and review request.
- `references/register-business.md`: Business registration requirements, corporate/individual registration, functions requiring business registration, and non-business limitations.
- `references/console-minor.md`: Minor member workspace participation rules and consent flow.

## Workflow

1. Classify the user's need: platform overview, service eligibility, onboarding sequence, console setup, app registration, business registration, minor access, or launch preparation.
2. Load the matching reference files before giving procedural or policy guidance.
3. For a new service idea, check `service-open-policy.md` early. Flag restricted services, review-required categories, duplicate/abusive miniapp patterns, external-link limits, app-install inducement, AI disclosure requirements, and login/payment/ad constraints.
4. For onboarding plans, use `onboarding-process.md` as the spine and route design, development, review, release, marketing, revenue, or API details to the matching Apps in Toss skill when available.
5. For console setup or registration tasks, use `console-workspace.md` and collect required app metadata: app name, immutable `appName`, app type, subtitle, detail description, age rating, support contacts, category/search exposure, logo, thumbnail, screenshots, and game-specific rating info.
6. For account or organization questions, use `register-business.md` and `console-minor.md` to clarify business registration, representative/admin requirements, feature limitations, and minor access constraints.

## Output Guidance

- Answer in the user's language unless they ask otherwise.
- Be explicit when a service may be blocked or requires extra review; cite the relevant reference filename in prose.
- When giving a launch preparation checklist, separate mandatory console fields, policy risks, business/account prerequisites, and downstream work handled by other tabs.
- Do not invent policy exceptions. If the source docs are unclear, say what is known and what must be confirmed with Apps in Toss/Toss.

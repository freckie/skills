---
name: ait
description: "Entry-point orchestrator for Apps in Toss work; trigger when the request mentions ait, 앱인토스, app-in-toss, Apps in Toss, or AppsInToss and route to the correct specialized Apps in Toss skill."
user-invocable: true
---

# Apps in Toss Orchestrator

Use this skill as the first stop for Apps in Toss work. It does not duplicate the detailed docs. Instead, it routes the request to the smallest useful set of specialized `ait-*` skills, then those skills load their own Korean Markdown references as needed.

## Routing Map

- Use `ait-start` for platform overview, service eligibility, onboarding process, service open policy, console signup, workspace/app registration, business registration, non-business limitations, representative admin, or minor workspace access.
- Use `ait-design` for TDS, UI/UX, miniapp branding, logo/name/color, navigation bar design, tab bar, dark-pattern review, UX writing, graphics, resolution, Figma, TDS UI Kit license, or App Builder.
- Use `ait-development` for project setup, AI-assisted miniapp creation, WebView vs React Native choice, Granite, `create-ait-app`, `ait init`, local execution, sandbox app testing, Toss app QR testing, introductory Toss Login/Auth setup, or development troubleshooting.
- Use `ait-release` for launch review, game/non-game checklist, app bundle upload, review request, rejection handling, release, update, rollback, hotfix, in-app functions, emergency maintenance, monitoring, post-review, or service termination.
- Use `ait-marketing` for segments, smart messages, push/notifications, functional campaigns, promotions, Toss Points campaigns, game center growth use cases, share rewards, OG images, dashboards, event logging, conversion metrics, acquisition, retention, viral sharing, or growth insight.
- Use `ait-revenue` for in-app ads, rewarded/interstitial/banner ads, in-app purchases, subscriptions, TossPay, product setup, payment/refund history, settlement, fees, VAT, tax invoices, revenue dashboards, or business/settlement prerequisites.
- Use `ait-api-sdk` for Bedrock, SDK/API implementation, mTLS, firewall, WebView config, React Native config, navigation bar API, layout, interaction APIs, user hash keys, Toss Login API, Toss Auth API, game center API, promotion rewards API, TossPay API, Toss Ads Pixel, Firebase, Supabase, Sentry, smart message API, notification agreement, share APIs, analytics APIs, or referrer values.

## How To Use

1. Classify the user's request by intent, not by keyword alone.
2. Load only the specialized skill or skills needed for the current task.
3. If the request spans phases, load skills in process order: `ait-start` -> `ait-design` -> `ait-development` -> `ait-release`, with `ait-marketing`, `ait-revenue`, and `ait-api-sdk` added only when relevant.
4. Prefer the specialized skill references over broad source docs. They were downloaded and organized to save context.
5. If two skills overlap, use the skill that owns the decision:
   - Business/policy eligibility: `ait-start`
   - UI/UX correctness: `ait-design`
   - Build/test workflow: `ait-development`
   - Launch/operations: `ait-release`
   - Campaign/growth strategy: `ait-marketing`
   - Money/settlement setup: `ait-revenue`
   - Exact SDK/API code: `ait-api-sdk`

## Fallback Source

If, and only if, the specialized skills do not contain the needed information, consult the live Apps in Toss LLM index:

`https://developers-apps-in-toss.toss.im/llms.txt`

This file can consume many tokens. Do not load it casually. Use it only as a last resort after you are confident the local `ait-*` skill references do not cover the request, or when checking whether new documentation exists outside the current skill set.

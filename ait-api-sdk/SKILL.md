---
name: ait-api-sdk
description: "Use for Apps in Toss API and SDK implementation tasks and trigger when the request mentions 앱인토스, app-in-toss, ait, Apps in Toss, or AppsInToss with Bedrock, SDK, API, mTLS, WebView config, React Native config, navigation bar, layout, interaction, user hash key, Toss Login, Toss Auth, game center, promotion reward, TossPay, Toss Ads Pixel, Firebase, Supabase, Sentry, smart message API, notification agreement, share, contacts viral, analytics, or referrer needs."
---

# Apps in Toss API & SDK

Use this skill for Apps in Toss API/SDK integration and implementation. It covers Bedrock architecture, SDK setup, mTLS/server APIs, WebView and React Native config, UI framework APIs, identity/login/auth, payments, promotion rewards, sharing, messaging, analytics, external services, and release notes. Source references are Korean Markdown files downloaded from the Apps in Toss developer docs; load only the files needed for the current task.

## Reference Map

### Architecture And Operations

- `references/bedrock-intro.md`: Overall architecture, SDK vs server API, `AppsInToss`, `InitialProps`, API usage entry.
- `references/api-integration-process.md`: Server API process, mTLS certificates, certificate use by language/client, firewall IPs, domains, common response format, rate limits.
- `references/release-note.md`: Release note page. Local Markdown is short; verify live docs for detailed recent changes.
- `references/sentry-monitoring.md`: Sentry setup, plugin install/config, release, sourcemap upload.
- `references/firebase-intro.md`: Firebase setup, environment variables, initialization, Firestore example, security checklist.
- `references/supabase-intro.md`: Supabase setup, environment variables, initialization, database example, security checklist.

### Framework And UI

- `references/webview-config.md`: WebView SDK global config, brand/host/permission/build options, navigation bar.
- `references/react-native-config.md`: React Native SDK config, environment variables, navigation bar.
- `references/navigation-bar.md`: Navigation bar behavior, game/non-game defaults, more menu, design guide, accessory icons, home button.
- `references/layout.md`: Bedrock layout files, matching scope, global/section layouts, query params in layouts.
- `references/interaction.md`: Scroll inertial background, color preference, keyboard above view, audio focus, haptics.

### Identity And Auth

- `references/user-hash-key-develop.md`: User hash keys, `getUserKeyForGame`, `getAnonymousKey`, game/non-game examples.
- `references/toss-login-develop.md`: Toss Login `appLogin`, access token, refresh, user info, decrypt user info, unlink, callback unlink, local auth troubleshooting.
- `references/toss-login-migration.md`: Migration from Toss Login to user hash key, integration check, mapping flow, `getIsTossLoginIntegratedService`.
- `references/toss-auth-develop.md`: Toss Auth server/client flow, firewall, access token, auth request, auth screen call, status/result queries, testing, session key, encryption/decryption.

### Revenue, Promotion, And Growth APIs

- `references/tosspay-develop.md`: TossPay create payment, checkout, execute, refund, status query, codes, errors.
- `references/promotion-api.md`: Promotion point rewards for game and non-game miniapps, client/server reward flows, key creation, reward grant, result query, error codes.
- `references/game-center-develop.md`: Submit leaderboard score, open leaderboard, sandbox test, notes.
- `references/toss-ads-pixel-develop.md`: Toss Ads Pixel tracking code, script install, event integration, purchase/ad/sign-in/page/custom events and properties.
- `references/smart-message-develop.md`: Functional message server API: test send, message send, bulk send.
- `references/request-notification-agreement.md`: `requestNotificationAgreement`, when consent UI is needed, params, result types, notes.

### Sharing And Analytics

- `references/contacts-viral.md`: Share reward `contactsViral`, game/non-game flow, params, success/reward events, types.
- `references/get-toss-share-link.md`: `getTossShareLink`, params, returned share link, pre-release testing with `deploymentId`.
- `references/share.md`: `share` message API and examples.
- `references/analytics-api.md`: Analytics object, click/exposure/area event logging APIs.
- `references/referrer.md`: Referrer values passed on miniapp entry.

## Workflow

1. Identify the exact API surface and load the relevant reference before writing code or giving signatures.
2. If the user is still choosing WebView vs React Native or setting up a project, route high-level setup to `ait-development` first.
3. For server-to-server APIs, always check `api-integration-process.md` for mTLS, firewall, domains, common response shape, and rate limits before endpoint-specific guidance.
4. For identity, distinguish anonymous/user hash keys, Toss Login, Toss Login migration, and Toss Auth; do not substitute one for another.
5. For money or rewards, cross-check setup/contract/settlement context with `ait-revenue` or `ait-marketing` when the task is not purely implementation.
6. For sharing, growth, and analytics, combine API references with `ait-marketing` measurement or campaign strategy when needed.
7. Preserve documented names, option shapes, request/response fields, and error codes from the references; do not infer unstated API behavior.
8. For UI APIs, cross-check branding/design constraints with `ait-design` when navigation bar, layout, color, UX, or copy choices matter.

## Output Guidance

- Include the exact reference filename used when answering detailed API questions.
- Give implementation steps in order: console/contract prerequisites, client/server config, API call, testing, error handling, and release checks.
- Warn when a local reference is short or release-note-like and should be verified against the live docs before adopting a version-sensitive behavior.
- Never invent credentials, keys, endpoint domains, firewall IPs, or cryptographic details; load and quote the relevant reference minimally when needed.

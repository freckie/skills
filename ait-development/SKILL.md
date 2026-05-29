---
name: ait-development
description: "Use for Apps in Toss development tasks and trigger when the request mentions 앱인토스, app-in-toss, ait, Apps in Toss, or AppsInToss with implementation, WebView, React Native, Granite, create-ait-app, AI coding, sandbox testing, Toss app testing, Toss login setup, or Toss authentication setup needs."
---

# Apps in Toss Development

Use this skill for building and testing Apps in Toss miniapps. It covers framework selection, project creation, WebView and React Native starts, AI-assisted miniapp creation, sandbox testing, Toss app testing, and introductory Toss Login/Auth setup. Source references are Korean Markdown files downloaded from the Apps in Toss developer docs; load only the files needed for the current task.

## Reference Map

- `references/overview.md`: Development section hub. Usually empty, kept for source completeness.
- `references/ai-vibe-coding.md`: AI-assisted miniapp creation: prerequisites, Node/VS Code, AI tools, Apps in Toss MCP, project creation, app info, sandbox test, and release.
- `references/webview-getting-started.md`: WebView path for CSR/SSG web services: create project, add SDK to existing web project, config, TDS, run, device access, debugging, build, final Toss app test.
- `references/react-native-getting-started.md`: React Native/Granite path: create Granite app, choose tooling, run `ait init`, configure `granite.config.ts`, install TDS, run dev server, device execution, debugging, build, release.
- `references/sandbox-test-app.md`: Sandbox app setup and execution for iOS/Android, simulators/emulators, app selection, Toss auth, URL scheme execution, testable features, troubleshooting.
- `references/toss-app-test.md`: Final testing in the real Toss app: bundle creation, bundle upload, QR test, CI/CD commands, feature testing with path/query, white-screen and networking troubleshooting.
- `references/toss-login-intro.md`: Toss Login concept and console setup: terms, scopes, service linkage, unlink callback, decryption key, external web/app login request, handoff to development integration.
- `references/toss-auth-contract.md`: Toss Auth concept and contract flow: personal-data auth, one-touch auth, operational tips, admin/contract documents, key issuance, handoff to development integration.

## Workflow

1. Identify the development path: AI-generated miniapp, WebView, React Native/Granite, testing, Toss Login, or Toss Auth.
2. For a new build, first check service eligibility with `ait-start` if the idea or policy status is unclear.
3. Choose WebView when the user has or wants a CSR/SSG web service, fast deployment cycles, or common web-framework reuse.
4. Choose React Native/Granite when native-feeling UI, complex animation/gesture handling, or React Native experience matters.
5. For project setup, load the matching getting-started reference and preserve the documented commands, config fields, and appName/displayName/icon alignment with console registration.
6. For local and device testing, use `sandbox-test-app.md` first; use `toss-app-test.md` for pre-release testing in the real Toss app.
7. For login or identity needs, use `toss-login-intro.md` or `toss-auth-contract.md` for setup/contract scope, then defer detailed API calls to the API & SDK skill when available.
8. For UI/TDS requirements discovered during development, route design details to `ait-design`.

## Implementation Guidance

- Do not treat an external iframe or simple external URL redirect as a valid migration path; check the WebView reference and policy references if this comes up.
- Keep console `appName`, project config, display name, and icon consistent across setup instructions.
- When giving commands, preserve package-manager variants only when useful; otherwise pick the repo's existing package manager.
- When troubleshooting, separate local dev server access, iOS/Android environment setup, bundle upload, QR/deploymentId, CORS, ATS, cookies, memory/resource, and Unity-specific issues.
- Mention when a task needs a later-stage skill: design (`ait-design`), release review (`ait-release`), API calls (`ait-api-sdk`), marketing (`ait-marketing`), or revenue (`ait-revenue`).

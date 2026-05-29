---
name: ait-design
description: "Use for Apps in Toss design work and trigger when the request mentions 앱인토스, app-in-toss, ait, Apps in Toss, or AppsInToss with design/UI/UX needs: TDS, miniapp branding, UX dark-pattern review, UX writing, graphics, resolution, Figma/TDS license, and App Builder design workflows."
---

# Apps in Toss Design

Use this skill when designing, implementing, or reviewing UI/UX for an Apps in Toss miniapp. The source references are Korean Markdown files downloaded from the Apps in Toss developer docs; load only the files needed for the current task.

## Reference Map

- `references/overview.md`: Design section hub. Usually empty, kept for source completeness.
- `references/tds-components.md`: Toss Design System overview, license cautions, and component entry point.
- `references/figma-ui-license.md`: TDS Mobile UI Kit license terms. Read before reusing or redistributing TDS/Figma assets.
- `references/miniapp-branding-guide.md`: Brand logo, brand name, brand color, navigation bar, and tab bar rules.
- `references/consumer-ux-guide.md`: Dark-pattern prevention policy and release-blocking UX patterns.
- `references/ux-writing.md`: Toss voice tone, Korean UX copy rules, CTA and dialog wording guidance.
- `references/graphic-resources.md`: Toss graphics, icons, emoji, mockups, illustrations, and custom graphic usage rules.
- `references/resolution.md`: Logical resolution, asset resolution, fullscreen, safe area, and device testing guidance.
- `references/figma-design.md`: Figma setup, TDS component library usage, responsive design guidance.
- `references/app-builder-deus.md`: App Builder workflow, project setup, components, layout, preview, and sharing.

## Workflow

1. Identify the design surface: branding, screen layout, copy, graphics, resolution, Figma handoff, App Builder, or compliance review.
2. Load the matching reference files above before making design decisions.
3. Prefer TDS components and patterns when building product UI for Apps in Toss.
4. Check branding early: logo shape, Korean brand name, brand color, navigation bar, and tab bar rules.
5. Screen for dark patterns before finalizing flows. Avoid entry-blocking sheets, back-navigation traps, no-exit choices, surprise ads, and ambiguous CTA labels.
6. For Korean product copy, apply Toss UX writing rules: `해요체`, active voice, positive wording, casual honorifics, and clear next-action buttons.
7. For graphics, use Toss-provided assets when appropriate; otherwise keep graphics contextual, high quality, readable in light/dark mode, and non-decorative.
8. For games or fullscreen miniapps, verify logical resolution, asset scale, safe area behavior, and representative device coverage.

## Implementation Guidance

- Treat the references as requirements when the user asks for Apps in Toss compatibility or launch readiness.
- If a design decision conflicts with the source docs, call it out and choose the docs unless the user explicitly accepts the tradeoff.
- When reviewing an existing UI, report issues grouped by source area: branding, UX policy, copy, graphics, resolution, and tooling.
- When implementing UI, include concrete checks in the final response, such as which references were applied and any unresolved launch-review risks.

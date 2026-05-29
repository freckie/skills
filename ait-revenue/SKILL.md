---
name: ait-revenue
description: "Use for Apps in Toss monetization and settlement tasks and trigger when the request mentions 앱인토스, app-in-toss, ait, Apps in Toss, or AppsInToss with in-app ads, rewarded ads, banner/interstitial ads, in-app purchase, subscriptions, TossPay, payment/refund history, settlement, tax invoice, fees, revenue dashboard, or business/settlement setup needs."
---

# Apps in Toss Revenue

Use this skill for Apps in Toss monetization and settlement: in-app ads, in-app purchases, TossPay, refunds, dashboards, fees, tax invoices, and settlement operations. Source references are Korean Markdown files downloaded from the Apps in Toss developer docs; load only the files needed for the current task.

## Reference Map

- `references/overview.md`: Revenue section hub. Usually empty, kept for source completeness.
- `references/in-app-ads-intro.md`: In-app ads concept, revenue formula, impressions/eCPM, interstitial/reward/banner ad types, console setup, rewards, mediation, performance, settlement history, development handoff.
- `references/in-app-payment-intro.md`: In-app purchase concept, console setup, product types, product images, supply/sale price, subscriptions, payment notification URL, Basic Auth, payment/refund history, refund states, performance dashboard.
- `references/tosspay-intro.md`: TossPay concept, integration process, restricted categories, intermediary-platform rules, recurring-payment fees, contract and key setup, test API keys, development handoff.
- `references/settlement-intro.md`: Settlement information, business-level settlement, ad settlement, in-app payment settlement, fees, VAT/tax invoices, payment schedule, deferral reasons.

## Workflow

1. Identify the revenue surface: ads, in-app purchase, TossPay, refunds, settlement, fees, dashboard, or required business setup.
2. For monetization eligibility or business prerequisites, load the relevant revenue reference and cross-check `ait-start` business registration guidance if needed.
3. For ads, distinguish interstitial, rewarded, and banner ads; confirm ad group setup, reward setup, mediation, performance metrics, and settlement history.
4. For in-app purchases, confirm product type, product name/image, supply and sale price, subscription settings, payment notification URL, Basic Auth, refund policy/state, and dashboard needs.
5. For TossPay, check restricted categories, intermediary-platform conditions, contract flow, API key setup, and recurring-payment fee rules.
6. For settlement, explain calculations at the correct level: settlement is business-level, not app-level; include fee/VAT/tax-invoice and payout timing constraints.
7. Route API implementation calls to `ait-api-sdk` when available, release and refund operations around shutdown to `ait-release`, and promotion point campaigns to `ait-marketing`.

## Output Guidance

- Separate console setup, contract/business prerequisites, implementation handoff, financial calculation, and operational risk.
- Be precise with amounts, fees, VAT, schedules, and thresholds when present in the source docs.
- Do not provide legal/tax advice beyond the docs; state when the partner should confirm with Toss or its tax/accounting advisor.

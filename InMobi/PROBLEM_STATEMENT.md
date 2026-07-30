# Click-a-thon 2026 — Problem Statement (InMobi)
## From alert to answer: the automated root-cause analyst

*All data provided is **synthetic**. No real advertiser, publisher, or user data of any kind.*

## About InMobi

InMobi is one of the world's largest independent advertising platforms, founded in Bengaluru in 2007 and operating at global scale: billions of ad requests flow through its systems daily, across apps, devices, geographies, and advertisers. At this scale, business metrics are not numbers on a dashboard; they are high-velocity streams where a small percentage shift represents real revenue moving in real time.

## Context

Every data-driven team watches a handful of numbers that matter: revenue, fill rate, impressions, sign-ups, active users, latency, error rate. When one of them suddenly jumps or drops, the real question isn't "did it move?" An alert already answers that. The question is **"why?"**

Today that answer comes from a human manually drilling through dashboards: slicing the metric by dimension after dimension, comparing each slice against normal, and assembling an explanation. In complex cases this takes hours or days, even though all the data already exists. With revenue spanning thousands of app, device, geo, and advertiser combinations, the bottleneck is never the data. It is the manual investigation.

## The problem

**Build a system that automatically investigates why a metric moved and returns a short, evidence-backed explanation in seconds, not days.**

Given a stream of metric/event data, your system should:

1. **Detect** when a key metric deviates from its expected baseline
2. **Automatically drill down** to isolate the segment(s) responsible
3. **Produce a plain-language diagnosis** where every claim is backed by a specific computed number
4. **Bonus:** state what the system checked and *ruled out*, not just what it found

## What you are given (in this package)

- A **synthetic ad-events dataset along with dimensions**: impressions, requests, fills, clicks, and revenue events across dimensions (app, device, OS, geo, advertiser, ad format), with realistic seasonality and noise. (~9M events, 5 weeks.)
- A short **metrics glossary** ([`metrics_glossary.md`](metrics_glossary.md)): definitions and formulas for the key metrics (fill rate, eCPM, CTR, revenue), so every team computes them the same way.

Anomalies have been deliberately planted in specific segments and time windows. The answer key stays private with the judges. You may develop and test against your own or public datasets as well, but evaluation runs on the provided data.

> **The unseen incident.** A fresh slice of the same universe, with new planted anomalies no one has seen, will be released to all teams simultaneously in the final hours of the hackathon. The release time is announced at kickoff; the incidents are the surprise, the timing is not. Your submission must include what your system produced for it: the diagnosis, the numbers behind it, and the trace that proves your system generated them. **Build for the unseen incident, not the anomalies you found during the build.**

## Requirements

- **ClickHouse must be the primary datastore and analytical engine** — all metric/event data lives in ClickHouse and the drill-down analysis runs as ClickHouse queries.
- **Meaningfully integrate at least one of** ClickStack (observability), Langfuse (LLM observability & analytics), or LibreChat (conversational interface). Superficial inclusion won't count. You do **not** need to use all of them.
- Any anomaly-detection and attribution approach is allowed, from simple baselines and contribution analysis to ML/AI. **Explainability and trustworthiness matter more than sophistication.**

## What "great" looks like

- **Fast.** A moving metric is diagnosed in seconds.
- **Trustworthy.** The explanation cites real computed numbers, no hallucinated figures. *Consider: let deterministic code do the analysis and use the LLM only to narrate.*
- **Localized.** It names the specific segment responsible, not just "something is off." Example: *"Revenue fell 12%, driven almost entirely by a drop in fill rate for Device X in Region North. Request volume and CTR were normal and ruled out."*
- **Honest.** It shows which possibilities were checked and cleared.

## How you will be evaluated

- **Detection & localization accuracy** — judged against the private answer key: did you find the planted anomalies, name the right segments, and avoid crying wolf on noise? (Found, missed, or hallucinated.)
- **Explanation trustworthiness** — every number in the diagnosis must be reproducible from the data. A single fabricated figure costs more than a missed anomaly.
- **Analytical depth in ClickHouse** — the drill-down should live in queries, not in the LLM. Judges will look at whether ClickHouse is doing the real work.
- **Traceability** — a judge should be able to open your traces and follow the investigation: what was checked, in what order, and why.
- **The unseen incident** — what your system produced for the unseen dataset carries significant weight. Every team gets the same input at the same time, so outputs are directly comparable. **No trace, no credit.**

## Notes & boundaries

- **Where things run.** Load the dataset into your team's own ClickHouse Cloud service (provisioned with your event credits). There is no shared instance.
- **LLM choice is yours.** Any provider, your own keys, per the event guidelines. The economics favor the hinted architecture — ClickHouse computes, the LLM narrates. A system that streams raw events into an LLM will be slow, expensive, and prone to inventing numbers.
- **Human-in-the-loop** is allowed during the build, but the unseen-incident diagnosis must come from your system, evidenced by the trace. A hand-written diagnosis without a matching trace scores nothing on that criterion.
- **Out of scope.** Authentication, production deployment, alerting integrations (PagerDuty and friends), and polished frontends. Judges reward the investigation loop, not the scaffolding.
- **Starting points.** The [ClickHouse MCP server](https://github.com/ClickHouse/mcp-clickhouse) and the [agent-framework examples](https://clickhouse.com/docs/use-cases/AI/MCP) get a system querying ClickHouse within the hour.

## Suggested demo

Replay an incident end to end: a metric drops → the system runs → a metric tree lights up green/amber/red → a plain-English diagnosis (*"revenue fell because fill rate dropped for Device X in Region Y; seasonality checked and ruled out"*) → optionally, ask a follow-up question in chat.

---
*See [`README_START_HERE.md`](README_START_HERE.md) for what's in this package and how to load the data, and [`metrics_glossary.md`](metrics_glossary.md) for exact metric definitions.*

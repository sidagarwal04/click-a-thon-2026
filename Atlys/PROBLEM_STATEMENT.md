# Click-a-thon 2026 — Problem Statement (Atlys)
## From feature spec to insight: agents that instrument, analyze, and explain

*All data provided is **synthetic**. No real customer data, PII, or production records of any kind.*

## About Atlys

Atlys is a digital visa platform founded in 2021 that lets travellers discover visa requirements, submit applications, and track approvals across more than 120 destinations. The platform automates what has historically been a manual, opaque, and unpredictable process: intelligent systems auto-fill visa forms, compile country-specific documentation, verify inputs in real time, and predict when a visa will be issued. That prediction engine is central to the product: Atlys can tell applicants whether their application will succeed and how long the visa will take, and is confident enough in its accuracy to offer refunds when it gets it wrong. The company is operating at a run rate of more than 700,000 visa applications annually, backed by investors including Peak XV Partners, Elevation Capital, and Andreessen Horowitz.

## Context

Behind every visa application is a stream of events: document uploads, form fields, payment attempts, verification checks, status transitions, and support interactions, multiplied across 120 destinations, each with its own rules and edge cases. Atlys uses ClickHouse to power analytics over this event stream: funnel analysis across the application journey, monitoring of processing timelines against predictions, and segment-level insight into where applicants drop off or get stuck.

Here is the challenge that motivates this problem statement. Atlys ships product changes constantly, and every new feature needs fresh instrumentation, schema design, and analysis. Today that work is manual and slow, and context gets lost across handoffs between product, engineering, and analytics. A tracking PRD gets written, tables get created weeks later, and by the time insights arrive, the team has moved on. We want to collapse that entire loop. Instead of writing a tracking PRD, deploy an agent that handles instrumentation, analysis, and insight generation automatically.

## The problem

**Build an agentic analytics system on ClickHouse that automates the full lifecycle of feature instrumentation and insight generation.**

## What you will be given

- A **base context layer** describing the business, key entities, and existing metric definitions
- **8 existing tables** with their schemas, sample data, and instrumentation logic
- **5 new feature specs** representing features yet to be launched, with raw event samples

> **The unseen spec.** A sixth feature spec, unseen by anyone until that moment, will be released to all teams simultaneously in the final hours of the hackathon. The release time will be announced at kickoff; the spec is a surprise, the timing is not. Your submission must include what your pipeline produced for it: the generated schema, the insight summary, and the trace that proves your system generated them. The insight summary should be written for a product audience, not a database one. **Build for the unseen spec, not the five you know.**

## What you will build

### 1. Instrumentation Agent

Given a new feature description, the agent must:

- Design an optimal ClickHouse table schema (column types, ordering keys, partitioning, TTL)
- Generate and execute the `CREATE TABLE` statements
- Map raw events to the schema and define any materialized views or aggregations needed

### 2. Analytics Agent

Given the newly instrumented tables plus existing tables and business context, the agent must:

- Run statistical analysis (trends, anomalies, segment comparisons, correlations)
- Apply business context to interpret numbers (e.g., *"checkout drop on mobile is 15% — this coincides with the new OTP flow"*)
- Look across multiple cuts (device, geo, funnel stage, user segment)
- Output actionable insights, not just charts

### 3. Context Agent

As the table landscape expands, this agent must:

- Maintain and evolve a context layer (business definitions, metric formulas, entity relationships)
- Auto-update context when new tables or columns are added
- Ensure the analytics agent always works from the latest context
- Surface contradictions or gaps in the context layer

> **Fair warning:** the base context layer you receive is not perfect. Treat it with suspicion.

### 4. Tracing and Visualization Layer

- Add observability across all three agents using **Langfuse** for agent and LLM tracing: what each agent did, why, and based on what context. **ClickStack** works for the system-level view if you want to go further.
- Build a visualization layer (dashboard, lightweight UI, or structured CLI output) that shows:
  - Schema changes over time
  - Agent-generated insights with confidence scores
  - Context layer diff / changelog

## Deliverables

1. **Instrumentation Agent** that can ingest a feature spec and produce production-ready ClickHouse schemas
2. **Analytics Agent** that queries the data, applies context, and writes insight summaries
3. **Context Agent** that maintains a living context layer and feeds it to the other agents
4. **Tracing and visualization** for the entire pipeline

## Constraints

- **ClickHouse as the primary datastore**
- Agents can be built in any language or framework
- LLM usage is encouraged for context interpretation and insight generation; **trace it**
- All schemas should be optimized for columnar storage and query performance

## How you will be evaluated

- **Schema quality** — not just valid DDL. Judges will look at your ordering key choices, partitioning strategy, column types, and whether your materialized views earn their keep.
- **Insight quality** — would a product manager act on your agent's output? Insights should carry the *why*, not just the *what*.
- **Context freshness** — when a new table lands, does your Analytics Agent actually reason with the updated context, or is it working from a stale snapshot?
- **Traceability** — a judge should be able to open your traces and follow the full reasoning chain: what each agent did, why, and based on what context.
- **The unseen spec** — what your system produced for the sixth spec carries significant weight in shortlisting and beyond. Every team gets the same input at the same time, so outputs are directly comparable, and systems tuned to the five known specs will show their seams here. **No trace, no credit:** the output must demonstrably come from your pipeline.

## Notes & boundaries

- **Where things run.** Load the dataset into your team's own ClickHouse Cloud service (provisioned with your event credits). Your agents execute DDL and queries against your own service. There is no shared instance.
- **LLM choice is yours.** Any provider, your own keys, per the event guidelines. One hint: an Analytics Agent that pulls raw rows into the LLM will burn your token budget fast. Push computation into ClickHouse and let the LLM interpret results, not fetch them.
- **The context layer's storage is your design decision.** A file, a ClickHouse table, a vector store, anything. Judges will ask why you chose what you chose.
- **Human-in-the-loop.** Approval gates (e.g., a human confirming a schema before execution) are allowed. But the sixth-spec output must come from your pipeline, evidenced by the trace. Hand-written schemas or insights without a matching trace score nothing on that criterion.
- **Out of scope.** Authentication, production deployment, streaming ingestion, and polished frontends. Judges reward the agent loop, not the scaffolding.
- **Starting points.** The [ClickHouse MCP server](https://github.com/ClickHouse/mcp-clickhouse) and the [agent-framework examples](https://clickhouse.com/docs/use-cases/AI/MCP) are preconfigured to get an agent querying ClickHouse within the hour.

## Example scenario

A new "Express Checkout" feature is launched. The Instrumentation Agent designs the `express_checkout_events` table. The Analytics Agent detects a conversion uplift overall but a drop in checkout completion for iOS users in one region. The Context Agent links this to a known "iOS WebKit OTP autofill" issue already documented in the base context. The tracing layer shows the full reasoning chain.

---
*See [`README_START_HERE.md`](README_START_HERE.md) for what's in this package.*

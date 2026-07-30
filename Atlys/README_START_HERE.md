# Start Here — Click-a-thon 2026 · Atlys Problem
## From feature spec to insight: agents that instrument, analyze, and explain

Welcome! All data is **synthetic**.

> **Dataset status: coming soon.** Atlys has not yet shared the dataset. This package currently contains the problem statement only; the data files, base context document, and feature specs will be added here as soon as they arrive.

## What's in this package

```
├── PROBLEM_STATEMENT.md     ← read this first: the challenge, rules, and how you're judged
└── data/                    ← coming soon (see below for what to expect)
```

## What to expect in the dataset

- A **base context document** (markdown): business overview, entity definitions, and metric definitions with formulas — with a fair warning that it is *not perfect*
- **8 existing tables** (schemas + DDL + sample data) covering the visa journey end to end: users, applications, the event stream, document uploads, payments, predictions, support interactions, and a destination catalog
- **5 feature specs** with raw event samples (NDJSON) — feature specs and raw events only, no table designs: designing the tables is your Instrumentation Agent's job

## What you're building (in one line)

A system of three agents on ClickHouse — one that turns a feature spec into production-ready table schemas, one that analyzes the data and writes insights a product manager would act on, and one that keeps the business context layer fresh as tables are added — all fully traced.

## Get running

1. Spin up your team's **ClickHouse Cloud** service (using your event credits).
2. Load the dataset from `data/` once it lands here.
3. Read [`PROBLEM_STATEMENT.md`](PROBLEM_STATEMENT.md) for the four components you must build and how you're judged.

## Deliverables (see [PROBLEM_STATEMENT.md](PROBLEM_STATEMENT.md) for full detail)

- Instrumentation Agent: feature spec in, production-ready ClickHouse schemas out
- Analytics Agent: queries the data, applies context, writes insight summaries
- Context Agent: maintains a living context layer and feeds it to the other agents
- Tracing (Langfuse) and a visualization layer for the entire pipeline
- Your pipeline's output for the **unseen sixth spec** (released Day 2), with the trace that proves your system generated it

Good luck — build something extraordinary.

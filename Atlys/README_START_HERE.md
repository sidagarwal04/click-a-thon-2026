# Start Here — Click-a-thon 2026 · Atlys Problem
## From feature spec to insight: agents that instrument, analyze, and explain

Welcome! All data is **synthetic** — no real customer data, PII, or production records.

## What's in this package

```
├── PROBLEM_STATEMENT.md     ← read this first: the challenge, rules, and how you're judged
├── base_context.md          ← the base context layer (business, entities, metrics, known issues)
├── data/                    ← the 8 existing tables (Parquet) + ddl.sql + load.sh + instrumentation_notes.md
└── specs/                   ← 5 feature specs (1-page brief + raw NDJSON events, no schema)
```

## The dataset

**`base_context.md`** — business overview, entity definitions, and metric definitions with
formulas, plus a known-issues log. Fair warning: it is maintained by hand and is **not
perfect** — definitions can conflict and entity descriptions can lag the schemas. Noticing
that is part of the Context Agent's job.

**`data/` — 8 existing raw event tables** modelling Atlys's pre-purchase **conversion funnel**.
Four are the funnel itself:

```
destination_card_clicked  ->  application_started  ->  document_uploaded  ->  purchase_completed
```

Four are supporting engagement events: `search_typed`, `landing_page_scrolled`,
`auth_completed`, `pay_now_clicked`. All are raw event streams (one table per event), joined on
`user_id` and `application_id` and ordered in time by `timestamp`. Compute the funnel by
counting distinct users reaching each step in order. ~2.5M rows total. See
`data/instrumentation_notes.md` for what emits into each table and its event-specific columns.

**`specs/` — 5 feature specs**, each a 1-page product brief plus a raw NDJSON sample of the
feature's events. There are **no table designs** — turning the raw events into a schema is your
Instrumentation Agent's job. A **6th, sealed spec** is released to all teams simultaneously on
Day 2; your submission must include your pipeline's output for it.

## Get running

1. Spin up your team's **ClickHouse Cloud** service (using your event credits).
2. Load the data (creates a database and loads all 8 tables; a few minutes):
   ```bash
   cd data
   CH='clickhouse-client --host <your-cloud-host> --user <u> --password <pw> --secure' \
   DB=atlys ./load.sh
   ```
   `load.sh` creates the `$DB` database (default `default`), runs `ddl.sql`, then bulk-loads each
   Parquet file. Verify, e.g. `SELECT count() FROM atlys.destination_card_clicked` (1,000,000).
3. Read [`PROBLEM_STATEMENT.md`](PROBLEM_STATEMENT.md) for the four components you must build and
   how you're judged.

## What you're building (in one line)

A system of three agents on ClickHouse — one that turns a feature spec into production-ready
table schemas, one that analyzes the data and writes insights a product manager would act on, and
one that keeps the business context layer fresh as tables are added — all fully traced.

## Deliverables (see [PROBLEM_STATEMENT.md](PROBLEM_STATEMENT.md) for full detail)

- Instrumentation Agent: feature spec in, production-ready ClickHouse schemas out
- Analytics Agent: queries the data, applies context, writes insight summaries
- Context Agent: maintains a living context layer and feeds it to the other agents
- Tracing (Langfuse) and a visualization layer for the entire pipeline
- Your pipeline's output for the **unseen sixth spec** (released Day 2), with the trace that
  proves your system generated it

Good luck — build something extraordinary.

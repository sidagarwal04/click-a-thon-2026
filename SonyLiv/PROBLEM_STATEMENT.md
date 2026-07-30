# Click-a-thon 2026 — Problem Statement (SonyLIV)
## Counting the crowd: foreground-only concurrency at streaming scale

*All data provided is **synthetic**. No real viewer, subscriber, or content-partner data of any kind.*

## About SonyLIV

SonyLIV is one of India's largest streaming platforms, home to live sport, entertainment, and originals, serving audiences across every screen size and network condition in the country. Live sport is where the platform's engineering gets tested in public: millions of viewers arriving at once, concurrency climbing in real time, and dashboards that the business watches minute by minute. At this scale, "how many people are watching right now" is both the most-asked question in the building and one of the hardest to answer correctly.

## Context

Concurrency looks simple: count how many sessions overlap at a given minute. In practice, it is much harder, because not every open session is actively watching. A user may keep the app open while it sits backgrounded, paused, or silent with no heartbeat. Counting that time overstates the audience, and the business decisions made on those dashboards (ad loads, capacity, content calls) inherit the error.

So the real problem is not interval overlap between session start and end. It is identifying the **truly active ranges** inside each session, and computing concurrency over only those, at a scale where the naive approaches collapse: exploding every session into per-minute rows is prohibitively large, and recomputing overlap from raw session history on every dashboard query is far too slow. And sessions are not static: open sessions keep evolving as heartbeats arrive, so the model has to absorb updates without rebuilding.

## The problem

**Design a scalable concurrency computation model on top of one or more aggregated tables (session-aware or session-independent) that uses session start/end along with heartbeat or active-state signals to count only truly active playback intervals, excluding backgrounded periods, while remaining query-efficient and update-friendly at very large scale.**

Your system must answer, with working code and data, the questions this problem turns on:

- **How do you define an active interval** when the heartbeat is missing, the player is paused, or the app is backgrounded?
- **How should active ranges be represented:** interval arrays per session, normalized intervals, pre-aggregated minute deltas, or a hybrid?
- **How do you compute accurate minute-wise peak and average concurrency** without scanning raw session history on every query?
  - *Scenario/example:* if minute 1 has 300K concurrent sessions, minute 2 has 200K, and minute 3 has 50K, the peak concurrency for the range (minutes 1–3) would be 300K concurrent sessions. However, concurrency varies across dimension combinations: a dimension like platform and a content might peak at one minute, while a combination like platform + country might reach its peak at an entirely different minute within the selected time range.
- **How does the model stay filter-friendly** across common business dimensions: platform, country, content, video type, time grain?
- **How do you handle sessions that are still open,** whose active ranges keep growing as new heartbeats arrive?

## What you will be given

- A **synthetic session dataset provided by SonyLIV**: session boundaries (start/end), heartbeat events, playback-state markers (playing, paused, backgrounded, foregrounded), across dimensions (platform, country, content ID, video type)
- A **benchmark query set**: the fixed concurrency questions your system will be evaluated on (peak and average concurrency at minute/hour/day grain, with dimension filters)
- A **ground-truth answer key** for the benchmark queries stays private with the judges

> **The unseen day.** An unseen evaluation dataset, a fresh day of session data from the same universe, will be released to all teams simultaneously in the final hours of the hackathon. The release time will be announced at kickoff; the data is the surprise, the timing is not. Your submission must include your system's answers to the benchmark queries on it, the query latencies, and evidence that they ran through your pipeline. **Build for the unseen day, not the data you tuned on.**

## Requirements

- **ClickHouse must be the primary datastore and analytical engine** — ingestion, modeling, and all concurrency computation live in ClickHouse.
- **Meaningfully integrate at least one of** ClickStack (observability), Langfuse (LLM observability & analytics), or LibreChat (conversational interface). Superficial inclusion won't count. Natural fits for this problem: ClickStack to observe your own pipeline's ingestion lag and query performance, or LibreChat plus the ClickHouse MCP server as a conversational layer over your concurrency data (*"what was peak concurrency on Android in the last hour?"*).
- **No AI is required for the core problem.** This is a systems and data-modeling challenge; the winning ingredient is design, not model calls. LLM layers are welcome where they add real value, but they will not rescue a slow or wrong concurrency model.
  - *Optional:* an LLM & ClickStack use-case is detecting and alerting on concurrency decline. This could happen if the asset has ended, if there is a system issue, or if the content is not engaging.

## Possible solution directions

*Not prescriptive, and not exhaustive. Teams that invent something better should.*

- **Interval-to-delta model:** convert each active interval into +1 at start and −1 at end, reconstruct concurrency by cumulative sum over time buckets
- **Dedicated serving table:** a limited-dimension, concurrency-optimized table that dashboards read, instead of querying full session data directly
- **Incremental compaction:** maintain active ranges for open sessions, compact and finalize once the session closes or a watermark passes
- **Hybrid tiering:** detailed intervals for recent data, pre-aggregated minute deltas for history
- **Background exclusion logic:** heartbeat gaps, background/foreground events, playback-state markers, or explicit active flags to cut inactive segments

## What "great" looks like

- **Correct.** Concurrency excludes backgrounded and heartbeat-missing periods, and matches the ground truth on the benchmark queries.
- **Fast.** Dashboard-grade latency on minute-grain queries with filters, reading from a serving layer, not recomputing overlap from raw history.
- **Update-friendly.** Open sessions keep evolving as heartbeats or late arrivals come in during that period, and the served concurrency absorbs those updates incrementally, without a full rebuild.
- **Explained.** The design decisions (representation, table layout, ordering keys, aggregation strategy) come with reasoning about the trade-offs, because this problem is won on trade-off thinking across ingestion, storage, aggregation, and serving.

## How you will be evaluated

- **Correctness** — your benchmark query answers versus the private ground truth. Foreground-only means foreground-only: overcounting backgrounded time is the failure mode this whole problem exists to prevent.
- **Query performance** — latency on the benchmark set at the provided data volume. Judges will look at what your queries read, not just how fast they return.
- **Update handling** — sessions in the dataset include ones still open when the day ends and heartbeats that keep arriving. Judges will look at how your serving layer absorbs them: incrementally, or by recomputing?
- **Design quality** — schema and representation choices, and the reasoning behind them. A team that can defend its trade-offs beats a team with a lucky benchmark.
- **The unseen day** — your system's results on the sealed dataset carry significant weight in shortlisting and beyond. Every team gets the same input at the same time, so correctness and latency are directly comparable. **No pipeline evidence, no credit.**

## Notes & boundaries

- **Where things run.** Load the dataset into your team's own ClickHouse Cloud service (provisioned with your event credits). There is no shared instance. Latency comparisons will account for service size, so tune your design, not your hardware.
- **Scale framing.** The provided dataset is a scaled-down proxy for a petabyte-class production problem. Judges will ask how your design behaves at 100x, so choices that only work at hackathon size (full rescans, per-minute explosion of all history) will be treated as what they are.
- **Human-in-the-loop** is fine during the build. The unseen-day results must come from your pipeline, evidenced by query logs or traces. Hand-computed answers score nothing.
- **Out of scope.** Authentication, production deployment, real dashboard products, and polished frontends. A minimal visualization of concurrency over time is enough to demo; judges reward the model and the serving layer.
- **Starting points.** ClickHouse docs on [materialized views](https://clickhouse.com/docs/materialized-views) and [AggregatingMergeTree](https://clickhouse.com/docs/engines/table-engines/mergetree-family/aggregatingmergetree) are directly relevant. The [ClickHouse MCP server](https://github.com/ClickHouse/mcp-clickhouse) is preconfigured if you build a conversational layer.

## Suggested demo

Replay a live-event day: ingest the session stream → the concurrency curve builds in near real time as sessions open, heartbeat, and close → apply a filter (platform, country) and the minute-grain view answers instantly → optionally, ask a follow-up question in chat.

---
*See [`README_START_HERE.md`](README_START_HERE.md) for what's in this package and how to load the data, and [`dataset_details.md`](dataset_details.md) for the data dictionary.*

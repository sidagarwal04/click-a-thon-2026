# Start Here — Click-a-thon 2026 · SonyLIV Problem
## Real-time foreground-only concurrency at streaming scale

Welcome! This package has everything you need to start building.

## What's in this package

```
├── dataset_details.md       ← data dictionary: field names, types, timestamps, identifiers, business meaning
└── data/
    ├── ch-hackathon-raw-data.csv        ~905K streaming events at event level
    └── ch-hackathon-content-data.csv    ~33K titles · metadata and content attributes
```

## Shared data assets

The solution is built from two complementary datasets:

- **Content data:** [`ch-hackathon-content-data.csv`](data/ch-hackathon-content-data.csv) — metadata and content attributes.
- **Raw events:** [`ch-hackathon-raw-data.csv`](data/ch-hackathon-raw-data.csv) — streaming activity at event level.

## Data dictionary & integration

Column definitions are documented in [`dataset_details.md`](dataset_details.md). Use this file as the canonical reference for field names, data types, timestamps, identifiers, and business meaning.

## Problem statement

Understand the OTT use case and design a streaming solution for **foreground-only concurrency at streaming scale**.

## Solution blueprint

**Integration goal:** join the content and event streams in real time to produce one or more aggregated tables, with support for both session-aware and session-independent processing.

### Concurrency view

- **Session-aware:** calculate active viewers within a defined session.
- **Session-independent:** calculate active foreground viewers directly from event state.
- **Compare both approaches** to validate accuracy and operational trade-offs.

### Streaming pipeline

1. Ingest raw playback events with event-time timestamps.
2. Enrich events with content metadata from the content dataset.
3. Apply foreground-only filtering and deduplicate late or repeated events.
4. Publish continuously updated aggregates for downstream consumers.

## Core aggregations

| Aggregation | Purpose | Key considerations |
|---|---|---|
| **Foreground concurrency** | Measure simultaneous active viewing at streaming scale | Event time, state transitions, late arrivals |
| **Content-level concurrency** | Understand demand by title or content identifier | Metadata enrichment and join consistency |
| **Time-window trend** | Track concurrency over rolling or fixed windows | Window duration, watermarking, refresh latency |

## Expected deliverables

- Document the event and content schemas using [`dataset_details.md`](dataset_details.md).
- Define the real-time join and foreground-state logic.
- Produce session-aware and session-independent aggregate tables.
- Validate results against representative OTT viewing scenarios.

> **Design decisions to confirm:** session timeout, event lateness tolerance, aggregation window size, and the required freshness of published results.

Good luck — build something extraordinary.

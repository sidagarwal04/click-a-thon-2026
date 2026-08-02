# Unseen Incident Dataset — InMobi (SEALED)

### ClickHouse Click-a-thon 2026 · "Automated Root-Cause Analyst"

This is the **unseen incident dataset** promised in `[PROBLEM_STATEMENT.md](../PROBLEM_STATEMENT.md)`: a fresh slice of the same universe with **new planted anomalies no one has seen**, released to all teams simultaneously. Point your system at it and let it run — the diagnosis must come from your pipeline, evidenced by the trace. **No trace, no credit.**

## What's in this folder

```
├── ad_events.parquet     1,500,000 events · 5 days (Jul 6 – Jul 10, 2026)
├── apps.csv              2,000 apps
├── advertisers.csv       500 advertisers
└── geo_device.csv        5,000 geo/device profiles
```

The event stream picks up right where the main dataset ended (Jun 1 – Jul 5), same star schema, same nine columns:

`event_time, app_id, geo_device_id, advertiser_id, ad_format, is_filled, is_impression, is_click, revenue`

## Important: reload the dimension tables

The dimension tables in this folder carry the **same IDs** as the originals, but their attribute values (category, tier, vertical, region, device, and so on) have been **regenerated**. Load the three CSVs from *this* folder and join against them — joining the new events to the old dimension tables will misattribute segments.

## What stays the same

- **Schema** — identical to the main dataset; your existing tables and pipeline should ingest this without changes.
- **Metric definitions** — `[metrics_glossary.md](../metrics_glossary.md)` remains the canonical reference. All ratio metrics are still sum / sum.
- **Seasonality** — the same daily and weekly patterns and growth trend apply. Compare against like-for-like baselines, and remember that a movement fully explained by seasonality should be checked and *ruled out*, not alarmed on.



## What to submit

Your system's output for this dataset, as specified in the problem statement:

1. The **diagnosis** - plain-language, naming the responsible segment(s), with every number computed from the data
2. The **numbers behind it** - reproducible from ClickHouse queries
3. The **trace** that proves your system generated it

Every team gets the same input at the same time, so outputs are directly comparable. Build nothing new — this is the moment your pipeline either generalizes or shows its seams.
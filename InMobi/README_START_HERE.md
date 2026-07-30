# Start Here — Click-a-thon 2026 · InMobi Problem

Welcome! This package has everything you need to start building. All data is **synthetic**.

## What's in this package

```
├── PROBLEM_STATEMENT.md     ← read this first: the challenge, rules, and how you're judged
├── metrics_glossary.md      ← exact definitions/formulas (fill rate, eCPM, CTR, revenue)
└── data/
    ├── ad_events.parquet     9,000,000 events · ~5 weeks (Jun 1 – Jul 5, 2026)
    ├── apps.csv              2,000 apps
    ├── advertisers.csv       500 advertisers
    └── geo_device.csv        5,000 geo/device profiles
```

## The data model (star schema)

One fact table of ad events, three dimension tables joined by key:

```
        apps (2K)                          advertisers (500)
   app_id, category,                 advertiser_id, vertical,
   publisher_tier                         campaign_type
            \                                 /
             \                               /
            ad_events  (9M rows)  ── the event stream
   event_time, app_id, geo_device_id, advertiser_id, ad_format,
   is_filled, is_impression, is_click, revenue
                        |
                 geo_device (5K)
      geo_device_id, region, country, device_model, os_version
```

Each row in `ad_events` is one ad request and what happened to it (`is_filled` → `is_impression` → `is_click`, with `revenue`). To slice a metric by device, geo, app, or advertiser, **join** `ad_events` to the dimension tables on the shared key. `advertiser_id` is empty when a request wasn't filled.

## Get running in ~10 minutes

1. Spin up your team's **ClickHouse Cloud** service (using your event credits).
2. Load the four files from [`data/`](data/).
3. Read [`metrics_glossary.md`](metrics_glossary.md) so your metric formulas match how you'll be judged.

## What you're building (in one line)

A system that notices when a key metric moves abnormally, **automatically investigates which segment caused it** (which device, region, app, advertiser, format), and writes a short plain-language explanation where **every number is real and computed** — ideally also saying what it ruled out.

## Deliverables (see [PROBLEM_STATEMENT.md](PROBLEM_STATEMENT.md) for full detail)

- Public GitHub repo (MIT / Apache-2.0), all code written during the 24-hour window
- ≤500-word solution summary · ≤5-minute demo video · ≤15-slide pitch deck
- ClickHouse as the primary DB + meaningful use of at least one of ClickStack / Langfuse / LibreChat
- Your system's output for the **unseen incident** dataset (released Day 2), with the trace that proves your system generated it

Good luck — build something extraordinary.

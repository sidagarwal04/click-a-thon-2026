# Metrics Glossary — Ad-Events Dataset (PUBLIC)
### ClickHouse Click-a-thon 2026 · "Automated Root-Cause Analyst"

All data is **synthetic**. No real advertiser, publisher, or user data. This page fixes the metric definitions so every team computes them identically — localization is judged on analysis quality, not on whose formula differed.

## The ad funnel

Every ad opportunity flows through: **Request → Fill → Impression → Click**, with **Revenue** earned on impressions.

```
Ad Request  ──fill?──▶  Fill  ──render?──▶  Impression  ──click?──▶  Click
                                                 │
                                              Revenue
```

## Core metrics

| Metric | Definition | Computed from `ad_events` |
|---|---|---|
| **Requests** | Ad opportunities (top of funnel) | `count(*)` |
| **Fills** | Requests answered with an ad | `sum(is_filled)` |
| **Fill rate** | Share of requests that filled | `sum(is_filled) / count(*)` |
| **Impressions** | Ads actually rendered | `sum(is_impression)` |
| **Render rate** | Share of fills that rendered as impressions | `sum(is_impression) / sum(is_filled)` |
| **Clicks** | Ads tapped | `sum(is_click)` |
| **CTR** | Click-through rate | `sum(is_click) / sum(is_impression)` |
| **Revenue** | Money earned (on impressions) | `sum(revenue)` |
| **eCPM** | Effective revenue per 1,000 impressions | `sum(revenue) / sum(is_impression) * 1000` |
| **Revenue per request (RPR)** | All-in efficiency | `sum(revenue) / count(*)` |

> Ratio metrics (fill rate, render rate, CTR, eCPM, RPR) must be computed as **sum / sum** over the rows in a group — never as an average of per-row or per-day ratios — so rollups stay correct.

## The revenue identity (use this to decompose)

```
Revenue  =  Requests  ×  Fill rate  ×  (Impressions / Fills)  ×  eCPM / 1000
```

With ~one impression per fill, this simplifies to:

```
Revenue  ≈  Requests  ×  Fill rate  ×  eCPM / 1000
```

When revenue moves, walk this identity to find *which factor* is responsible (volume? fill? price?), then slice that factor by dimension to find *which segment*. CTR is a sibling engagement/quality signal — useful context, not a direct revenue factor in this CPM model.

## Dimensions you can slice by

- **From `ad_events`:** `ad_format` — `banner, interstitial, native, rewarded, video`
- **From `apps`:** `category` — `gaming, social, entertainment, news, ecommerce, utility, finance`; `publisher_tier` — `tier_1, tier_2, tier_3`
- **From `advertisers`:** `vertical` — `gaming, ecommerce, finance, travel, entertainment, auto, cpg`; `campaign_type` — `CPM, CPC, CPI`
- **From `geo_device`:** `region` — `NAM, EU, APAC, LATAM, MEA`; `country` (e.g. US, CA, UK, DE, IN, JP, BR, MX, ZA, AE); `device_model` (iPhone / Pixel / Galaxy / Redmi models); `os_version` — `iOS 16.4/17.2/17.5/18.1`, `Android 12/13/14/15`

> Note: North America is coded **`NAM`** (not `NA`), because `NA` is read as a null value by many tools. `advertiser_id` is empty on unfilled requests (no ad was served), so `vertical`/`campaign_type` are only present for filled events.

## Notes on "normal"

The data has real **daily** (hour-of-day) and **weekly** (weekends lower) seasonality plus a slow growth trend and random noise. A flat global average makes every weekend look like an anomaly — compare against a like-for-like baseline (e.g. same weekday, trailing weeks) instead. At least one planted movement is **pure seasonality** and should be checked and ruled out, not alarmed on.

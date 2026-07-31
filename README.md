# Click-a-thon 2026

Problem packages for the **ClickHouse Click-a-thon 2026** — a 24-hour hackathon where every solution is built on [ClickHouse](https://clickhouse.com) as the primary datastore and analytical engine. All data in this repo is **synthetic**.

## The problems

Pick a track, read its start-here guide, and build.

### [InMobi](InMobi/) — From alert to answer: the automated root-cause analyst

A key business metric jumps or drops. An alert tells you *that* it moved — your system must figure out *why*: detect the deviation, drill down across app, device, geo, and advertiser dimensions to isolate the responsible segment, and produce a plain-language, evidence-backed diagnosis in seconds.

| | |
|---|---|
| Start here | [InMobi/README_START_HERE.md](InMobi/README_START_HERE.md) |
| Problem statement | [InMobi/PROBLEM_STATEMENT.md](InMobi/PROBLEM_STATEMENT.md) |
| Metric definitions | [InMobi/metrics_glossary.md](InMobi/metrics_glossary.md) |
| Data | [InMobi/data/](InMobi/data/) — 9M ad events (~5 weeks) + 3 dimension tables |

### [SonyLIV](SonyLiv/) — Counting the crowd: foreground-only concurrency at streaming scale

"How many people are watching right now?" is harder than it looks: an open app is not a watching viewer. Build a concurrency model that counts only truly active playback — excluding paused, backgrounded, and heartbeat-missing periods — and answers minute-grain, filtered dashboard queries instantly at very large scale.

| | |
|---|---|
| Start here | [SonyLiv/README_START_HERE.md](SonyLiv/README_START_HERE.md) |
| Problem statement | [SonyLiv/PROBLEM_STATEMENT.md](SonyLiv/PROBLEM_STATEMENT.md) |
| Data dictionary | [SonyLiv/dataset_details.md](SonyLiv/dataset_details.md) |
| Data | [SonyLiv/data/](SonyLiv/data/) — ~905K streaming events + ~33K content titles |

### [Atlys](Atlys/) — From feature spec to insight: agents that instrument, analyze, and explain

Every new product feature needs instrumentation, schema design, and analysis — today that loop is manual and slow. Build a system of three agents on ClickHouse that collapses it: one turns a feature spec into production-ready table schemas, one analyzes the data and writes insights a product manager would act on, and one keeps the business context layer fresh as tables are added — all fully traced.

| | |
|---|---|
| Start here | [Atlys/README_START_HERE.md](Atlys/README_START_HERE.md) |
| Problem statement | [Atlys/PROBLEM_STATEMENT.md](Atlys/PROBLEM_STATEMENT.md) |
| Base context | [Atlys/base_context.md](Atlys/base_context.md) |
| Data | [Atlys/data/](Atlys/data/) — 8 raw event tables (4-step conversion funnel + 4 supporting), ~2.5M rows |
| Feature specs | [Atlys/specs/](Atlys/specs/) — 5 specs (1-page brief + raw NDJSON) |

## Ground rules (both tracks)

- **ClickHouse is the primary datastore and analytical engine.** Load the data into your team's own ClickHouse Cloud service, provisioned with your event credits.
- **Meaningfully integrate at least one of** [ClickStack](https://clickhouse.com/use-cases/observability) (observability), [Langfuse](https://langfuse.com) (LLM observability & analytics), or [LibreChat](https://www.librechat.ai) (conversational interface). Superficial inclusion won't count.
- **Build for the unseen data.** A sealed evaluation dataset for each track is released to all teams simultaneously in the final hours of the hackathon. Your submission must include your system's output on it, with evidence it ran through your pipeline.

## Getting the data

Large data files are stored with [Git LFS](https://git-lfs.com). To clone with the real files instead of pointer stubs:

```bash
git lfs install
git clone https://github.com/sidagarwal04/click-a-thon-2026.git
```

Already cloned without LFS? Run `git lfs install && git lfs pull` inside the repo.

---

Good luck — build something extraordinary.

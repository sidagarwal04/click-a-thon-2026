# Unseen Evaluation Dataset — SonyLIV (SEALED)
### ClickHouse Click-a-thon 2026 · "Real-Time Foreground-Only Concurrency"

This is the **unseen day** promised in [`PROBLEM_STATEMENT.md`](../PROBLEM_STATEMENT.md): a fresh day of session data from the same universe, released to all teams simultaneously. Run the benchmark queries on it through your pipeline — your submission must include the answers, the query latencies, and evidence that they ran through your pipeline. **No pipeline evidence, no credit.**

## The dataset

The data files are too large for Git LFS, so they are hosted on **[Google Drive](https://drive.google.com/drive/folders/1Trn0yQbBU9y-bR2igfJCZAOa7dOWAFvh?usp=sharing)** — download both files from there:

```
├── ch-hackathon-raw-data_surprise.csv        7,000,000 events · one day of session data (Jul 31, 2026) · ~1.8 GB
└── ch-hackathon-content-data_surprise.csv    ~33K titles · metadata and content attributes · ~1.4 MB
```

## Important: the schemas have changed

Both datasets carry **one new column** each — alter your tables accordingly:

- Raw events add `video_resolution`
- Content adds `show_name`

## Raw dataset — [`ch-hackathon-raw-data_surprise.csv`](https://drive.google.com/drive/folders/1Trn0yQbBU9y-bR2igfJCZAOa7dOWAFvh?usp=sharing)

This table will be used to build further aggregated tables for calculating concurrency.

| Column | Definition | Details |
|---|---|---|
| `video_session_id` | Unique session ID for a video playback | Session-level concurrency will be derived from this ID |
| `user_id` | User ID for that playback | User-level concurrency will be derived from this ID |
| `content_id` | Content ID of the played video | Needs to be mapped to content metadata to fetch additional info; used as a filter dimension |
| `event_type` | Defines the type of video event — whether it is a direct event or a heartbeat event. Current event types: `VideoSessionStart`, `VideoPlay`, `VideoHeartbeat`, `AppBackgrounded`, `AppForegrounded`, `VideoSessionEnd`, `VideoError` | This value defines the type of event. The heartbeat event type is a periodic event which is currently passed every 1 minute. `AppBackgrounded` & `AppForegrounded` are not guaranteed events and sometimes depend on the system |
| `event` | The actual event that happened, with the above event type | Useful in case we want to track a particular event |
| `event_timestamp` | Timestamp when the event occurred | Time will be defined from this column |
| `platform` | Name of the platform | Used as a filter dimension |
| `app_version` | Name of the app version | Used as a filter dimension |
| `country` | Name of the country | Used as a filter dimension |
| `audio_language` | Name of the audio language | Used as a filter dimension |
| `subtitle_language` | Name of the subtitle language | Used as a filter dimension |
| `player_version` | Player version | Used as a filter dimension |
| `session_start_epoch` | Time when the video session started | Can be used to derive the start time at any point of time (if needed) |
| `video_resolution` | Video resolution during video playback | Used as a filter dimension **(NEW)** |

## Content dataset — [`ch-hackathon-content-data_surprise.csv`](https://drive.google.com/drive/folders/1Trn0yQbBU9y-bR2igfJCZAOa7dOWAFvh?usp=sharing)

This table will be joined in real time with the raw table and used to fetch the metadata.

| Column | Definition | Details |
|---|---|---|
| `content_id` | Content ID | Mapping ID for the raw data |
| `title` | Title of the content | Used as a filter dimension |
| `video_type` | Video type of the content | Used as a filter dimension |
| `category` | Category of the content | Used as a filter dimension |
| `show_name` | Name of the show | Used as a filter dimension **(NEW)** |

## What stays the same

- **Event semantics** — the same event types, heartbeat cadence, and foreground/background behavior as the main dataset; [`dataset_details.md`](../dataset_details.md) remains the reference for everything except the two new columns above.
- **The task** — foreground-only means foreground-only: count only truly active playback intervals, excluding backgrounded and heartbeat-missing periods.

## What to submit

Your system's output for this dataset, as specified in the problem statement:

1. Your **answers to the benchmark queries** on this data
2. The **query latencies**
3. **Evidence they ran through your pipeline** (query logs or traces)

Every team gets the same input at the same time, so correctness and latency are directly comparable. Build nothing new — this is the moment your pipeline either generalizes or shows its seams.

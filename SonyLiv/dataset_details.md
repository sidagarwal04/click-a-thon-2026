# Dataset Details — SonyLIV Streaming Datasets
### ClickHouse Click-a-thon 2026 · "Real-Time Foreground-Only Concurrency"

This page is the canonical data dictionary for the two SonyLIV datasets in [`data/`](data/): use it as the reference for field names, data types, timestamps, identifiers, and business meaning.

## Raw dataset — [`ch-hackathon-raw-data.csv`](data/ch-hackathon-raw-data.csv)

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

## Content dataset — [`ch-hackathon-content-data.csv`](data/ch-hackathon-content-data.csv)

This table will be joined in real time with the raw table and used to fetch the metadata.

| Column | Definition | Details |
|---|---|---|
| `content_id` | Content ID | Mapping ID for the raw data |
| `title` | Title of the content | Used as a filter dimension |
| `video_type` | Video type of the content | Used as a filter dimension |
| `category` | Category of the content | Used as a filter dimension |

> **Note:** In general the dataset is very large in nature. This is just a gist of the existing data and columns — the solution should work even if the number of dimensions increases.

-- Atlys: existing raw event tables.
-- Current production table definitions.

CREATE TABLE destination_card_clicked
(
    id UUID,
    timestamp DateTime,
    user_id String,
    application_id Nullable(String),
    app_session_id Nullable(String),
    device Nullable(String),
    device_type Nullable(String),
    os Nullable(String),
    app_version Nullable(String),
    client_lib Nullable(String),
    geoip_country_code Nullable(String),
    geoip_subdivision_1_code Nullable(String),
    city Nullable(String),
    client_ip Nullable(String),
    latitude Nullable(Float64),
    longitude Nullable(Float64),
    locale Nullable(String),
    language Nullable(String),
    funnel_type Nullable(String),
    co_travelers Nullable(UInt8),
    is_guest Nullable(UInt8),
    is_referral Nullable(UInt8),
    is_enterprise Nullable(UInt8),
    gclid Nullable(String),
    fbclid Nullable(String),
    gad_source Nullable(String),
    citizenship Nullable(String),
    destination Nullable(String),
    is_back_filled Nullable(UInt8),
    duplicate_id Nullable(String),
    visa_type Nullable(String),
    card_type Nullable(String),
    page_version Nullable(String),
    flow Nullable(String),
    is_guest_browse Nullable(UInt8)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(timestamp)
ORDER BY (id, timestamp, user_id);

CREATE TABLE application_started
(
    id UUID,
    timestamp DateTime,
    user_id String,
    application_id Nullable(String),
    app_session_id Nullable(String),
    device Nullable(String),
    device_type Nullable(String),
    os Nullable(String),
    app_version Nullable(String),
    client_lib Nullable(String),
    geoip_country_code Nullable(String),
    geoip_subdivision_1_code Nullable(String),
    city Nullable(String),
    client_ip Nullable(String),
    latitude Nullable(Float64),
    longitude Nullable(Float64),
    locale Nullable(String),
    language Nullable(String),
    funnel_type Nullable(String),
    co_travelers Nullable(UInt8),
    is_guest Nullable(UInt8),
    is_referral Nullable(UInt8),
    is_enterprise Nullable(UInt8),
    gclid Nullable(String),
    fbclid Nullable(String),
    gad_source Nullable(String),
    citizenship Nullable(String),
    destination Nullable(String),
    is_back_filled Nullable(UInt8),
    duplicate_id Nullable(String),
    purpose Nullable(String),
    eta_shown Nullable(String),
    flow Nullable(String)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(timestamp)
ORDER BY (id, timestamp, user_id);

CREATE TABLE document_uploaded
(
    id UUID,
    timestamp DateTime,
    user_id String,
    application_id Nullable(String),
    app_session_id Nullable(String),
    device Nullable(String),
    device_type Nullable(String),
    os Nullable(String),
    app_version Nullable(String),
    client_lib Nullable(String),
    geoip_country_code Nullable(String),
    geoip_subdivision_1_code Nullable(String),
    city Nullable(String),
    client_ip Nullable(String),
    latitude Nullable(Float64),
    longitude Nullable(Float64),
    locale Nullable(String),
    language Nullable(String),
    funnel_type Nullable(String),
    co_travelers Nullable(UInt8),
    is_guest Nullable(UInt8),
    is_referral Nullable(UInt8),
    is_enterprise Nullable(UInt8),
    gclid Nullable(String),
    fbclid Nullable(String),
    gad_source Nullable(String),
    citizenship Nullable(String),
    destination Nullable(String),
    is_back_filled Nullable(UInt8),
    duplicate_id Nullable(String),
    doc_type Nullable(String),
    capture_mode Nullable(String),
    scan_mode Nullable(String),
    retry_count Nullable(UInt8),
    failed_attempt_threshold Nullable(UInt8),
    is_crossed_failed_attempt_threshold Nullable(UInt8)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(timestamp)
ORDER BY (id, timestamp, user_id);

CREATE TABLE purchase_completed
(
    id UUID,
    timestamp DateTime,
    user_id String,
    application_id Nullable(String),
    app_session_id Nullable(String),
    device Nullable(String),
    device_type Nullable(String),
    os Nullable(String),
    app_version Nullable(String),
    client_lib Nullable(String),
    geoip_country_code Nullable(String),
    geoip_subdivision_1_code Nullable(String),
    city Nullable(String),
    client_ip Nullable(String),
    latitude Nullable(Float64),
    longitude Nullable(Float64),
    locale Nullable(String),
    language Nullable(String),
    funnel_type Nullable(String),
    co_travelers Nullable(UInt8),
    is_guest Nullable(UInt8),
    is_referral Nullable(UInt8),
    is_enterprise Nullable(UInt8),
    gclid Nullable(String),
    fbclid Nullable(String),
    gad_source Nullable(String),
    citizenship Nullable(String),
    destination Nullable(String),
    is_back_filled Nullable(UInt8),
    duplicate_id Nullable(String),
    value Nullable(Float64),
    currency Nullable(String),
    coupon_applied Nullable(UInt8),
    coupon_name Nullable(String),
    discount_amount Nullable(Float64),
    insurance_added Nullable(UInt8),
    insurance_amount Nullable(Float64),
    plan_selected Nullable(String)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(timestamp)
ORDER BY (id, timestamp, user_id);

CREATE TABLE search_typed
(
    id UUID,
    timestamp DateTime,
    user_id String,
    application_id Nullable(String),
    app_session_id Nullable(String),
    device Nullable(String),
    device_type Nullable(String),
    os Nullable(String),
    app_version Nullable(String),
    client_lib Nullable(String),
    geoip_country_code Nullable(String),
    geoip_subdivision_1_code Nullable(String),
    city Nullable(String),
    client_ip Nullable(String),
    latitude Nullable(Float64),
    longitude Nullable(Float64),
    locale Nullable(String),
    language Nullable(String),
    funnel_type Nullable(String),
    co_travelers Nullable(UInt8),
    is_guest Nullable(UInt8),
    is_referral Nullable(UInt8),
    is_enterprise Nullable(UInt8),
    gclid Nullable(String),
    fbclid Nullable(String),
    gad_source Nullable(String),
    citizenship Nullable(String),
    destination Nullable(String),
    is_back_filled Nullable(UInt8),
    duplicate_id Nullable(String),
    search_term Nullable(String),
    results_count Nullable(UInt16),
    source Nullable(String)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(timestamp)
ORDER BY (id, timestamp, user_id);

CREATE TABLE landing_page_scrolled
(
    id UUID,
    timestamp DateTime,
    user_id String,
    application_id Nullable(String),
    app_session_id Nullable(String),
    device Nullable(String),
    device_type Nullable(String),
    os Nullable(String),
    app_version Nullable(String),
    client_lib Nullable(String),
    geoip_country_code Nullable(String),
    geoip_subdivision_1_code Nullable(String),
    city Nullable(String),
    client_ip Nullable(String),
    latitude Nullable(Float64),
    longitude Nullable(Float64),
    locale Nullable(String),
    language Nullable(String),
    funnel_type Nullable(String),
    co_travelers Nullable(UInt8),
    is_guest Nullable(UInt8),
    is_referral Nullable(UInt8),
    is_enterprise Nullable(UInt8),
    gclid Nullable(String),
    fbclid Nullable(String),
    gad_source Nullable(String),
    citizenship Nullable(String),
    destination Nullable(String),
    is_back_filled Nullable(UInt8),
    duplicate_id Nullable(String),
    scroll_depth_pct Nullable(UInt8),
    time_on_page_s Nullable(UInt16),
    page_version Nullable(String)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(timestamp)
ORDER BY (id, timestamp, user_id);

CREATE TABLE auth_completed
(
    id UUID,
    timestamp DateTime,
    user_id String,
    application_id Nullable(String),
    app_session_id Nullable(String),
    device Nullable(String),
    device_type Nullable(String),
    os Nullable(String),
    app_version Nullable(String),
    client_lib Nullable(String),
    geoip_country_code Nullable(String),
    geoip_subdivision_1_code Nullable(String),
    city Nullable(String),
    client_ip Nullable(String),
    latitude Nullable(Float64),
    longitude Nullable(Float64),
    locale Nullable(String),
    language Nullable(String),
    funnel_type Nullable(String),
    co_travelers Nullable(UInt8),
    is_guest Nullable(UInt8),
    is_referral Nullable(UInt8),
    is_enterprise Nullable(UInt8),
    gclid Nullable(String),
    fbclid Nullable(String),
    gad_source Nullable(String),
    citizenship Nullable(String),
    destination Nullable(String),
    is_back_filled Nullable(UInt8),
    duplicate_id Nullable(String),
    auth_method Nullable(String),
    is_new_user Nullable(UInt8),
    attempts Nullable(UInt8)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(timestamp)
ORDER BY (id, timestamp, user_id);

CREATE TABLE pay_now_clicked
(
    id UUID,
    timestamp DateTime,
    user_id String,
    application_id Nullable(String),
    app_session_id Nullable(String),
    device Nullable(String),
    device_type Nullable(String),
    os Nullable(String),
    app_version Nullable(String),
    client_lib Nullable(String),
    geoip_country_code Nullable(String),
    geoip_subdivision_1_code Nullable(String),
    city Nullable(String),
    client_ip Nullable(String),
    latitude Nullable(Float64),
    longitude Nullable(Float64),
    locale Nullable(String),
    language Nullable(String),
    funnel_type Nullable(String),
    co_travelers Nullable(UInt8),
    is_guest Nullable(UInt8),
    is_referral Nullable(UInt8),
    is_enterprise Nullable(UInt8),
    gclid Nullable(String),
    fbclid Nullable(String),
    gad_source Nullable(String),
    citizenship Nullable(String),
    destination Nullable(String),
    is_back_filled Nullable(UInt8),
    duplicate_id Nullable(String),
    payment_method Nullable(String),
    amount Nullable(Float64),
    currency Nullable(String),
    coupon_applied Nullable(UInt8),
    plan_selected Nullable(String)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(timestamp)
ORDER BY (id, timestamp, user_id);

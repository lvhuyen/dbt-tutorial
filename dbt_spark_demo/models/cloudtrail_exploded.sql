/*
    Exploded the raw CloudTrail Event table
*/

{{ config(materialized='table', file_format='parquet', partition_by='region,dt') }}

with exploded_view as (
    select explode(records) as arr, region, dt
    from cloudtrail_raw.cloudtrail_event
),
compact_view as (
    select
        arr.eventName,
        arr.eventId,
        arr.eventSource,
        arr.eventType,
        arr.eventTime,
        arr.userIdentity.principalId,
        arr.sourceIPAddress,
        arr.requestParameters,
        arr.responseElements,
        region,
        dt
     from exploded_view
)

select *
  from compact_view

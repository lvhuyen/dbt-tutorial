{{ config(materialized='table', file_format='parquet') }}

select
    eventSource,
    eventName,
    principalId,
    count(eventSource) as cnt
from {{ ref('cloudtrail_exploded') }}
group by eventSource, eventName, principalId

{{ config(
    materialized='incremental',
    file_format='parquet',
    partition_by='dt',
    unique_key='principalId') }}

select /*+ REPARTITION(1) */
    dt,
    principalId,
    count(eventSource) as cnt
from {{ ref('cloudtrail_exploded') }}

{% if is_incremental() %}
where dt >= (select max(dt) from {{ this }})
{% endif %}

group by dt, principalId

{{ config(
    materialized='incremental',
    file_format='json',
    unique_key='principalId') }}

select
    dt,
    principalId,
    count(eventSource) as cnt
from {{ ref('cloudtrail_exploded') }}

{% if is_incremental() %}

where dt >= (select max(dt) from {{ this }})

{% endif %}

group by dt, principalId

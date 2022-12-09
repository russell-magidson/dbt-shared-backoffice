{{ config(tags = ["zexample"], schema="dm_zexample", materialized='table') }}

SELECT
*
FROM  {{ ref('dwh_zexample_v02') }}
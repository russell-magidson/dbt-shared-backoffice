{{ config(
    schema="dm_zexample",
    alias='dm_products',
    materialized='table',
    tags = ["zexample"]
    ) }}

SELECT
*
FROM  {{ ref('dwh_products__zexample') }}
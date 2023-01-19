{{ config(
    schema="dm_zexample",
    alias='dm_products_copy',
    materialized='table',
    tags = ["zexample"]
    ) }}

SELECT
*, 'newfield' as newfield
FROM  {{ ref('dwh_products__zexample') }}
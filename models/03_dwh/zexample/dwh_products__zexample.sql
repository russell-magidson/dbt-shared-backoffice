{{ config(
    schema="dwh_zexample",
    alias='dwh_products',
    materialized='table',
    tags = ["zexample"]
    ) }}

SELECT *
FROM  {{ ref('stg_products__zexample') }}
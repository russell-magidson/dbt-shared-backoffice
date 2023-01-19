{{ config(
    schema="stg_zexample",
    alias='stg_products',
    materialized='table',
    tags = ["zexample"]
    ) }}

SELECT *
FROM {{ ref('lv_products__zexample') }}
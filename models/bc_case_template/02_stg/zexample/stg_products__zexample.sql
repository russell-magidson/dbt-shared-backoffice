{{ config(
    schema="stg_zexample",
    alias='stg_products',
    materialized='table',
    tags = ["zexample"], 
    enabled = false
    ) }}

SELECT * FROM {{ source('name_source_atlanta', 'products') }}
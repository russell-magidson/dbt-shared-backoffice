{{ config(
    schema="stg_zexample",
    materialized='table',
    tags = ["zexample","other_tags"]
    ) }}

SELECT *
FROM {{ source('dbt_source_example', 'DL__EXAMPLE') }}
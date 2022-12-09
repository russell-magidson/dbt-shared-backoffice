{{ config(tags = ["zexample"], schema="dwh_zexample", materialized='table') }}

SELECT *
FROM  {{ ref('stg_zexample') }}
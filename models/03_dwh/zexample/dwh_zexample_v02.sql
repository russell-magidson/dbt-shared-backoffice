{{ config(tags = ["zexample"], schema="dwh_zexample", materialized='table',
    alias='new_name_of_the_table') }}

SELECT *
FROM  {{ ref('stg_zexample') }}
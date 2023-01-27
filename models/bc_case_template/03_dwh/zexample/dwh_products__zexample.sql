{{ config(
    schema="dm_zexample",
    alias='dm_products',
    materialized='table',
    tags = ["zexample"]
    ) }}

SELECT
vendor_name, count(distinct category_name) as categories_number, count(distint item_number) as products_number
FROM  {{ ref('stg_products__zexample') }}
group by vendor_name
order by vendor_name
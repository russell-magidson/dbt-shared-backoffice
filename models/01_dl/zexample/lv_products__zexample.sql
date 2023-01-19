{{ config(
    enabled=true,
    schema="lv_zexample",
    alias='lv_products',
    materialized="view",
    tags=["zexample"]
    ) }}

WITH last_version_of_data_table AS (
    SELECT * EXCEPT (_dl_isdeleted) FROM (
        SELECT * EXCEPT(RANKORDER) FROM (
            SELECT *,
            ROW_NUMBER() OVER (PARTITION BY item_number ORDER BY _dl_dag_ts DESC) as RANKORDER
            FROM  {{ ref('dl_products__zexample') }}
        ) WHERE RANKORDER = 1
    ) WHERE _dl_isdeleted = False
)

SELECT * FROM last_version_of_data_table

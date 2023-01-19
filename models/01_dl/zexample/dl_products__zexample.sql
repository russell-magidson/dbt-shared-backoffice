{{ config(
    enabled=true,
    schema="dl_zexample",
    alias='dl_products',
    materialized="incremental",
    on_schema_change="append_new_columns",
    tags=["zexample"],
    partition_by={
        "field": "_dl_dag_ts",
        "data_type": "datetime",
        "granularity": "day"
    })
}}


WITH CURRENT_PRELOAD AS (
    SELECT * 
    FROM {{ source('dbt_source_example', 'products') }}
), CURRENT_LOAD AS (
    SELECT *,
    FARM_FINGERPRINT(FORMAT("%.1048500T", CURRENT_PRELOAD)) AS _dl_row_hash,
    CURRENT_DATETIME() AS _dl_dag_ts,
    '{{ invocation_id }}' AS _dl_dag_run,
    False AS _dl_isdeleted
    FROM CURRENT_PRELOAD
)
{% if is_incremental() %}
, DATALAKE AS ( SELECT _dl_row_hash FROM {{ this }} )
{% endif %}

SELECT CL.*
FROM CURRENT_LOAD as CL
{% if is_incremental() %}
LEFT JOIN DATALAKE as DL USING (_dl_row_hash)
WHERE DL._dl_row_hash is null
{% endif %}
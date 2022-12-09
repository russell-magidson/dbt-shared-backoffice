{% macro datalake_append_new_data(source_dataset, source_table, isversion=True, deletions=False) %}

WITH CURRENT_PRELOAD AS (
    SELECT * {% if isversion %} EXCEPT (version) {% endif %}
    FROM {{ source(source_dataset, source_table) }}
), CURRENT_LOAD AS (
    SELECT *,
    FARM_FINGERPRINT(FORMAT("%.1048500T", CURRENT_PRELOAD)) AS _dl_row_hash,
    CURRENT_DATETIME() AS _dl_datetime,
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


{% endmacro %}
{% macro last_snapshot_of_data_table(tableref, snapshop_field='_dl_datetime') %}

WITH LAST_SNAPSHOT_OF_DATA AS (
    SELECT * FROM  {{ ref(tableref) }}
    WHERE {{ snapshop_field }} = (select max({{ snapshop_field }}) as {{ snapshop_field }} from {{ ref(tableref) }})
)
SELECT * FROM LAST_SNAPSHOT_OF_DATA

{% endmacro %}
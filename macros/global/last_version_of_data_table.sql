

{% macro last_version_of_data_table(tableref,primary_keys,datetime_field='_dl_datetime') %}

WITH LAST_VERSION_OF_DATA AS (
    SELECT * EXCEPT (_dl_isdeleted) FROM (
        SELECT * EXCEPT(RANKORDER) FROM (
            SELECT *,
            ROW_NUMBER() OVER (PARTITION BY {{ primary_keys }}
            ORDER BY {{ datetime_field }} DESC) as RANKORDER
            FROM  {{ ref(tableref) }}
        ) WHERE RANKORDER = 1
    ) WHERE _dl_isdeleted = False
)

SELECT * FROM LAST_VERSION_OF_DATA

{% endmacro %}
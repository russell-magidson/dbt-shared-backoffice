{% macro last_version_of_data_source(source_dataset,source_table,primary_keys,datetime_field='_dl_datetime') %}

WITH LAST_VERSION_OF_DATA AS (
    SELECT * EXCEPT(RANKORDER) FROM (
        SELECT *,
        ROW_NUMBER() OVER (PARTITION BY {{ primary_keys }}
        ORDER BY {{ datetime_field }} DESC) as RANKORDER
        FROM   {{ source(source_dataset, source_table) }}
    ) WHERE RANKORDER = 1
)

SELECT * FROM LAST_VERSION_OF_DATA

{% endmacro %}

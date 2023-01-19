{% macro last_version_of_data_source(source_dataset,source_table,primary_keys,datetime_field='_dl_datetime', manual_changes=False) %}

WITH last_version_of_data_source AS (
    SELECT * EXCEPT(RANKORDER) FROM (
        SELECT *,
        ROW_NUMBER() OVER (PARTITION BY {{ primary_keys }}
        ORDER BY {{ datetime_field }} DESC) as RANKORDER
        FROM   {{ source(source_dataset, source_table) }}
    ) WHERE RANKORDER = 1
)
{% if not manual_changes %}
SELECT * FROM last_version_of_data_source
{% endif %}
{% endmacro %}

# if manual_changes=True then you have to add "SELECT * FROM last_version_of_data_source" after the macro
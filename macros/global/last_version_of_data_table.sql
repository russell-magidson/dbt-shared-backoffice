

{% macro last_version_of_data_table(tableref, primary_keys, datetime_field='_dl_datetime', manual_changes=False) %}

WITH last_version_of_data_table AS (
    SELECT * EXCEPT (_dl_isdeleted) FROM (
        SELECT * EXCEPT(RANKORDER) FROM (
            SELECT *,
            ROW_NUMBER() OVER (PARTITION BY {{ primary_keys }}
            ORDER BY {{ datetime_field }} DESC) as RANKORDER
            FROM  {{ ref(tableref) }}
        ) WHERE RANKORDER = 1
    ) WHERE _dl_isdeleted = False
)

{% if not manual_changes %}
SELECT * FROM last_version_of_data_table
{% endif %}

{% endmacro %}

# if manual_changes=True then you have to add "SELECT * FROM last_version_of_data_table" after the macro
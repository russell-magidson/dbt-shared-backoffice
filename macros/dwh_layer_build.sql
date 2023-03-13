{% macro dwh_layer_build( table_name = none) -%}

    {# Generate the sql for our standard dwh layer select #}

    {% set qualTableName = 'stg_' + table_name  %}

    select *, current_timestamp() AS insert_datetime
    from {{ ref( qualTableName ) }}

{%- endmacro %}

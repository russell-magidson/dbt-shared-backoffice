-- Overwrites the dbt builtin function for generating the schema name.
-- dbt concatenates the custom schema name to the default schema name by default.
-- this macro only uses the custom schema name. 
{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}

    {%- if target.name != "prd_target" -%}
        {{ default_schema }}_{{ custom_schema_name | trim }}
    {%- else -%}
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
        {%- else -%}
            {{ custom_schema_name | trim }}
        {%- endif -%}
    {%- endif -%}

{%- endmacro %}



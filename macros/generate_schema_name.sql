-- Overwrites the dbt builtin function for generating the schema name.
-- dbt concatenates the custom schema name to the default schema name by default.
-- this macro only uses the custom schema name. 
{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}

    {%- if target.name == "sbx_target" -%}
        {# {{ default_schema }}_{{ custom_schema_name | trim }} #}
        {# {{ custom_schema_name | trim }} #}
        sbxx_{{ env_var( 'USER') }}_{{ custom_schema_name }} 

    {%- elif target.name == "tst_target" -%}
        tstt_{{ env_var( 'USER') }}_{{ custom_schema_name }} 

    {%- elif target.name == "acc_target" -%}
        accc_{{ env_var( 'USER') }}_{{ custom_schema_name }} 

    {%- elif target.name == "prd_target" -%}
        prdd_{{ env_var( 'USER') }}_{{ custom_schema_name }} 

    {%- else -%}
        {%- if custom_schema_name is none -%}
            {{ default_schema }} 
        {%- else -%}
            {{ custom_schema_name }}
        {%- endif -%}
    {%- endif -%}

{%- endmacro %}

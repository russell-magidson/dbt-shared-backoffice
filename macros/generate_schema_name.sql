-- Overwrites the dbt builtin function for generating the schema name.
-- dbt concatenates the custom schema name to the default schema name by default.
-- this macro only uses the custom schema name. 
{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}

    {%- if target.name == "sbx_target" -%}
        sbxx_{{ env_var( 'USER') }}_{{ custom_schema_name }} 

    {%- elif target.name == "dev_target" -%}
        tstt_{{ custom_schema_name }} 

    {%- elif target.name == "acc_target" -%}
        accc_{{ custom_schema_name }} 

    {%- elif target.name == "prd_target" -%}
        prdd_{{ custom_schema_name }} 

    {%- else -%} 
        {# We don't want these to kick in so we'll set a prefix to allow us to find the tables #}
        {%- if custom_schema_name is none -%}
            None_Invalid_{{ default_schema }} 
        {%- else -%}
            None_Invalid_{{ custom_schema_name }} 
        {%- endif -%}
    {%- endif -%}

{%- endmacro %}

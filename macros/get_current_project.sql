{% macro get_current_project(env="stg", node=None) -%}

    {%- if env == "stg" -%}
        {%- if target.name == "prd_target" -%} es-madridstg-prd-6ea0
        {%- elif target.name == "acc_target" -%} es-madridstg-acc-4da0
        {%- elif target.name == "tst_target" -%} es-madridstg-tst-bd51
        {%- else -%} es-madridstg-dev-095f
        {%- endif -%}
    {%- endif -%}
    {%- if env == "dwh" -%}
        {%- if target.name == "prd_target" -%} es-madriddwh-prd-62d1
        {%- elif target.name == "acc_target" -%} es-madriddwh-acc-416a
        {%- elif target.name == "tst_target" -%} es-madriddwh-tst-8dbc
        {%- else -%} es-madriddwh-dev-a56e
        {%- endif -%}
    {%- endif -%}
    {%- if env == "dm" -%}
        {%- if target.name == "prd_target"  -%} es-madriddm-prd-c7c4
        {%- elif target.name == "acc_target"  -%} es-madriddm-acc-7f03
        {%- elif target.name == "tst_target" -%} es-madriddm-tst-ded4
        {%- else -%} es-madriddm-dev-ef38
        {%- endif -%}
    {%- endif -%}

{%- endmacro %}
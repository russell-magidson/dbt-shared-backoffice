{{ config(
    tags = ["ps_project"], 
    alias = "ps_project"
    )
}}

select *
from {{ ref( 'stg_ps_project')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_project')}}
                        ) #}

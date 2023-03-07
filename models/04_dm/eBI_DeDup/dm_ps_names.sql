{{ config(
    tags = ["ps_names"], 
    alias = 'ps_names'
    )
}}

select *
from {{ ref( 'stg_ps_names')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_names')}}
                        ) #}

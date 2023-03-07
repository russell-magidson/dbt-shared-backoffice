{{ config(
    tags = ["ps_assignment"], 
    alias = "ps_assignment"
    )
}}

select *
from {{ ref( 'stg_ps_assignment')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_assignment')}}
                        ) #}

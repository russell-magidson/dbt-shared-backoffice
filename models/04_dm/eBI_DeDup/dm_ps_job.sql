{{ config(
    tags = ["ps_job"], 
    alias = "ps_job"
    )
}}

select *
from {{ ref( 'stg_ps_job')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_job')}}
                        ) #}

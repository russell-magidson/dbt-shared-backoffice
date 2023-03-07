{{ config(
    tags = ["ext_holidays"], 
    alias = "ext_holidays"
    )
}}

select *
from {{ ref( 'stg_ext_holidays')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ext_holidays')}}
                        ) #}

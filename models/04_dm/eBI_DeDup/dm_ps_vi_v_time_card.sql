{{ config(
    tags = ["ps_vi_v_time_card"], 
    alias = "ps_vi_v_time_card"
    )
}}

select *
from {{ ref( 'stg_ps_vi_v_time_card')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_vi_v_time_card')}}
                        ) #}

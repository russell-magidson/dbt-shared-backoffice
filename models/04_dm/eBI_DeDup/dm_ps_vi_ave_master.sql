{{ config(
    tags = ["ps_vi_ave_master"], 
    alias = "ps_vi_ave_master"
    )
}}

select *
from {{ ref( 'stg_ps_vi_ave_master')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_vi_ave_master')}}
                        ) #}

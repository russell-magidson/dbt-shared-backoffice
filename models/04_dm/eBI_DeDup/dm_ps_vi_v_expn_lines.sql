{{ config(
    tags = ["ps_vi_v_expn_lines"], 
    alias = "ps_vi_v_expn_lines"
    )
}}

select *
from {{ ref( 'stg_ps_vi_v_expn_lines')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_vi_v_expn_lines')}}
                        ) #}

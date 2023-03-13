{{ config(
    tags = ["ps_vi_v_time_card"], 
    alias = "ps_vi_v_time_card"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_vi_v_time_card')}}

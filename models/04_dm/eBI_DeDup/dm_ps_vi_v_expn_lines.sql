{{ config(
    tags = ["ps_vi_v_expn_lines"], 
    alias = "ps_vi_v_expn_lines"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_vi_v_expn_lines')}}

{{ config(
    tags = ["ps_vi_ave_master"], 
    alias = "ps_vi_ave_master"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_vi_ave_master')}}

{{ config(
    tags = ["ps_vi_pay_earnings"], 
    alias = "ps_vi_pay_earnings"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_vi_pay_earnings')}}

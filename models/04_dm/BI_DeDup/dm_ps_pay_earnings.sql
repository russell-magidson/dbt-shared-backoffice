{{ config(
    tags = ["ps_pay_earnings"], 
    alias = 'ps_pay_earnings'
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_pay_earnings')}}

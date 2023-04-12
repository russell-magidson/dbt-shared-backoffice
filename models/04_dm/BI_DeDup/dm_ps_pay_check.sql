{{ config(
    tags = ["ps_pay_check"], 
    alias = 'ps_pay_check'
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_pay_check')}}

{{ config(
    tags = ["ps_pay_trms_tbl"], 
    alias = "ps_pay_trms_tbl"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_pay_trms_tbl')}}

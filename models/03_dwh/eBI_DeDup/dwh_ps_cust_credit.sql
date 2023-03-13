{{ config(
    tags = ["ps_cust_credit"], 
    alias = 'ps_cust_credit'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_ps_cust_credit')}}

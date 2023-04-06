{{ config(
    tags = ["ps_cust_address"], 
    alias = 'ps_cust_address'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_ps_cust_address')}}

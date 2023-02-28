{{ config(
    tags = ["ps_customer", "dedup", "backoffice"], 
    alias = 'ps_customer'
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_customer')}}

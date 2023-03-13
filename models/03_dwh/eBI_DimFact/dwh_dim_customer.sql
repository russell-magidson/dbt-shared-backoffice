{{ config(
    tags = ["dim_customer"], 
    alias = "dim_customer"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_dim_customer")}}

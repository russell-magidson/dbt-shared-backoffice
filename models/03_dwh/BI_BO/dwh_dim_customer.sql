{{ config(
    tags = ["dim_customer", "backoffice"], 
    materialized = "incremental", 
    alias = "dim_customer"
    )
}}

with source_data as (
    select *
    from {{ ref( "stg_dim_customer")}}
)

, final as (
    select *, current_timestamp() AS insert_datetime
    from source_data
)

select *
from final

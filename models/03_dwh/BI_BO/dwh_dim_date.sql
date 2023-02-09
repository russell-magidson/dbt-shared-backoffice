{{ config(
    tags = ["dim_date", "backoffice"], 
    materialized = 'incremental', 
    alias = 'dim_date'
    )
}}

with source_data as (
    select *
    from {{ ref( 'stg_dim_date')}}
)

, final as (
    select *, current_timestamp() AS insert_datetime
    from source_data
)

select *
from final

{{ config(
    tags = ["dim_date"], 
    alias = 'dim_date'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_dim_date')}}

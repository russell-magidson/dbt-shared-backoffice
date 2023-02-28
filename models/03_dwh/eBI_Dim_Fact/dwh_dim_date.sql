{{ config(
    tags = ["dim_date", "backoffice"], 
    materialized = 'incremental', 
    alias = 'dim_date'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_dim_date')}}

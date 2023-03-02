{{ config(
    tags = ["dim_department"], 
    materialized = "incremental", 
    alias = "dim_department"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_dim_department")}}

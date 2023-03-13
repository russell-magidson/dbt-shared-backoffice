{{ config(
    tags = ["dim_employee"], 
    alias = "dim_employee"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_dim_employee")}}

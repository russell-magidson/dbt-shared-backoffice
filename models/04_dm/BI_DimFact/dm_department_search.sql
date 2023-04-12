{{ config(
    tags = ["department_search"], 
    alias = "department_search"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_department_search")}}

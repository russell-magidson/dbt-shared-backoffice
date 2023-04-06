{{ config(
    tags = ["department_search_all_levels"], 
    alias = "department_search_all_levels"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_department_search_all_levels")}}

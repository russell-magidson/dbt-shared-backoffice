{{ config(
    tags = ["department_dynamic_hierarchy"], 
    alias = "department_dynamic_hierarchy"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_department_dynamic_hierarchy")}}

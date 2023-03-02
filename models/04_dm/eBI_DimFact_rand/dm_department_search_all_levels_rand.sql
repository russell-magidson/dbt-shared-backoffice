{{ config(
    tags = ["department_search_all_levels"], 
    alias = "department_search_all_levels"
    )
}}

select *
from {{ ref( 'dm_department_search_all_levels')}}


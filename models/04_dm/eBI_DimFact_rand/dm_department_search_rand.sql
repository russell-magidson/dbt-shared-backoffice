{{ config(
    tags = ["department_search"], 
    alias = "department_search"
    )
}}

select *
from {{ ref( 'dm_department_search')}}

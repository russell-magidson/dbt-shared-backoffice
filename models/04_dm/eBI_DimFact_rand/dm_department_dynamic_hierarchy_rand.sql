{{ config(
    tags = ["department_dynamic_hierarchy"], 
    alias = "department_dynamic_hierarchy"
    )
}}

select *
from {{ ref( 'dm_department_dynamic_hierarchy')}}

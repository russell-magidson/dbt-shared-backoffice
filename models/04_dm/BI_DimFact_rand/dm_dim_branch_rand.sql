{{ config(
    tags = ["dim_branch"], 
    alias = "dim_branch"
    )
}}

select *, branch as branch_id
from {{ ref( 'dm_dim_department')}}
where UNIT LIKE '%U'

{{ config(
    tags = ["dim_department"], 
    alias = "dim_department"
    )
}}

select *
from {{ ref( 'dm_dim_department')}}

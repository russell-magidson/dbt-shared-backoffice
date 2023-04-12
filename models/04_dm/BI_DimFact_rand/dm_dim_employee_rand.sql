{{ config(
    tags = ["dim_employee"], 
    alias = "dim_employee"
    )
}}

select *
from {{ ref( 'dm_dim_employee')}}

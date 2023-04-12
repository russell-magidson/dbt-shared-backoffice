{{ config(
    tags = ["dim_date"], 
    alias = "dim_date"
    )
}}

select *
from {{ ref( 'dm_dim_date')}}
